# Drivers for SuperLU_DIST's communication-avoiding 3D factorization (`pgssvx3d`), used for
# a `DistributedSuperMatrix` on a `Grid3D`. `pgssvx!(A, b)`, `lu!` and `\` in drivers.jl and
# highlevel.jl dispatch here.

const DistributedSuperMatrix3D{T, I} =
    DistributedSuperMatrix{T, I, <:Any, <:Any, <:Any, <:Grid3D{I}}

function pgssvx!(F::SuperLUFactorization{T, I, <:DistributedSuperMatrix3D{T, I}}, b::VecOrMat{T}) where {T, I}
    (; mat, options, solve, perm, factors, stat) = F
    if options.Fact == Common.FACTORED
        # pgssvx3d sets up the redistribution of B between the 2D layers when it factorizes,
        # for the number of right-hand sides of that call (at least 1), and every later solve
        # must use that many. Solve in blocks of that many columns.
        k = max(size(F.b, 2), 1)
        nrhs = size(b, 2)
        if nrhs != k
            B = reshape(b, size(b, 1), nrhs)
            X = zeros(T, size(b, 1), k)
            length(F.berr) == k || (F.berr = Vector{T}(undef, k))
            for j in 1:k:nrhs
                cols = j:min(j + k - 1, nrhs)
                fill!(X, zero(T))
                X[:, 1:length(cols)] .= view(B, :, cols)
                pgssvx_ABdist!(options, mat, perm, X, factors, solve, F.berr, stat)
                B[:, cols] .= view(X, :, 1:length(cols))
            end
            return b, F
        end
    end
    length(F.berr) == size(b, 2) || (F.berr = Vector{T}(undef, size(b, 2)))
    b, _ = pgssvx_ABdist!(options, mat, perm, b, factors, solve, F.berr, stat)
    factors.factored = true
    F.options.Fact = Common.FACTORED
    F.b = b
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
