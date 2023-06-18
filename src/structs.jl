struct Grid{I, G}
    grid::Base.RefValue{G}
end

function Base.getproperty(g::Grid, s::Symbol)
    s === :grid && return Base.getfield(g, s)
    return getproperty(g.grid[], s)
end


# Option functions:
###################
const Options = Common.superlu_dist_options_t

function Base.setproperty!(x, O::Options, s::Symbol)
    return setproperty!(x, O.options, s)
end

Base.unsafe_convert(::Type{Ptr{superlu_dist_options_t}}, O::superlu_dist_options_t) = 
    Ptr{superlu_dist_options_t}(pointer_from_objref(O))

struct ScalePermStruct{T, I, S}
    scaleperm::Base.RefValue{S}
end
ScalePermStruct{T}(m, n) where T = ScalePermStruct{T, Int}(m, n)
ScalePermStruct{T, I}(m, n) where {T, Ti, I<:CIndex{Ti}} = 
    ScalePermStruct{T, Ti}(m, n)


struct LUStruct{T, I, S, G}
    LU::Base.RefValue{S}
    grid::G
    n::I
end
LUStruct{T}(n, grid) where T = LUStruct{T, Int}(n, grid)
LUStruct{T, I}(n, grid) where {T, Ti, I<:CIndex{Ti}} = LUStruct{T, Ti}(n, grid)

struct LUStat{I, S}
    stat::Base.RefValue{S}
end
LUStat() = LUStat{Int}()
LUStat{I}() where {Ti, I<:CIndex{Ti}} = LUStat{Ti}()


mutable struct SOLVE{T, I, S}
    SOLVEstruct::Base.RefValue{S}
    options::Options
end
SOLVE{T}(options) where T = SOLVE{T, Int}(options)

SOLVE{T, I}(options) where {T, Ti, I<:CIndex{Ti}} = 
    SOLVE{T, Ti}(options)

for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
@eval begin
    # Grid functions:
    #################
    function gridmap!(r::Ref{gridinfo_t{$I}}, comm, nprow, npcol, usermap::Matrix{Int32})
        myrank = MPI.Comm_rank(comm)
        color = myrank ÷ (nprow * npcol)
        subcomm = MPI.Comm_split(comm, color, myrank)
        superlu_gridmap(subcomm, nprow, npcl, usermap, size(usermap, 1), r)
        return r
    end
    function gridinit!(r::Ref{gridinfo_t{$I}}, comm, nprow, npcol)
        $L.superlu_gridinit(comm, nprow, npcol, r)
        return r
    end
    function Grid{$I}(nprow, npcol, comm = MPI.COMM_WORLD; batch = false, usermap = nothing)
        !MPI.Initialized() && MPI.Init()
        r = Ref{gridinfo_t{$I}}()
        if !batch
            gridinit!(r, comm, nprow, npcol)
        else
            usermap === nothing ? gridmap!(r, comm, nprow, npcol) : gridmap!(r, comm, nprow, npcol, usermap)
        end
        if r[].iam == -1 || r[].iam >= nprow * npcol
            $L.superlu_gridexit(r)
            return Grid{$I, gridinfo_t{$I}}(r)
        else
            return Grid{$I, gridinfo_t{$I}}(
                finalizer(r) do ref
                    
                    !MPI.Finalized() && $L.superlu_gridexit(ref)
                end
            )
        end
    end
    Base.unsafe_convert(T::Type{Ptr{SuperLUDIST_Common.gridinfo_t{$I}}}, g::Grid{$I}) = 
        Base.unsafe_convert(T, g.grid)

    # SuperMatrix functions:
    ########################
    Base.unsafe_convert(T::Type{Ptr{SuperMatrix{$I}}}, A::AbstractSuperMatrix{<:Any, $I}) = 
        Base.unsafe_convert(T, A.supermatrix)

    function PStatFree(r::Base.RefValue{SuperLUStat_t{$I}})
        $L.PStatFree(r)
    end
    function PStatInit(r::Base.RefValue{SuperLUStat_t{$I}})
        $L.PStatInit(r)
        return finalizer(r) do x
            !MPI.Finalized() && PStatFree(x)
        end
    end
    function LUStat{$I}()
        r = Ref{SuperLUStat_t{$I}}()
        PStatInit(r)
        return LUStat{$I, eltype(r)}(r)
    end
    Base.unsafe_convert(T::Type{Ptr{SuperLUStat_t{$I}}}, S::LUStat{$I}) = 
        Base.unsafe_convert(T, S.stat)
    function PStatPrint(options, stat::LUStat{$I}, grid)
        $L.PStatPrint(options, stat, grid)
    end
end
for T ∈ (Float32, Float64, ComplexF64)
@eval begin
Base.unsafe_convert(T::Type{Ptr{$(prefixname(T, :SOLVEstruct_t)){$I}}}, S::SOLVE{$T, $I}) = 
    Base.unsafe_convert(T, S.SOLVEstruct)
function SOLVE{$T, $I}(options)
    r = Ref{$(prefixname(T, :SOLVEstruct_t)){$I}}()
    S = SOLVE{$T, $I, eltype(r)}(r, options)
    return finalizer(S) do solve
        !MPI.Finalized() && options.SolveInitialized == Common.YES &&
        $L.$(prefixname(T, :SolveFinalize))(options, solve)
    end
end
function ScalePermStruct{$T, $I}(m, n)
    r = Ref{$(prefixname(T, :ScalePermstruct_t)){$I}}()
    ScalePermstructInit(r, m, n)
    return ScalePermStruct{$T, $I, eltype(r)}(r)
end
Base.unsafe_convert(T::Type{Ptr{$(prefixname(T, :ScalePermstruct_t)){$I}}}, S::ScalePermStruct{$T, $I}) = 
    Base.unsafe_convert(T, S.scaleperm)
function LUStruct{$T, $I}(n, grid::G) where G
    r = Ref{$(prefixname(T, :LUstruct_t)){$I}}()
    LUstructInit(r, n, grid)
    return LUStruct{$T, $I, eltype(r), G}(r, grid, n)
end
Base.unsafe_convert(T::Type{Ptr{$(prefixname(T, :LUstruct_t)){$I}}}, S::LUStruct{$T, $I}) = 
    Base.unsafe_convert(T, S.LU)

function inf_norm_error_dist(n, nrhs, b, ldb, xtrue::AbstractVector{$T}, ldx, grid::Grid{$I})
    return $L.$(prefixname(T, :inf_norm_error_dist))(n, nrhs, b, ldb, xtrue, ldx, grid)
end
end
end
end

function gridmap!(r, comm, nprow, npcol)
    usermap = LinearIndices((nprow, npcol))' .- 1
    return gridmap!(r, comm, nprow, npcol, usermap)
end