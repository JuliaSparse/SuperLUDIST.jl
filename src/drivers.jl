"""
    $(TYPEDSIGNATURES)

Solve the replicated sparse linear system `Ax = b`, overwriting `b`
with the solution. 

Returns `b` and the factor object which may be used
to solve with different `b` or reuse parts of the factorization different
values values for A.
"""
function pgssvx!(
    A::ReplicatedSuperMatrix{Tv, Ti},
    b::VecOrMat{Tv};
    options = Options(),
    perm = ScalePerm{Tv, Ti}(size(A)...),
    LU = LUFactors{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}(),
    berr = Vector{Tv}(undef, size(b, 2))
) where {Tv, Ti}
    return pgssvx!(SuperLUFactorization(A, options, nothing, perm, LU, stat, berr, b), b)
end
function pgssvx!(
    A::ReplicatedSuperMatrix{Tv, Ti};
    options = Options(),
    perm = ScalePerm{Tv, Ti}(size(A)...),
    LU = LUFactors{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}()
) where {Tv, Ti}
    return pgssvx!(SuperLUFactorization(A, options, nothing, perm, LU, stat, berr, b), b)
end

"""
    $(TYPEDSIGNATURES)

Solve the distributed sparse linear system `Ax = b`, overwriting `b`
with the solution. 

Returns `b` and the factor object which may be used
to solve with different `b` or reuse parts of the factorization different
values values for A.
"""
function pgssvx!(
    A::DistributedSuperMatrix{Tv, Ti},
    b::VecOrMat{Tv};
    options = Options(),
    Solve = SolveData{Tv, Ti}(options),
    perm = ScalePerm{Tv, Ti}(size(A)...),
    LU = LUFactors{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}(),
    berr = Vector{Tv}(undef, size(b, 2))
) where {Tv, Ti}
    return pgssvx!(SuperLUFactorization(A, options, Solve, perm, LU, stat, berr, b), b)
end
function pgssvx!(
    A::DistributedSuperMatrix{Tv, Ti};
    options = Options(),
    Solve = SolveData{Tv, Ti}(options),
    perm = ScalePerm{Tv, Ti}(size(A)...),
    LU = LUFactors{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}(),
) where {Tv, Ti}
    b = Matrix{Tv}(undef, SparseBase.Communication.localsize(A, 1), 0)
    pgssvx!(A, b; options, Solve, perm, LU, stat)
end

function pgssvx!(F::SuperLUFactorization{T, I, <:ReplicatedSuperMatrix{T, I}}, b::VecOrMat{T}) where {T, I}
    (; mat, options, perm, factors, stat, berr) = F
    b, _ = pgssvx_ABglobal!(options, mat, perm, b, factors, berr, stat)
    F.options.Fact = Common.FACTORED
    F.b = b
    return b, F
end
function pgssvx!(F::SuperLUFactorization{T, I, <:DistributedSuperMatrix{T, I}}, b::VecOrMat{T}) where {T, I}
    (; mat, options, solve, perm, factors, stat, berr) = F
    currentnrhs = size(F.b, 2)
    if currentnrhs != size(b, 2)
        F = pgstrs_prep!(F)
        pgstrs_init!(
            F.solve, 
            reverse(Communication.localsize(F.mat))...,
            size(b, 2), F.mat.first_row - 1, F.perm,
            F.factors, F.mat.grid
        )
    end

    b, _ = pgssvx_ABdist!(options, mat, perm, b, factors, solve, berr, stat)
    F.options.Fact = Common.FACTORED
    F.b = b
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
    info = Ref{Int32}()
    $L.$(Symbol(:p, prefixsymbol(T), :gssvx_ABglobal))(
        options, A, perm, b, size(b, 1), size(b, 2),
        A.grid, LU, berr, stat, info
    )
    # TODO: error handle
    info[] == 0 || throw(ArgumentError("Something wrong :)"))
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
    options, A, perm, b, size(b, 1), size(b, 2),
    A.grid, LU, Solve, berr, stat, info
    )
    info[] == 0 ||
        error("Error INFO = $(info[]) from pgssvx")
    return b, perm, LU, stat
end
function inf_norm_error_dist(x::Array{$T}, xtrue::Array{$T}, grid::Grid{$I})
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
    grid::Grid{$I}
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
    if size(F.b, 2) != 0
        gstrs = unsafe_load(F.solve.gstrs_comm)
        $L.superlu_free_dist(gstrs.B_to_X_SendCnt)
        $L.superlu_free_dist(gstrs.X_to_B_SendCnt)
        $L.superlu_free_dist(gstrs.ptr_to_ibuf)
    else # there has been no gstrs_comm malloc'd, so do that.

    end
    return F
end

end
end
end
