# Drivers for SuperLU_DIST's communication-avoiding 3D factorization (`pgssvx3d`), used for
# a `DistributedSuperMatrix` on a `Grid3D`. `pgssvx!(A, b)`, `lu!` and `\` in drivers.jl and
# highlevel.jl dispatch here.

const DistributedSuperMatrix3D{T, I} =
    DistributedSuperMatrix{T, I, <:Any, <:Any, <:Any, <:Grid3D{I}}

function pgssvx!(F::SuperLUFactorization{T, I, <:DistributedSuperMatrix3D{T, I}}, b::VecOrMat{T}) where {T, I}
    (; mat, options, solve, perm, factors, stat) = F
    checkrhs(mat, b)
    nrhs = size(b, 2)
    if solve.A3d == C_NULL
        # pgssvx3d sets up the gathered matrix `A3d` when it factorizes from scratch.
        options.Fact == Common.DOFACT || throw(ArgumentError(
            "The first 3D solve must factorize from scratch, with options.Fact = DOFACT."
        ))
    elseif options.Fact != Common.DOFACT && nrhs > 0
        # pgssvx3d sets up the redistribution of B between the 2D layers when it factorizes
        # from scratch, for the number of right-hand sides of that call (at least 1), and
        # every later call reuses it, also to refactorize with SamePattern. Solve in blocks
        # of that many columns, zero padding the last one.
        k = max(F.nrhs, 1)
        if nrhs != k
            B = reshape(b, size(b, 1), nrhs)
            X = zeros(T, size(b, 1), k)
            berr = Vector{real(T)}(undef, k)
            F.berr = Vector{real(T)}(undef, nrhs)
            for j in 1:k:nrhs
                cols = j:min(j + k - 1, nrhs)
                X[:, 1:length(cols)] .= view(B, :, cols)
                fill!(view(X, :, (length(cols) + 1):k), zero(T))
                pgssvx_ABdist!(options, mat, perm, X, factors, solve, berr, stat)
                # Only the first block refactorizes.
                factors.factored = true
                options.Fact = Common.FACTORED
                B[:, cols] .= view(X, :, 1:length(cols))
                F.berr[cols] .= view(berr, 1:length(cols))
            end
            return b, F
        end
    end
    dofact = options.Fact == Common.DOFACT
    length(F.berr) == nrhs || (F.berr = Vector{real(T)}(undef, nrhs))
    b, _ = pgssvx_ABdist!(options, mat, perm, b, factors, solve, F.berr, stat)
    factors.factored = true
    F.options.Fact = Common.FACTORED
    dofact && (F.nrhs = nrhs)
    return b, F
end

for T ∈ (Float32, Float64, ComplexF64)
for I ∈ (Int32, Int64)
L = Symbol(:SuperLU_, Symbol(I))
@eval begin
function pgssvx_ABdist!(
    options,
    A::DistributedSuperMatrix3D{$T, $I},
    perm::ScalePerm{$T, $I},
    b::Array{$T},
    LU::LUFactors{$T, $I},
    Solve::SolveData{$T, $I},
    berr, stat::LUStat{$I}
)
    Solve.grid === A.grid ||
        throw(ArgumentError("The SolveData of a 3D solve must be created with the matrix's Grid3D."))
    info = Ref{Int32}()
    $L.$(Symbol(:p, prefixsymbol(T), :gssvx3d))(
        options, A, perm, b, max(1, size(b, 1)), size(b, 2),
        A.grid, LU, Solve, berr, stat, info
    )
    info[] == 0 ||
        error("Error INFO = $(info[]) from p$(prefixsymbol($T))gssvx3d")
    return b, perm, LU, stat
end
end
end
end
