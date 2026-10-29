# Solve a distributed linear system with SuperLU_DIST's communication-avoiding 3D algorithm.
# The 3D counterpart of pdrive.jl and SuperLU_DIST's EXAMPLE/pddrive3d.c.
#
# Run with, for example, 8 ranks on a 2 × 2 × 2 grid:
#
#     mpiexecjl -n 8 julia --project examples/pdrive3d.jl 2
#
# The optional argument is npdep, the number of 2D layers (a power of two, default 2 on an
# even number of ranks, otherwise 1). The rest of the ranks form an nprow × npcol grid in
# each layer.
using MPI
using SuperLUDIST
using SuperLUDIST: Grid3D, DistributedSuperMatrix, Options, pgssvx!
using SparseBase
using SparseBase.Communication: distribute_evenly, localsize, scatterstore!
using MatrixMarket
using LinearAlgebra

MPI.Init()
comm = MPI.COMM_WORLD
nprocs = MPI.Comm_size(comm)
npdep = isempty(ARGS) ? (iseven(nprocs) ? 2 : 1) : parse(Int, ARGS[1])
nprocs % npdep == 0 || error("npdep = $npdep must divide the number of ranks, $nprocs")
# Make each layer's 2D grid as square as possible.
nprow = maximum(d for d in 1:isqrt(nprocs ÷ npdep) if (nprocs ÷ npdep) % d == 0)
npcol = nprocs ÷ npdep ÷ nprow
nrhs = 3
root = 0

grid = Grid3D{Int64}(nprow, npcol, npdep, comm)
iam = grid.iam
iam == root && println("3D grid: $nprow × $npcol × $npdep")

# On single nodes this helps prevent oversubscription of threads.
SuperLUDIST.superlu_set_num_threads(Int64, 1)

# Read the matrix on the root and generate a known solution and right-hand sides.
# coo is held only on root, b and xtrue are replicated on each rank.
coo, b, xtrue = SuperLUDIST.mmread_and_generatesolution(
    Float64, Int64, nrhs, joinpath(@__DIR__, "add32.mtx"), grid; root
)

# The 3D drivers take a matrix distributed by rows over all the ranks of the 3D grid.
csr = iam == root ? convert(SparseBase.CSRStore, coo) : nothing
chunksizes = iam == root ? distribute_evenly(size(csr, 1), nprocs) : nothing
A = scatterstore!(DistributedSuperMatrix{Float64, Int64}(grid), csr, chunksizes; root)
rows = A.first_row:(A.first_row + localsize(A, 1) - 1)

# Factorize and solve. The default options are those of SuperLU_DIST.
b_local = b[rows, :]
x, F = pgssvx!(A, b_local; options = Options{Int64}(; PrintStat = SuperLUDIST.Common.NO))

# Reuse the factorization for another right-hand side.
y = F \ (2 .* b[rows, 1])

# The relative error over all ranks.
relerr(x, y) = sqrt(MPI.Allreduce(norm(x - y)^2, +, comm) / MPI.Allreduce(norm(y)^2, +, comm))
ex = relerr(x, xtrue[rows, :])
ey = relerr(y, 2 .* xtrue[rows, 1])
iam == root && println("relative error: $ex (factorize and solve), $ey (reused factorization)")

# PStatPrint is collective, so it must be called on every rank. It prints the statistics of
# the first layer.
SuperLUDIST.PStatPrint(F)

MPI.Finalize()
