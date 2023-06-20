using MPI
using SuperLUDIST: Grid, DistributedSuperMatrix,
pgssvx!
using SuperLUDIST
using SparseBase.Communication
using SparseBase.Communication: distribute_evenly, localsize
using MatrixMarket
using SparseBase
using CIndices
MPI.Init()
nprow, npcol, nrhs = 2, 2, 1
root = 0
comm = MPI.COMM_WORLD
grid = Grid{Int32}(nprow, npcol, comm)
iam = grid.iam
isroot = iam == root

# Utility function for reading a .mtx file and generating suitable
# rhs and x for testing. 
# coo is held only on root, b and xtrue are replicated on each rank.
coo, b, xtrue = SuperLUDIST.mmread_and_generatesolution(
    Float64, Int32, nrhs, joinpath(@__DIR__, "add32.mtx"), grid; root, comm
)
csr = isroot ? convert(SparseBase.CSRStore, coo) : nothing
chunksizes = isroot ? distribute_evenly(size(csr, 1), nprow * npcol) : nothing

# If constructing from existing per-node data the following constructors will help:
# A = DistributedSuperMatrix(store::CSRStore, firstrow, globalsize::NTuple{2, Int})
# store = CSRStore(ptrs, indices, values, localsize::NTuple{2, Int})
# @show iam csr
A = Communication.scatterstore!(
    DistributedSuperMatrix{Float64, Int32}(), csr, chunksizes; root, comm)

b_local = b[A.first_row : A.first_row + localsize(A, 1) - 1, :] # shrink b
xtrue_local = xtrue[A.first_row : A.first_row + localsize(A, 1) - 1, :] # shrink xtrue


# everything below this point will be used by all users.
# everything above simply prepares A and b which will differ
# for each user.

# creating options and stat is optional, they will be created if not provided.
options = SuperLUDIST.Options()
stat = SuperLUDIST.LUStat{Int32}()

pgssvx!(A, b_local, grid; options, stat)

if !(iam == root)
    SuperLUDIST.inf_norm_error_dist(b_local, xtrue_local, grid)
end
SuperLUDIST.PStatPrint(options, stat, grid)

# @show iam b_local xtrue_local
MPI.Finalize()
