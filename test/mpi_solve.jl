# Run under MPI with 1 or 4 ranks, see runtests.jl.
using SuperLUDIST
using SuperLUDIST: Grid, Options, pgssvx!, Common
using MPI
using SparseArrays
using SparseBase
using MatrixMarket
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

@testset "API, $Ti" for Ti in (Int32, Int64)
    Tv = Float64
    rank = MPI.Comm_rank(comm)
    grid = Grid{Ti}(nprow, npcol, comm)
    S = testmatrix(Tv, 12)
    n = size(S, 1)
    xtrue = Tv[mod1(i, 7) + mod1(j, 3) for i in 1:n, j in 1:2]
    b = S * xtrue
    tol = tolerance(Tv)
    opts() = Options{Ti}(; quiet...)
    # This rank's block of rows, as `distribute_evenly` splits them.
    counts = distribute_evenly(n, nprow * npcol)
    rows = (sum(counts[1:rank]) + 1):sum(counts[1:(rank + 1)])

    @testset "grid" begin
        @test (grid.nprow, grid.npcol) == (nprow, npcol)
        @test grid.iam == rank
        @test :iam in propertynames(grid)
        g = Grid{Ti}(nprow, npcol, comm; batch = true)
        @test (g.nprow, g.npcol) == (nprow, npcol)
        @test 0 <= g.iam < nprow * npcol
        # A grid smaller than the communicator: the other ranks are not part of it.
        g1 = Grid{Ti}(1, 1, comm)
        rank == root && @test g1.iam == 0
    end

    @testset "internal structs" begin
        CIndex = SuperLUDIST.CIndex
        @test SuperLUDIST.ScalePerm{Tv, CIndex{Ti}}(n, n) isa SuperLUDIST.ScalePerm{Tv, Ti}
        @test SuperLUDIST.LUFactors{Tv, CIndex{Ti}}(n, grid) isa SuperLUDIST.LUFactors{Tv, Ti}
        @test SuperLUDIST.LUStat{CIndex{Ti}}() isa SuperLUDIST.LUStat{Ti}
        @test SuperLUDIST.SolveData{Tv, CIndex{Ti}}(Options{Ti}()) isa SuperLUDIST.SolveData{Tv, Ti}
        if Ti === Int
            # The index type defaults to Int.
            @test SuperLUDIST.ScalePerm{Tv}(n, n) isa SuperLUDIST.ScalePerm{Tv, Int}
            @test SuperLUDIST.LUFactors{Tv}(n, grid) isa SuperLUDIST.LUFactors{Tv, Int}
            @test SuperLUDIST.LUStat() isa SuperLUDIST.LUStat{Int}
            @test SuperLUDIST.SolveData{Tv}(Options()) isa SuperLUDIST.SolveData{Tv, Int}
        end
    end

    @testset "replicated matrices" begin
        A = ReplicatedSuperMatrix(SuperLUDIST.cscstore(Tv, Ti, S), grid)
        @test A.nrow == n # forwarded to the C SuperMatrix
        @test SparseBase.Communication.localpart(A) === A.store
        @test size(ReplicatedSuperMatrix{Tv, Ti}(grid)) == (0, 0)
        # From a 1-based coordinate store.
        I_, J_, V = findnz(S)
        coo = SparseBase.CoordinateStore((Ti.(I_), Ti.(J_)), V, size(S))
        x, _ = pgssvx!(ReplicatedSuperMatrix(coo, grid), copy(b); options = opts())
        @test relerr(x, xtrue) < tol
        # From a coordinate store with 0-based `CIndex` indices.
        CIndex = SuperLUDIST.CIndex
        coo = SparseBase.CoordinateStore((CIndex{Ti}.(I_), CIndex{Ti}.(J_)), V, size(S))
        x, _ = pgssvx!(ReplicatedSuperMatrix(coo, grid), copy(b); options = opts())
        @test relerr(x, xtrue) < tol

        # Factorize without a right hand side, then solve.
        _, F = pgssvx!(ReplicatedSuperMatrix(S, grid); options = opts())
        @test SuperLUDIST.isfactored(F)
        @test relerr(F \ b, xtrue) < tol
        B = copy(b)
        @test ldiv!(F, B) === B
        @test relerr(B, xtrue) < tol
        SuperLUDIST.PStatPrint(F) # collective

        # SuperLU_DIST's test problem generators.
        x0 = SuperLUDIST.GenXtrue_dist!(Matrix{Tv}(undef, n, 2), Ti)
        b0 = SuperLUDIST.FillRHS_dist!(similar(x0), ReplicatedSuperMatrix(S, grid), x0)
        @test b0 ≈ S * x0
        bt = SuperLUDIST.FillRHS_dist!(similar(x0), ReplicatedSuperMatrix(S, grid), x0; trans = true)
        @test bt ≈ transpose(S) * x0
    end

    @testset "distributed matrices" begin
        Sl = S[rows, :]
        # From this rank's rows in CSR form (1-based).
        T = sparse(transpose(Sl))
        A = DistributedSuperMatrix(
            Ti.(T.colptr), Ti.(T.rowval), T.nzval, first(rows), size(Sl), size(S), grid
        )
        @test size(A) == size(S)
        @test A.first_row == first(rows)
        x, _ = pgssvx!(A, b[rows, :]; options = opts())
        @test relerr(x, xtrue[rows, :]) < tol

        # From this rank's rows in coordinate form (1-based, local row numbers).
        I_, J_, V = findnz(Sl)
        A = DistributedSuperMatrix((Ti.(I_), Ti.(J_)), V, first(rows), size(Sl), size(S), grid)
        # Factorize without a right hand side, then solve.
        _, F = pgssvx!(A; options = opts())
        @test relerr(F \ b[rows, :], xtrue[rows, :]) < tol
        # The same, with 0-based `CIndex` indices.
        CIndex = SuperLUDIST.CIndex
        A = DistributedSuperMatrix(
            (CIndex{Ti}.(I_), CIndex{Ti}.(J_)), V, first(rows), size(Sl), size(S), grid
        )
        x, _ = pgssvx!(A, b[rows, :]; options = opts())
        @test relerr(x, xtrue[rows, :]) < tol
    end

    @testset "Matrix Market" begin
        path = MPI.bcast(rank == root ? tempname() * ".mtx" : nothing, comm; root)
        rank == root && MatrixMarket.mmwrite(path, S)
        MPI.Barrier(comm)

        A = MatrixMarket.mmread(ReplicatedSuperMatrix{Tv, Ti}, path, grid)
        @test size(A) == size(S)
        x, _ = pgssvx!(A, copy(b); options = opts())
        @test relerr(x, xtrue) < tol

        A = MatrixMarket.mmread(DistributedSuperMatrix{Tv, Ti}, path, grid)
        @test size(A) == size(S)
        @test A.first_row == first(rows)
        F = lu!(A, b[rows, :]; options = opts())
        @test relerr(F \ b[rows, :], xtrue[rows, :]) < tol

        coo, b2, x2 = SuperLUDIST.mmread_and_generatesolution(Tv, Ti, 2, path, grid; root)
        @test (rank == root) == (coo !== nothing)
        @test size(b2) == size(x2) == (n, 2)
        @test b2 ≈ S * x2
        x, _ = pgssvx!(ReplicatedSuperMatrix(S, grid), copy(b2); options = opts())
        @test relerr(x, x2) < tol
        if rank == root # these print the error
            SuperLUDIST.inf_norm_error_dist(x, x2, grid)
            SuperLUDIST.inf_norm_error_dist(Ti(n), Ti(2), x, Ti(n), x2, Ti(n), grid)
        end

        MPI.Barrier(comm)
        rank == root && rm(path)
    end

    @testset "threads" begin
        @test SuperLUDIST.superlu_set_num_threads(Ti, 1) === nothing
    end
