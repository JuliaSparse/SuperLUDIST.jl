# Run under MPI with 1 or 4 ranks, see runtests.jl.
using SuperLUDIST
using SuperLUDIST: Grid, Options, pgssvx!, Common
using MPI
using SparseArrays
using SparseBase
using SparseBase.Communication: distribute_evenly, localsize, scatterstore!
using LinearAlgebra
using Test

MPI.Init()
const comm = MPI.COMM_WORLD
const nprocs = MPI.Comm_size(comm)
const nprow, npcol = nprocs == 4 ? (2, 2) : (1, nprocs)
const root = 0

# A nonsymmetric, diagonally dominant 2D convection-diffusion style matrix.
function testmatrix(::Type{Tv}, k) where Tv
    T = spdiagm(-1 => fill(-1.0, k - 1), 0 => fill(4.0, k), 1 => fill(-0.5, k - 1))
    A = kron(sparse(I, k, k), T) + kron(spdiagm(-1 => fill(-1.0, k - 1), 1 => fill(-1.0, k - 1)), sparse(I, k, k))
    Tv <: Complex && (A = A + im * spdiagm(0 => fill(0.5, k^2)))
    return SparseMatrixCSC{Tv, Int}(A)
end

tolerance(::Type{Tv}) where Tv = sqrt(eps(real(Tv)))
relerr(x, y) = norm(x - y) / norm(y)

const quiet = (; PrintStat = Common.NO)

@testset "rank $(MPI.Comm_rank(comm))" begin
@testset "$Tv, $Ti" for Tv in (Float32, Float64, ComplexF64), Ti in (Int32, Int64)
    grid = Grid{Ti}(nprow, npcol, comm)
    S = testmatrix(Tv, 12)
    n = size(S, 1)
    xtrue = Tv[mod1(i, 7) + mod1(j, 3) for i in 1:n, j in 1:2]
    b = S * xtrue

    @testset "replicated" begin
        A = ReplicatedSuperMatrix(SuperLUDIST.cscstore(Tv, Ti, S), grid)
        @test size(A) == size(S)
        x, F = pgssvx!(A, copy(b); options = Options{Ti}(; quiet...))
        # A GC right after a solve catches writes past the end of Julia-owned buffers.
        GC.gc()
        @test relerr(x, xtrue) < tolerance(Tv)
        @test SuperLUDIST.isfactored(F)
        # Reuse the factorization, with a different number of right hand sides.
        @test relerr(F \ b[:, 1:1], xtrue[:, 1:1]) < tolerance(Tv)
        GC.gc()
        @test relerr(F \ [b b], [xtrue xtrue]) < tolerance(Tv)

        # SparseArrays extension
        x, _ = pgssvx!(ReplicatedSuperMatrix(S, grid), copy(b); options = Options{Ti}(; quiet...))
        GC.gc()
        @test relerr(x, xtrue) < tolerance(Tv)
    end

    @testset "distributed" begin
        isroot = grid.iam == root
        csr = isroot ? convert(SparseBase.CSRStore, SuperLUDIST.coostore(Tv, Ti, S)) : nothing
        chunksizes = isroot ? distribute_evenly(n, nprow * npcol) : nothing
        A = scatterstore!(DistributedSuperMatrix{Tv, Ti}(grid), csr, chunksizes; root)
        @test size(A) == size(S)
        rows = A.first_row:(A.first_row + localsize(A, 1) - 1)
        F = lu!(A, b[rows, :]; options = Options{Ti}(; quiet...))
        @test relerr(F \ b[rows, :], xtrue[rows, :]) < tolerance(Tv)
        # A different number of right hand sides re-initializes the triangular solve.
        @test relerr(F \ b[rows, 1:1], xtrue[rows, 1:1]) < tolerance(Tv)
        @test relerr(F \ [b[rows, :] b[rows, :]], [xtrue[rows, :] xtrue[rows, :]]) < tolerance(Tv)
    end
end
end

MPI.Finalize()
