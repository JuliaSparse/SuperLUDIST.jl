module SuperLU_DIST
using SparseBase
using SparseArrays
using MPI
using SuperLU_DIST_jll
using CIndices: CIndex

include("../lib/common.jl")
include("../lib/libsuperlu_dist32.jl")
include("../lib/libsuperlu_dist64.jl")
using .Common
using .SuperLU_Int32
using .SuperLU_Int64
import Base: (\), size, getproperty, setproperty!, propertynames, show


function prefixname(::Type{T}, name::Symbol) where T
    T === Float32 && (return Symbol(:s, name))
    T === Float64 && (return Symbol(:d, name))
    T === ComplexF32 && (return Symbol(:c, name))
    T === ComplexF64 && (return Symbol(:z, name))
end

function toslutype(::Type{T}) where T
    T === Float32 && (return Common.SLU_S)
    T === Float64 && (return Common.SLU_D)
    T === ComplexF32 && (return Common.SLU_C)
    T === ComplexF64 && (return Common.SLU_Z)
end

include("lowlevel.jl")
include("structs.jl")
include("communication.jl")
end

