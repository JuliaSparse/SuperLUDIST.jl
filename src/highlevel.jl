function LinearAlgebra.lu!(
    A::AbstractSuperMatrix{Tv, Ti}, 
    b_local = ones(Tv, Communication.localsize(A, 2), 1);
    kwargs...
) where {Tv, Ti}
    return pgssvx!(A, b_local; kwargs...)[2] # F, drop b_local.
end

function LinearAlgebra.ldiv!(A::SuperLUFactorization{Tv, Ti}, B::StridedVecOrMat{Tv}) where {Tv, Ti}
    return pgssvx!(A, B)[1]
end
