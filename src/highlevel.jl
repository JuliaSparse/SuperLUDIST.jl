"""
    lu!(A::Union{ReplicatedSuperMatrix, DistributedSuperMatrix}, b_local = ones(...); kwargs...)

Factorize `A` with SuperLU_DIST, and return a factorization object `F` that solves with
`F \\ b` or `ldiv!(F, b)`. A distributed `b` holds this rank's rows of the right hand side.

The keyword arguments are passed on to [`pgssvx!`](@ref), for example `options`.
"""
function LinearAlgebra.lu!(
    A::AbstractSuperMatrix{Tv, Ti},
    b_local::VecOrMat{Tv} = ones(Tv, Communication.localsize(A, 2), 1);
    kwargs...
) where {Tv, Ti}
    return pgssvx!(A, b_local; kwargs...)[2] # F, drop b_local.
end

function LinearAlgebra.ldiv!(A::SuperLUFactorization{Tv, Ti}, B::StridedVecOrMat{Tv}) where {Tv, Ti}
    return pgssvx!(A, B)[1]
end
