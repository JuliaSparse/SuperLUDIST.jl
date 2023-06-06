
# internal use only, send must exist on all ranks.
# probably best as a Tv[] or similar empty on non source.
function _scatterarray(
    send::AbstractArray{<:Any, N}, sizes, source = 0; 
    comm = MPI.COMM_WORLD
) where N
    rank = MPI.Comm_rank(comm)
    if rank == source
        sizebuf = UBuffer(sizes, ndims(send))
        vbuf = VBuffer(send, sizes)
    else
        sizebuf = UBuffer(nothing)
        vbuf = VBuffer(nothing)
    end
    localsize = MPI.Scatter(sizebuf, NTuple{N, Int}, source, comm)
    localarray = MPI.Scatterv!(vbuf, similar(send, localsize), source, comm)
    return localarray
end


function _scattervec!(
    recv::AbstractArray{<:Any, N}, send, sizes, source = 0; 
    comm = MPI.COMM_WORLD
) where N
    rank = MPI.Comm_rank(comm)
    if rank == source
        sizebuf = UBuffer(sizes, ndims(send))
        vbuf = VBuffer(send, sizes)
    else
        sizebuf = UBuffer(nothing)
        vbuf = VBuffer(nothing)
    end
    localsize = MPI.Scatter(sizebuf, NTuple{N, Int}, source, comm)
    localarray = MPI.Scatterv!(vbuf, resize!(recv, localsize), source, comm)
    return localarray
end

