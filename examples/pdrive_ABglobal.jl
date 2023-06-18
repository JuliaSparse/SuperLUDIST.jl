using MPI
using SuperLUDIST
using SuperLUDIST: Grid, Options, LUStat, ScalePermStruct,
    ReplicatedSuperMatrix, pgssvx!
using SuperLUDIST.Common
using MatrixMarket
nprow, npcol, nrhs = Int64.((2, 1, 1))
root = 0
comm = MPI.COMM_WORLD
grid = Grid{Int64}(nprow, npcol, comm)
iam = grid.iam

# This function handles broadcasting internally!
A = MatrixMarket.mmread(
    ReplicatedSuperMatrix{Float64, Int64}, 
    joinpath(@__DIR__, "cage3.mtx")
)

m, n, = size(A)
xtrue = Matrix{Float64}(undef, n, nrhs)
b = Matrix{Float64}(undef, m, nrhs)

if iam == root
    SuperLUDIST.GenXtrue_dist!(xtrue, Int64)
    SuperLUDIST.FillRHS_dist!(b, A, xtrue)
end
MPI.Bcast!(b, root, comm)
MPI.Bcast!(xtrue, root, comm)

iam == root && (@show b xtrue)
options = Options()

LU = SuperLUDIST.LUStruct{Float64, Int64}(n, grid)
stat = LUStat{Int64}()

b, perm, LU, stat2 = pgssvx!(A, b, grid; options, stat)

if !(iam == root)
    SuperLUDIST.inf_norm_error_dist(b, xtrue, grid)
end
SuperLUDIST.PStatPrint(options, stat2, grid)

MPI.Finalize()