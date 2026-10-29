module SuperLUDIST
using SparseBase
using MPI
include("libs.jl")
using CIndices: CIndex
using DocStringExtensions
using MatrixMarket
using OpenBLAS32_jll
using LinearAlgebra

function __init__()
    # SuperLU_DIST_jll calls BLAS through libblastrampoline with the LP64 (32-bit
    # integer) interface. Julia only loads ILP64 BLAS by default, so forward an LP64
    # OpenBLAS unless the user has already provided one.
    config = LinearAlgebra.BLAS.lbt_get_config()
    if !any(lib -> lib.interface == :lp64, config.loaded_libs)
        LinearAlgebra.BLAS.lbt_forward(OpenBLAS32_jll.libopenblas_path)
    end
end

include("../lib/common.jl")
include("../lib/libsuperlu_dist32.jl")
include("../lib/libsuperlu_dist64.jl")
using .SuperLUDIST_Common
using .SuperLU_Int32
using .SuperLU_Int64
const Common = SuperLUDIST_Common
import Base: (\), size, getproperty, setproperty!, propertynames, show

using SparseBase: AbstractSparseStore, indexeltype, storedeltype
using SparseBase.Communication
const nstored = SparseBase.nstored
export ReplicatedSuperMatrix, DistributedSuperMatrix,
    nstored

"""
    libmodule(::Type{Ti})

The module holding the generated bindings for SuperLU_DIST built with index type `Ti`.
"""
libmodule(::Type{Int32}) = SuperLU_Int32
libmodule(::Type{Int64}) = SuperLU_Int64

function prefixsymbol(::Type{T}) where T
    T === Float32 && (return :s)
    T === Float64 && (return :d)
    T === ComplexF32 && (return :c)
    T === ComplexF64 && (return :z)
end
prefixname(::Type{T}, name::Symbol) where T = Symbol(prefixsymbol(T), name)

function toslutype(::Type{T}) where T
    T === Float32 && (return Common.SLU_S)
    T === Float64 && (return Common.SLU_D)
    T === ComplexF32 && (return Common.SLU_C)
    T === ComplexF64 && (return Common.SLU_Z)
end

# The generated C structs are immutable so that their layout matches C (they may be
# stored inline in other structs). Julia holds them in a `Ref` to give them a stable
# address, and these helpers read and update them in place.
"""
    cref(T)

A zero-initialized `Ref{T}` for the C struct `T`.
"""
function cref(::Type{T}) where T
    r = Ref{T}()
    GC.@preserve r ccall(:memset, Ptr{Cvoid}, (Ptr{Cvoid}, Cint, Csize_t),
        Base.unsafe_convert(Ptr{T}, r), 0, sizeof(T))
    return r
end

"""
    setfield_ref!(r::Ref{T}, name::Symbol, v)

Set field `name` of the immutable struct held in `r` to `v`.
"""
function setfield_ref!(r::Base.RefValue{T}, name::Symbol, v) where T
    x = r[]
    i = Base.fieldindex(T, name, false)
    i == 0 && throw(ArgumentError("$(nameof(T)) has no field $name"))
    r[] = T(ntuple(j -> j == i ? convert(fieldtype(T, j), v) : getfield(x, j), Val(fieldcount(T)))...)
    return v
end

abstract type AbstractSuperMatrix{Tv, Ti, S} <: AbstractMatrix{Tv} end
function Base.getproperty(S::AbstractSuperMatrix, s::Symbol)
    s ∈ fieldnames(typeof(S)) && return Base.getfield(S, s)
    return getproperty(S.supermatrix[], s)
end
Base.unsafe_convert(::Type{Ptr{S}}, A::AbstractSuperMatrix{<:Any, <:Any, S}) where S =
    Base.unsafe_convert(Ptr{S}, A.supermatrix)

include("lowlevel.jl")
include("structs.jl")
include("distributedmatrix.jl")
include("replicatedmatrix.jl")
include("drivers.jl")
include("matrixmarket.jl")
include("highlevel.jl")
end
