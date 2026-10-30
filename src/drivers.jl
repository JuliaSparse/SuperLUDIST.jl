"""
    $(TYPEDSIGNATURES)

Solve the replicated sparse linear system `Ax = b`, overwriting `b`
with the solution.

Returns `b` and the factor object which may be used
to solve with different `b` or reuse parts of the factorization with different
values for `A`.
"""
function pgssvx!(
    A::ReplicatedSuperMatrix{Tv, Ti},
    b::VecOrMat{Tv};
    options = Options{Ti}(),
    perm = ScalePerm{Tv, Ti}(size(A)...),
    LU = LUFactors{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}(),
    berr = Vector{real(Tv)}(undef, size(b, 2))
) where {Tv, Ti}
    return pgssvx!(SuperLUFactorization(A, options, nothing, perm, LU, stat, berr, b), b)
end
function pgssvx!(
    A::ReplicatedSuperMatrix{Tv, Ti};
    options = Options{Ti}(),
    perm = ScalePerm{Tv, Ti}(size(A)...),
    LU = LUFactors{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}()
) where {Tv, Ti}
    b = Matrix{Tv}(undef, size(A, 1), 0)
    return pgssvx!(A, b; options, perm, LU, stat)
end

"""
    $(TYPEDSIGNATURES)

Solve the distributed sparse linear system `Ax = b`, overwriting `b`
with the solution. On a [`Grid3D`](@ref) this uses SuperLU_DIST's 3D `pgssvx3d` drivers.

Returns `b` and the factor object which may be used
to solve with different `b` or reuse parts of the factorization with different
values for `A`.
"""
function pgssvx!(
    A::DistributedSuperMatrix{Tv, Ti},
    b::VecOrMat{Tv};
    options = Options{Ti}(),
    Solve = SolveData{Tv, Ti}(options, A.grid),
    perm = ScalePerm{Tv, Ti}(size(A)...),
    LU = LUFactors{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}(),
    berr = Vector{real(Tv)}(undef, size(b, 2))
) where {Tv, Ti}
    return pgssvx!(SuperLUFactorization(A, options, Solve, perm, LU, stat, berr, b), b)
end
function pgssvx!(
    A::DistributedSuperMatrix{Tv, Ti};
    options = Options{Ti}(),
    Solve = SolveData{Tv, Ti}(options, A.grid),
    perm = ScalePerm{Tv, Ti}(size(A)...),
    LU = LUFactors{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}(),
) where {Tv, Ti}
    b = Matrix{Tv}(undef, SparseBase.Communication.localsize(A, 1), 0)
    pgssvx!(A, b; options, Solve, perm, LU, stat)
end

# SuperLU_DIST reads and writes as many rows of each column of `b` as this rank holds of
# the matrix: all of them for a replicated matrix, and this rank's rows for a distributed one.
function rhserror(A::ReplicatedSuperMatrix, b)
    size(b, 1) == size(A, 1) && return nothing
    return DimensionMismatch("b has $(size(b, 1)) rows, but the matrix has $(size(A, 1)).")
end
function rhserror(A::DistributedSuperMatrix, b)
    m_loc = Communication.localsize(A, 1)
    size(b, 1) == m_loc && return nothing
    return DimensionMismatch(
        "b has $(size(b, 1)) rows, but this rank holds $m_loc rows of the matrix. " *
        "A distributed b holds this rank's rows of the right-hand side."
    )
end

# SuperLU_DIST tracks part of the state of `F`'s structs in its options, and reads them
# uninitialized when the options say otherwise, as when the options of one factorization
# are passed to another.
function facterror(F::SuperLUFactorization)
    (; options, solve, factors) = F
    fact = options.Fact
    # SamePattern only reuses the column permutation in `F.perm`.
    if !factors.factored && fact != Common.DOFACT && fact != Common.SamePattern
        return ArgumentError(
            "options.Fact = $fact reuses a factorization, but this one has not been " *
            "computed. Factorize with options.Fact = DOFACT, and new options for each " *
            "factorization."
        )
    end
    solve === nothing && return nothing
    solve.options === options ||
        return ArgumentError("The SolveData must be created with the options of the solve.")
    # `gstrs_comm` is only allocated when the triangular solve is set up.
    if options.SolveInitialized == Common.YES && solve.gstrs_comm == C_NULL
        return ArgumentError(
            "The options were used to solve with another SolveData. Use new options for " *
            "each factorization."
        )
    end
    return nothing
end

# The drivers are collective over the grid, so throw on all of its ranks when the
# arguments are wrong on some of them, rather than leave the others waiting in the driver.
function checkargs(F::SuperLUFactorization, b)
    err = something(rhserror(F.mat, b), facterror(F), Some(nothing))
    grid = F.mat.grid
    failed = err !== nothing
    if ingrid(grid)
        failed = MPI.Allreduce(Int(failed), max, gridcomm(grid)) > 0
    end
    failed || return nothing
    throw(something(err, ArgumentError("The arguments are wrong on another rank of the grid.")))
end

function pgssvx!(F::SuperLUFactorization{T, I, <:ReplicatedSuperMatrix{T, I}}, b::VecOrMat{T}) where {T, I}
    (; mat, options, perm, factors, stat) = F
    checkargs(F, b)
    if length(F.berr) != size(b, 2)
        F.berr = Vector{real(T)}(undef, size(b, 2))
    end
    b, _ = pgssvx_ABglobal!(options, mat, perm, b, factors, F.berr, stat)
    factors.factored = true
    F.options.Fact = Common.FACTORED
    F.nrhs = size(b, 2)
    return b, F
