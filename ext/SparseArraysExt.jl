module SparseArraysExt

using SuperLUDIST: SuperLUDIST, ReplicatedSuperMatrix, Grid, cscstore
using SparseArrays: AbstractSparseMatrixCSC

"""
    ReplicatedSuperMatrix(A::SparseMatrixCSC, grid::Grid{Ti})

Copy `A` into a `ReplicatedSuperMatrix` with index type `Ti`. Every rank in `grid` must
pass the same matrix.
"""
function SuperLUDIST.ReplicatedSuperMatrix(
    A::AbstractSparseMatrixCSC{Tv}, grid::Grid{Ti}
) where {Tv <: Union{Float32, Float64, ComplexF64}, Ti <: Union{Int32, Int64}}
    return ReplicatedSuperMatrix(cscstore(Tv, Ti, A), grid)
end

end
