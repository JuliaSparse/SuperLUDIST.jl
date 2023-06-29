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
    perm = ScalePermStruct{Tv, Ti}(size(A)...),
    LU = LUStruct{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}(),
    berr = Vector{Tv}(undef, size(b, 2))
) where {Tv, Ti}
    grid = A.grid
    b, _ = pgssvx_ABglobal!(options, A, perm, b, LU, berr, stat)
    return b, SuperLUFactorization(A, options, nothing, perm, LU, stat, berr)
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
    Solve = SOLVE{Tv, Ti}(options),
    perm = ScalePermStruct{Tv, Ti}(size(A)...),
    LU = LUStruct{Tv, Ti}(size(A, 2), A.grid),
    stat = LUStat{Ti}(),
    berr = Vector{Tv}(undef, size(b, 2))
) where {Tv, Ti}
    grid = A.grid
    b, _ = pgssvx_ABdist!(options, A, perm, b, LU, Solve, berr, stat)
    return b, SuperLUFactorization(A, options, Solve, perm, LU, stat, berr)
end

"""
    $(TYPEDSIGNATURES)

Solve the sparse linear system `Ax = b` using an existing factorization of `A` held in `F`.

Returns `b` and a new factorization object which may alias some of `F`.
"""
function pgssvx!(
    F::SuperLUFactorization{T, I},
    b::VecOrMat{T}
) where {T, I}
    options = copy(F.options)
    options.Fact = Common.FACTORED
    stat = LUStat{I}()
    pgstrs_prep!(F)
    solve = pgstrs_init(
        F.solve, size(F.A, 2), localsize(F.A, 1), size(b, 2), 
        F.A.first_row, F.perm, F.lu, 
    )
end

for T ∈ (Float32, Float64, ComplexF64)
for I ∈ (Int32, Int64)
L = Symbol(:SuperLU_, Symbol(I))
@eval begin
function pgssvx_ABglobal!(
    options,
    A::ReplicatedSuperMatrix{$T, $I},
    perm::ScalePermStruct{$T, $I},
    b::Array{$T},
    LU::LUStruct{$T, $I},
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
    perm::ScalePermStruct{$T, $I},
    b::Array{$T},
    LU::LUStruct{$T, $I},
    Solve::SOLVE{$T, $I},
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
    solve::SOLVE{$T, $I},
    n, m_local, nrhs, first_row,
    scaleperm::ScalePermStruct{$T, $I},
    lu::LUStruct{$T, $I},
    grid::Grid{$I}
)
    $L(Symbol(:p, prefixsymbol(T), :gstrs_init))(
        n, m_local, nrhs, first_row, scaleperm.perm_r,
        scaleperm.perm_c, grid, lu.Glu_persist, solve
    )
    return solve
end

function pgstrs_prep!(
    F::SuperLUFactorization{$T, $I}
)
    gstrs = F.solve.gstrs_comm[]
    $L.superlu_free_dist(gstrs.B_to_X_SendCnt)
    gstrs.B_to_X_SendCnt[] = C_NULL
    $L.superlu_free_dist(gstrs.X_to_B_SendCnt)
    gstrs.X_to_B_SendCnt[] = C_NULL
    $L.superlu_free_dist(gstrs.ptr_to_ibuf)
    gstrs.ptr_to_ibuf[] = C_NULL
    F.solve.gstrs_comm[] = gstrs # is this necessary? Think yes.
    return F
end

end
end
end
