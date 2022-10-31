module SuperLU_DIST

using SparseArrays
using SparseArrays: SparseMatrixCSC
import SparseArrays: nnz
using MPI
using SuperLU_DIST_jll
const libsuperlu_defs = SuperLU_DIST_jll.libsuperlu_dist_Int32
const libsuperlu_ddefs = SuperLU_DIST_jll.libsuperlu_dist_Int32
const libsuperlu_sdefs = SuperLU_DIST_jll.libsuperlu_dist_Int32
include("../lib/libsuperlu_dist32.jl")

import Base: (\), size, getproperty, setproperty!, propertynames, show

# Convert from 1-based to 0-based indices
function decrement!(A::AbstractArray{T}) where T<:Integer
    for i in eachindex(A); A[i] -= oneunit(T) end
    A
end
decrement(A::AbstractArray{<:Integer}) = decrement!(copy(A))

# Convert from 0-based to 1-based indices
function increment!(A::AbstractArray{T}) where T<:Integer
    for i in eachindex(A); A[i] += oneunit(T) end
    A
end
increment(A::AbstractArray{<:Integer}) = increment!(copy(A))
end

