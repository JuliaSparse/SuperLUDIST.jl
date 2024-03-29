# ENV["OMP_NUM_THREADS"] = 1
using MPI
using SuperLUDIST: Grid, DistributedSuperMatrix,
pgssvx!, pgssvx_ABdist!, pgstrs_prep!, pgstrs_init!
using SuperLUDIST
using SparseBase.Communication
using SparseBase.Communication: distribute_evenly, localsize
using MatrixMarket
using SparseBase
using LinearAlgebra
MPI.Init()
nprow, npcol, nrhs = 1, 1, 3
root = 0
comm = MPI.COMM_WORLD
grid = Grid{Int32}(nprow, npcol, comm)
iam = grid.iam
isroot = iam == root

# Utility function for reading a .mtx file and generating suitable
# rhs and x for testing. 
# coo is held only on root, b and xtrue are replicated on each rank.
coo, b, xtrue = SuperLUDIST.mmread_and_generatesolution(
    Float64, Int32, nrhs, joinpath(@__DIR__, "add32.mtx"), grid; root
)
csr = isroot ? convert(SparseBase.CSRStore, coo) : nothing
chunksizes = isroot ? distribute_evenly(size(csr, 1), nprow * npcol) : nothing

# on single nodes this will help prevent oversubscription of threads.
SuperLUDIST.superlu_set_num_threads(Int64, 2)

# If constructing from existing per-node data the following constructors will help:
# A = DistributedSuperMatrix(store::CSRStore, firstrow, globalsize::NTuple{2, Int})
# store = CSRStore(ptrs, indices, values, localsize::NTuple{2, Int})
# @show iam csr
A = Communication.scatterstore!(
    DistributedSuperMatrix{Float64, Int32}(grid), csr, chunksizes; root)

b_local = b[A.first_row : A.first_row + localsize(A, 1) - 1, :] # shrink b
xtrue_local = xtrue[A.first_row : A.first_row + localsize(A, 1) - 1, :] # shrink xtrue


# everything below this point will be used by all users.
# everything above simply prepares A and b which will differ
# for each user.

# creating options and stat is optional, they will be created if not provided.

# b1 = Matrix{Float64}(undef, localsize(A, 2), 2)
b1 = rand(localsize(A, 1), 0)
_, F = pgssvx!(A, b1);
b_local, F = pgssvx!(F, b_local);
if !(iam == root) || (nprow * npcol == 1)
    SuperLUDIST.inf_norm_error_dist(b_local, xtrue_local, grid)
end
SuperLUDIST.PStatPrint(F)

# @show iam b_local xtrue_local
MPI.Finalize()
