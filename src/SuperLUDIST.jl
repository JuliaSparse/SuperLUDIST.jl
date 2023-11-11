module SuperLUDIST
using SparseBase
using MPI
include("libs.jl")
using CIndices: CIndex
using DocStringExtensions
using MatrixMarket
using SuperLUBase
using SuperLUBase.Common
using OpenBLAS32_jll # FIX after support for user binary.
using LinearAlgebra

function __init__()
    if VERSION ≥ v"1.9"
      config = LinearAlgebra.BLAS.lbt_get_config()
      if !any(lib -> lib.interface == :lp64, config.loaded_libs)
        LinearAlgebra.BLAS.lbt_forward(OpenBLAS32_jll.libopenblas_path)
      end
    end
    # LinearAlgebra.BLAS.set_num_threads(1)
    #superlu_set_num_threads(Int32, 1)
    #superlu_set_num_threads(Int64, 1)
end

include("../lib/common.jl")
include("../lib/libsuperlu_dist32.jl")
include("../lib/libsuperlu_dist64.jl")
using .SuperLUDIST_Common
using .SuperLU_Int32
using .SuperLU_Int64
import Base: (\), size, getproperty, setproperty!, propertynames, show

using SparseBase: AbstractSparseStore, indexeltype, storedeltype
using SparseBase.Communication
const nstored = SparseBase.nstored
export ReplicatedSuperMatrix, DistributedSuperMatrix, 
    nstored

function prefixsymbol(::Type{T}) where T
    T === Float32 && (return :s)
    T === Float64 && (return :d)
    T === ComplexF32 && (return :c)
    T === ComplexF64 && (return :z)
end
function prefixname(::Type{T}, name::Symbol) where T
    Symbol(prefixsymbol(T), name)
    Symbol(prefixsymbol(T), name)
    Symbol(prefixsymbol(T), name)
    Symbol(prefixsymbol(T), name)
end

function toslutype(::Type{T}) where T
    T === Float32 && (return Common.SLU_S)
    T === Float64 && (return Common.SLU_D)
    T === ComplexF32 && (return Common.SLU_C)
    T === ComplexF64 && (return Common.SLU_Z)
end

abstract type AbstractSuperMatrix{Tv, Ti, S} <: AbstractMatrix{Tv} end
function Base.getproperty(S::AbstractSuperMatrix, s::Symbol)
    s === :supermatrix && return Base.getfield(S, s)
    s === :store && return Base.getfield(S, s)
    s === :format && return Base.getfield(S, s)
    s === :globalsize && return Base.getfield(S, s)
    s === :first_row && return Base.getfield(S, s)
    s === :grid && return Base.getfield(S, s)
    return getproperty(S.supermatrix[], s)
end
# TODO: move to SuperLUBase.jl
Base.unsafe_convert(
    T::Type{Ptr{SuperMatrix{I}}}, 
    A::AbstractSuperMatrix{<:Any, I}
) where {I <: Union{Int32, Int64}} = 
    Base.unsafe_convert(T, A.supermatrix)

include("lowlevel.jl")
include("structs.jl")
include("distributedmatrix.jl")
include("replicatedmatrix.jl")
include("drivers.jl")
include("matrixmarket.jl")
include("highlevel.jl")
end

