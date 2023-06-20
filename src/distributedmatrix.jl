"""
$(TYPEDEF)

SuperMatrix distributed by row between all ranks in a communicator.
The Julia representation may be accessed by `A.store::SparseBase.CSRStore{T, CIndex{<:Int}}`.

Each local matrix stores a subset of rows specified by `A.globalrows`

# Extended
$(FIELDS)
"""
mutable struct DistributedSuperMatrix{T, I, S, F, J} <: AbstractSuperMatrix{T, I, S}
    """Internal: Reference to `Common.SuperMatrix{I}`"""
    supermatrix::Base.RefValue{S} # the supermatrix
    """Internal: Reference to storage format `Common.NRFormat_loc{I}` held by supermatrix"""
    format::Base.RefValue{F} # the internal storage
    """Julia-side storage, of type `SparseBase.CSRStore. Keeps memory alive.`"""
    store::J #keepalive for format
    globalsize::NTuple{2, I}
    first_row::I
end
Base.size(A::DistributedSuperMatrix) = A.globalsize
Communication.localpart(A::DistributedSuperMatrix) = A.store

# TODO propagate fields to C structs.
"""
    DistributedSuperMatrix{Tv, Ti}()

Construct an empty DistributedSuperMatrix to be filled later.

Note: Currently, modifying Julia-level fields will not propagate to the C structs.
For instance in order to update the size you must update the size of
    `A::DistributedSuperMatrix.store` as well as the sizes stored in `A.format` and
    `A.supermatrix`.
"""
function DistributedSuperMatrix{Tv, Ti}() where {Tv, Ti}
    store = SparseBase.CSRStore{Tv, CIndex{Ti}}()
    firstrow, globalsize = 1, (0, 0)
    DistributedSuperMatrix(store, firstrow, globalsize)
end

"""
    $(TYPEDSIGNATURES)

Construct a DistributedSuperMatrix from a finished `SparseBase.CSRStore`.

# Arguments
  - `A` : sparse storage in CSR form, valid index types are `{Int32, Int64}`, valid
    element types are `{Float32, Float64, ComplexF64}`.
  - `firstrow` : the 1-based starting row of A on this rank.
  - `globalsize` : the size of `A` across all ranks.
"""
function DistributedSuperMatrix(A::SparseBase.CSRStore{<:Any, CIndex{Ti}}, firstrow, globalsize) where {Ti}
    fmtref = Ref(Common.NRformat_loc{Ti}(
        nstored(A),
        A.vdim,
        firstrow - 1, # start of row range.
        Ptr{Cvoid}(pointer(A.v)),
        Base.unsafe_convert(Ptr{Ti}, A.ptr),
        Base.unsafe_convert(Ptr{Ti}, A.idx)
    ))
    superref = Ref(Common.SuperMatrix{Ti}(
        Common.SLU_NR_loc,
        toslutype(storedeltype(A)),
        Common.SLU_GE,
        Ti.(globalsize)..., # global size.
        Base.unsafe_convert(Ptr{Cvoid}, fmtref)
    ))
    return DistributedSuperMatrix{
        storedeltype(A), Ti, eltype(superref), eltype(fmtref), typeof(A)
    }(superref, fmtref, A, Ti.(globalsize), firstrow)
end

function DistributedSuperMatrix(store::SparseBase.AbstractSparseStore{Tv, <:Any, CIndex{Ti}}, firstrow, globalsize) where
    {Tv, Ti}
    return DistributedSuperMatrix(convert(SparseBase.CSRStore, store), firstrow, globalsize)
end
function DistributedSuperMatrix(store::SparseBase.AbstractSparseStore{Tv, <:Any, Ti}, firstrow, globalsize) where
    {Tv, Ti}
    return DistributedSuperMatrix(convert(SparseBase.CSRStore{Tv, CIndex{Ti}}, store), firstrow, globalsize)
end

"""
    $(TYPEDSIGNATURES)
"""
function Communication.scatterstore!(
    rstore::DistributedSuperMatrix{Tv, Ti},
    sstore::Union{Nothing, SparseBase.CSRStore},
    chunksizes; # dimchunks is an iterable of the number of rows / cols (CSR / CSC)
    # in each rank.
    root::Integer = 0,
    comm::MPI.Comm = MPI.COMM_WORLD
) where {Tv, Ti}
    # TODO: some of this should happen automatically.
    # scatterstore! is semantically a resize and overwrite, so changing ptrs
    # shouldn't be necessary.
    A, globalrows, firstrow = 
        Communication.scatterstore!(rstore.store, sstore, chunksizes; root, comm)
    rstore.store = A
    rstore.globalsize = (globalrows, size(A, 2))
    rstore.first_row = firstrow
    rstore.format = Ref(Common.NRformat_loc{Ti}(
        SparseBase.nstored(A),
        A.vdim,
        firstrow - 1, # start of row range.
        Ptr{Cvoid}(pointer(A.v)),
        Base.unsafe_convert(Ptr{Ti}, A.ptr),
        Base.unsafe_convert(Ptr{Ti}, A.idx)
    ))
    rstore.supermatrix = Ref(Common.SuperMatrix{Ti}(
        Common.SLU_NR_loc,
        toslutype(storedeltype(A)),
        Common.SLU_GE,
        globalrows, A.vlen, # global size.
        Base.unsafe_convert(Ptr{Cvoid}, rstore.format)
    ))
    return rstore
end
