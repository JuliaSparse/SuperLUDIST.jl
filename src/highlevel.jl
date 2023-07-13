function LinearAlgebra.lu!(
    A::AbstractSuperMatrix{Tv, Ti};
    kwargs...
) where {Tv, Ti}
    b_local = Matrix{Tv}(undef, Communication.localsize(A, 2), 0)
    return pgssvx!(A, b_local; kwargs...)[2] # F, drop b_local.
end

function LinearAlgebra.ldiv!(A::SuperLUFactorization{Tv, Ti}, B::StridedVecOrMat{Tv}) where {Tv, Ti}
    return pgssvx!(A, B)[1]
end