end

# 3D process grids, which use the communication-avoiding pgssvx3d drivers. The rows of the
# matrix are distributed over all the ranks of the 3D grid.
grids3d = nprocs == 4 ? [(1, 2, 2), (2, 1, 2), (1, 1, 4)] : [(1, 1, 1)]
@testset "3D $dims, $Tv, $Ti" for dims in grids3d, Tv in (Float32, Float64, ComplexF64), Ti in (Int32, Int64)
    grid = SuperLUDIST.Grid3D{Ti}(dims..., comm)
    @test (grid.nprow, grid.npcol, grid.npdep) == dims
    @test grid.iam == MPI.Comm_rank(comm)
    @test 0 <= grid.zscp.Iam < dims[3]
    @test :npdep in propertynames(grid)
    S = testmatrix(Tv, 12)
    n = size(S, 1)
    xtrue = Tv[mod1(i, 7) + mod1(j, 3) for i in 1:n, j in 1:2]
    b = S * xtrue
    isroot = grid.iam == root
    csr = isroot ? convert(SparseBase.CSRStore, SuperLUDIST.coostore(Tv, Ti, S)) : nothing
    chunksizes = isroot ? distribute_evenly(n, nprocs) : nothing
    A = scatterstore!(DistributedSuperMatrix{Tv, Ti}(grid), csr, chunksizes; root)
    @test size(A) == size(S)
    rows = A.first_row:(A.first_row + localsize(A, 1) - 1)

    F = lu!(A, b[rows, :]; options = Options{Ti}(; quiet...))
    GC.gc()
    @test SuperLUDIST.isfactored(F)
    @test relerr(F \ b[rows, :], xtrue[rows, :]) < tolerance(Tv)
    # Other numbers of right hand sides are solved in blocks of the factorization's.
    @test relerr(F \ b[rows, 1:1], xtrue[rows, 1:1]) < tolerance(Tv)
    GC.gc()
    B = [b[rows, :] b[rows, 1:1]]
    @test ldiv!(F, B) === B
    @test relerr(B, [xtrue[rows, :] xtrue[rows, 1:1]]) < tolerance(Tv)
    @test relerr(F \ b[rows, 1], xtrue[rows, 1]) < tolerance(Tv) # a vector
    SuperLUDIST.PStatPrint(F) # collective, prints on layer 0

    # Factorize without a right hand side, then solve.
    A = scatterstore!(DistributedSuperMatrix{Tv, Ti}(grid), csr, chunksizes; root)
    _, F = pgssvx!(A; options = Options{Ti}(; quiet...))
    GC.gc()
    @test relerr(F \ b[rows, :], xtrue[rows, :]) < tolerance(Tv)
end

@testset "3D grid checks" begin
    @test_throws ArgumentError SuperLUDIST.Grid3D{Int64}(1, 1, 3, comm)
    if nprocs == 4
        # Matrix Market files can be read straight onto a 3D grid.
        grid = SuperLUDIST.Grid3D{Int64}(1, 2, 2, comm)
        S = testmatrix(Float64, 12)
        xtrue = [mod1(i, 7) + 0.0 for i in 1:size(S, 1)]
        b = S * xtrue
        path = MPI.bcast(grid.iam == root ? tempname() * ".mtx" : nothing, comm; root)
        grid.iam == root && MatrixMarket.mmwrite(path, S)
        MPI.Barrier(comm)
        A = MatrixMarket.mmread(DistributedSuperMatrix{Float64, Int64}, path, grid)
        rows = A.first_row:(A.first_row + localsize(A, 1) - 1)
        x, _ = pgssvx!(A, b[rows, 1:1]; options = Options{Int64}(; quiet...))
        @test relerr(vec(x), xtrue[rows]) < tolerance(Float64)
        MPI.Barrier(comm)
        grid.iam == root && rm(path)
    end
end
end

MPI.Finalize()
