"""
$(TYPEDEF)

SuperMatrix that has been globally replicated on all ranks in a communicator.
The local storage contains the full matrix, the Julia representation may be accessed
by `A.store::SparseBase.CSCStore{T, CIndex{<:Int}}`.

# Extended
$(FIELDS)
"""
mutable struct ReplicatedSuperMatrix{T, I, S, F, J, G} <: AbstractSuperMatrix{T, I, S}
    """Internal: Reference to `Common.SuperMatrix{I}`"""
    supermatrix::Base.RefValue{S}
    """Internal: Reference to storage format `Common.NCformat{I}` held by supermatrix"""
    format::Base.RefValue{F}
    """Julia-side storage, of type `SparseBase.CSCStore. Keeps memory alive.`"""
    store::J
    grid::G
end

Base.size(A::ReplicatedSuperMatrix) = size(A.store)
Base.size(A::ReplicatedSuperMatrix, dim) = size(A.store, dim)
Communication.localpart(A::ReplicatedSuperMatrix) = A.store

function ReplicatedSuperMatrix{Tv, Ti}(grid::Grid{Ti}) where
    {Tv, Ti}
    store = SparseBase.CSCStore{Tv, CIndex{Ti}}()
    return ReplicatedSuperMatrix(store, grid)
end

function ReplicatedSuperMatrix(store::SparseBase.CSCStore{Tv, CIndex{Ti}}, grid::Grid{Ti}, mtype = Common.SLU_GE) where
    {Tv, Ti}
    fmt, keepstore = Base.unsafe_convert(Common.NCformat, store)
    fmtref = Ref(fmt)
    superref = Ref(Common.SuperMatrix{Ti}(
        Common.SLU_NC,
        toslutype(Tv),
        mtype,
        Ti(size(store, 1)),
        Ti(size(store, 2)),
        Base.unsafe_convert(Ptr{Cvoid}, fmtref)
    ))
    return ReplicatedSuperMatrix{Tv, Ti, eltype(superref), typeof(fmt), typeof(keepstore), typeof(grid)}(
        superref, fmtref, keepstore, grid
    )
end

# TODO: use new eltype / iltype setup.
function ReplicatedSuperMatrix(store::SparseBase.AbstractSparseStore{Tv, <:Any, CIndex{Ti}}, grid::Grid{Ti}, mtype = Common.SLU_GE) where
    {Tv, Ti}
    return ReplicatedSuperMatrix(convert(SparseBase.CSCStore, store), grid, mtype)
end
function ReplicatedSuperMatrix(store::SparseBase.AbstractSparseStore{Tv, <:Any, Ti}, grid::Grid{Ti}, mtype = Common.SLU_GE) where
    {Tv, Ti}
    return ReplicatedSuperMatrix(convert(SparseBase.CSCStore{Tv, CIndex{Ti}}, store), grid, mtype)
end
