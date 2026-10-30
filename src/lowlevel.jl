for T ∈ (Float32, Float64, ComplexF64)
for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
@eval begin
    function GenXtrue_dist!(xtrue::Array{$T}, n::$I, nrhs::$I, ldx = n)
        $L.$(prefixname(T, :GenXtrue_dist))(n, nrhs, xtrue, ldx)
    end
    function FillRHS_dist!(b, A::AbstractSuperMatrix{$T, $I}, xtrue::Array{$T}, trans, nrhs, ldx, ldb)
        trans = trans ? Ref{Cchar}('T') : Ref{Cchar}('N')
        $L.$(prefixname(T, :FillRHS_dist))(trans, nrhs, xtrue, ldx, A, b, ldb)
    end

    function ScalePermstructFree(r::Base.RefValue{$L.$(prefixname(T, :ScalePermstruct_t))})
        $L.$(prefixname(T, :ScalePermstructFree))(r)
    end
    function ScalePermstructInit(r::Base.RefValue{$L.$(prefixname(T, :ScalePermstruct_t))}, m, n)
        $L.$(prefixname(T, :ScalePermstructInit))(m, n, r)
        return finalizer(r) do x
            !MPI.Finalized() && ScalePermstructFree(x)
        end
    end
    function LUstructFree(r::Base.RefValue{$L.$(prefixname(T, :LUstruct_t))})
        $L.$(prefixname(T, :LUstructFree))(r)
    end
    function Destroy_LU(r::Base.RefValue{$L.$(prefixname(T, :LUstruct_t))}, n, grid)
        $L.$(prefixname(T, :Destroy_LU))(n, grid, r)
    end
    function LUstructInit(r::Base.RefValue{$L.$(prefixname(T, :LUstruct_t))}, n)
        $L.$(prefixname(T, :LUstructInit))(n, r)
        return r
    end
end
end
end

"""
    GenXtrue_dist!(xtrue::Matrix, Ti = Int)

Fill `xtrue` with SuperLU\\_DIST's test solution (`GenXtrue_dist`), for example to build a
right-hand side with [`FillRHS_dist!`](@ref). `Ti` selects the SuperLU\\_DIST library.
"""
function GenXtrue_dist!(xtrue, ::Type{Ti} = Int) where Ti
    GenXtrue_dist!(xtrue, Ti(size(xtrue, 1)), Ti(size(xtrue, 2)))
    return xtrue
end

"""
    FillRHS_dist!(b, A::ReplicatedSuperMatrix, xtrue; trans = false)

Compute the right-hand side `b = A * xtrue` (or `transpose(A) * xtrue`) with SuperLU\\_DIST's
`FillRHS_dist`, and return `b`.
"""
function FillRHS_dist!(b::Array, A::AbstractSuperMatrix, xtrue::Array;
    trans = false, nrhs = size(xtrue, 2), ldx = size(xtrue, 1), ldb = size(b, 1))
    FillRHS_dist!(b, A, xtrue, trans, nrhs, ldx, ldb)
    return b
end
