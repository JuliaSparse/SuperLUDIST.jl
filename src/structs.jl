struct Grid{I, G}
    grid::Base.RefValue{G}
end

function Base.getproperty(g::Grid, s::Symbol)
    s === :grid && return Base.getfield(g, s)
    return getproperty(g.grid[], s)
end

struct Options{I, O}
    options::O
end

function Base.getproperty(O::Options, s::Symbol)
    s === :options && return Base.getfield(g, s)
    return getproperty(O.options, s)
end
function Base.setproperty!(x, O::Options, s::Symbol)
    return setproperty!(x, O.options, s)
end

abstract type AbstractSuperMatrix{Tv, Ti, S} <: AbstractMatrix{Tv} end

mutable struct GlobalSuperMatrix{T, I, S, F, J, A} <: AbstractSuperMatrix{T, I, S}
    supermatrix::Base.RefValue{S}
    format::Base.RefValue
    jlformat::J
end
mutable struct DistributedSuperMatrix{T, I, S, F, J, A} <: AbstractSuperMatrix{T, I, S}
    supermatrix::Base.RefValue{S}
    format::Base.RefValue
    jlformat::J
end


function Base.getproperty(S::AbstractSuperMatrix, s::Symbol)
    s === :supermatrix && return Base.getfield(S, s)
    s === :jldata && return Base.getfield(S, s)
    return getproperty(S.supermatrix[], s)
end



for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
@eval begin
    # Grid functions:
    #################
    function gridmap!(r::Ref{$L.gridinfo_t}, comm, nprow, npcol, usermap::Matrix{Int32})
        myrank = MPI.Comm_rank(comm)
        color = myrank ÷ (nprow * npcol)
        subcomm = MPI.Comm_split(comm, color, myrank)
        superlu_gridmap(subcomm, nprow, npcl, usermap, size(usermap, 1), r)
        return r
    end
    function gridinit!(r::Ref{$L.gridinfo_t}, comm, nprow, npcol)
        $L.superlu_gridinit(comm, nprow, npcol, r)
        return r
    end
    function Grid{$I}(nprow, npcol, comm = MPI.COMM_WORLD; batch = false, usermap = nothing)
        !MPI.Initialized() && MPI.Init()
        r = Ref{$L.gridinfo_t}()
        if !batch
            gridinit!(r, comm, nprow, npcol)
        else
            usermap === nothing ? gridmap!(r, comm, nprow, npcol) : gridmap!(r, comm, nprow, npcol, usermap)
        end
        if r[].iam == -1 || r[].iam >= nprow * npcol
            $L.superlu_gridexit(r)
            return Grid{$I, $L.gridinfo_t}(r)
        else
            return Grid{$I, $L.gridinfo_t}(
                finalizer(r) do ref
                    $L.superlu_gridexit(ref)
                end
            )
        end
    end
    Base.unsafe_convert(::Ptr{$L.gridinfo_t}, g::Grid{$I}) = g.grid

    # Option functions:
    ###################
    function Options{$I}(; kwargs...)
        opt = $L.superlu_dist_options_t(kwargs...)
        $L.set_default_options_dist(opt)
        return Options{$I, typeof(opt)}(opt)
    end
    Base.unsafe_convert(::Type{Ptr{$L.superlu_dist_options_t}}, O::$L.superlu_dist_options_t) = 
        Ptr{$L.superlu_dist_options_t}(pointer_from_objref(O))
    Base.unsafe_convert(::Type{Ptr{$L.superlu_dist_options_t}}, O::Options{$I}) = 
        Base.unsafe_convert(Ptr{$L.superlu_dist_options_t}, O.options)

    # SuperMatrix functions:
    ########################
    Base.unsafe_convert(::Ptr{$L.SuperMatrix}, A::AbstractSuperMatrix{<:Any, $I}) = A.supermatrix
    
end
end

function gridmap!(r, comm, nprow, npcol)
    usermap = LinearIndices((nprow, npcol))' .- 1
    return gridmap!(r, comm, nprow, npcol, usermap)
end