end
function pgssvx!(F::SuperLUFactorization{T, I, <:DistributedSuperMatrix{T, I}}, b::VecOrMat{T}) where {T, I}
    (; mat, options, solve, perm, factors, stat) = F
    checkargs(F, b)
    if length(F.berr) != size(b, 2)
        F.berr = Vector{real(T)}(undef, size(b, 2))
    end
    # The triangular solve communication pattern depends on nrhs.
    if solve.nrhs != size(b, 2) && options.SolveInitialized == Common.YES
        pgstrs_prep!(F)
        pgstrs_init!(
            F.solve, size(F.mat, 2), Communication.localsize(F.mat, 1), size(b, 2),
            F.mat.first_row - 1, F.perm, F.factors, F.mat.grid
        )
    end

    b, _ = pgssvx_ABdist!(options, mat, perm, b, factors, solve, F.berr, stat)
    factors.factored = true
    F.options.Fact = Common.FACTORED
    F.nrhs = solve.nrhs = size(b, 2)
    return b, F
end

for T ∈ (Float32, Float64, ComplexF64)
for I ∈ (Int32, Int64)
L = Symbol(:SuperLU_, Symbol(I))
@eval begin
function pgssvx_ABglobal!(
    options,
    A::ReplicatedSuperMatrix{$T, $I},
    perm::ScalePerm{$T, $I},
    b::Array{$T},
    LU::LUFactors{$T, $I},
    berr, stat::LUStat{$I}
)
    nrhs = size(b, 2)
    # Work around two bugs in SuperLU_DIST's single precision replicated driver:
    # - psgsrfs_ABXglobal (iterative refinement) stores each `berr[j]` with an
    #   `MPI_Allreduce(..., MPI_DOUBLE, ...)` into the `float *berr`, writing 4 bytes past
    #   the end of the array. Give it room for that, and a scratch buffer to write into.
    #   https://github.com/xiaoyeli/superlu_dist/issues/237
    # - With equilibration, psgssvx_ABglobal broadcasts its `float` scale factors with
    #   `MPI_DOUBLE`, overflowing them on every rank but the root, so turn it off there.
    #   https://github.com/xiaoyeli/superlu_dist/issues/238
    berr_c = $T === Float32 ? Vector{Float32}(undef, nrhs + 1) : berr
    if $T === Float32 && A.grid.nprow * A.grid.npcol > 1 && options.Equil == Common.YES
        options.Equil = Common.NO
    end
    info = Ref{Int32}()
    $L.$(Symbol(:p, prefixsymbol(T), :gssvx_ABglobal))(
        options, A, perm, b, max(1, size(b, 1)), nrhs,
        A.grid, LU, berr_c, stat, info
    )
    $T === Float32 && copyto!(berr, 1, berr_c, 1, nrhs)
    info[] == 0 ||
        error("Error INFO = $(info[]) from p$(prefixsymbol($T))gssvx_ABglobal")
    return b, perm, LU, stat
end
function pgssvx_ABdist!(
    options,
    A::DistributedSuperMatrix{$T, $I},
    perm::ScalePerm{$T, $I},
    b::Array{$T},
    LU::LUFactors{$T, $I},
    Solve::SolveData{$T, $I},
    berr, stat::LUStat{$I}
)
    info = Ref{Int32}()
    $L.$(Symbol(:p, prefixsymbol(T), :gssvx))(
    options, A, perm, b, max(1, size(b, 1)), size(b, 2),
    A.grid, LU, Solve, berr, stat, info
    )
    info[] == 0 ||
        error("Error INFO = $(info[]) from p$(prefixsymbol($T))gssvx")
    return b, perm, LU, stat
end
function inf_norm_error_dist(x::Array{$T}, xtrue::Array{$T}, grid::AbstractGrid{$I})
    $L.$(prefixname(T, :inf_norm_error_dist))(
        $I(size(x, 1)), $I(size(x, 2)),
        x, $I(size(x, 1)),
        xtrue, $I(size(xtrue, 1)),
        grid
    )
end
function pgstrs_init!(
    solve::SolveData{$T, $I},
    n, m_local, nrhs, first_row,
    scaleperm::ScalePerm{$T, $I},
    lu::LUFactors{$T, $I},
    grid::AbstractGrid{$I}
)
    $L.$(Symbol(:p, prefixsymbol(T), :gstrs_init))(
        n, m_local, nrhs, first_row, scaleperm.perm_r,
        scaleperm.perm_c, grid, lu.Glu_persist, solve
    )
    return solve
end

function pgstrs_prep!(
    F::SuperLUFactorization{$T, $I}
)
    # Free the buffers allocated by `pgstrs_init`, as `pxgstrs_finalize` does, but keep
    # `gstrs_comm` itself for the next `pgstrs_init`.
    gstrs = unsafe_load(F.solve.gstrs_comm)
    $L.superlu_free_dist(gstrs.B_to_X_SendCnt)
    $L.superlu_free_dist(gstrs.X_to_B_SendCnt)
    $L.superlu_free_dist(gstrs.ptr_to_ibuf)
    return F
end

end
end
end

"""
    inf_norm_error_dist(x::Matrix, xtrue::Matrix, grid::AbstractGrid)

Print the relative infinity norm error of each column of the solution `x` against `xtrue`,
with SuperLU\\_DIST's `inf_norm_error_dist`. It only uses this rank's data and does no
communication, so with a distributed `x` each rank prints the error of its own rows.
"""
inf_norm_error_dist
