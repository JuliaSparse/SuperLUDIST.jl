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
    berr = Vector{Tv}(undef, size(b, 2))
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
    berr = Vector{Tv}(undef, size(b, 2))
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

function pgssvx!(F::SuperLUFactorization{T, I, <:ReplicatedSuperMatrix{T, I}}, b::VecOrMat{T}) where {T, I}
    (; mat, options, perm, factors, stat) = F
    if length(F.berr) != size(b, 2)
        F.berr = Vector{T}(undef, size(b, 2))
    end
    b, _ = pgssvx_ABglobal!(options, mat, perm, b, factors, F.berr, stat)
    factors.factored = true
    F.options.Fact = Common.FACTORED
    F.b = b
    return b, F
end
function pgssvx!(F::SuperLUFactorization{T, I, <:DistributedSuperMatrix{T, I}}, b::VecOrMat{T}) where {T, I}
    (; mat, options, solve, perm, factors, stat) = F
    currentnrhs = size(F.b, 2)
    if currentnrhs != size(b, 2)
        F.berr = Vector{T}(undef, size(b, 2))
        # The triangular solve communication pattern depends on nrhs.
        if options.SolveInitialized == Common.YES
            pgstrs_prep!(F)
            m_loc, fst_row = solve_rows(F)
            pgstrs_init!(
                F.solve, size(F.mat, 2), m_loc, size(b, 2), fst_row, F.perm,
                F.factors, F.mat.grid
            )
        end
    end

    b, _ = pgssvx_ABdist!(options, mat, perm, b, factors, solve, F.berr, stat)
    factors.factored = true
    F.options.Fact = Common.FACTORED
    F.b = b
    return b, F
end

# This rank's rows of the matrix that the triangular solve works on (0-based first row).
solve_rows(F::SuperLUFactorization{<:Any, <:Any, <:DistributedSuperMatrix}) =
    (Communication.localsize(F.mat, 1), F.mat.first_row - 1)

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
    berr_c = $T === Float32 ? Vector{$T}(undef, nrhs + 1) : berr
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
with SuperLU_DIST's `inf_norm_error_dist`. It only uses this rank's data.
"""
inf_norm_error_dist
