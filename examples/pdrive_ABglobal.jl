using MPI
using SuperLUDIST
using SuperLUDIST: Grid, Options, LUStat, ScalePermStruct,
    ReplicatedSuperMatrix, pgssvx!
using SuperLUDIST.Common
using MatrixMarket
nprow, npcol, nrhs = (2, 2, 1)
root = 0
MPI.Init()
comm = MPI.COMM_WORLD
grid = Grid{Int}(nprow, npcol, comm)
iam = grid.iam

# This function handles broadcasting internally!
A = MatrixMarket.mmread(
    ReplicatedSuperMatrix{Float64, Int}, 
    joinpath(@__DIR__, "add32.mtx"),
    grid
)

# on single nodes this will help prevent oversubscription of threads.
SuperLUDIST.superlu_set_num_threads(Int64, 2)

m, n, = size(A)
xtrue = Matrix{Float64}(undef, n, nrhs)
b = Matrix{Float64}(undef, m, nrhs)

if iam == root
    SuperLUDIST.GenXtrue_dist!(xtrue, Int64)
    SuperLUDIST.FillRHS_dist!(b, A, xtrue)
end
MPI.Bcast!(b, root, comm)
MPI.Bcast!(xtrue, root, comm)

b, F = pgssvx!(A, b)

if !(iam == root) || (nprow * npcol == 1)
    SuperLUDIST.inf_norm_error_dist(b, xtrue, grid)
end
SuperLUDIST.PStatPrint(F)

MPI.Finalize()
