# Grid (gridinfo_t) functions:
##############################
"""
    Grid{Ti}(nprow, npcol, comm = MPI.COMM_WORLD; batch = false, usermap = nothing)

A 2D `nprow × npcol` process grid for SuperLU_DIST with index type `Ti ∈ (Int32, Int64)`,
built from the first `nprow * npcol` ranks of `comm`. MPI is initialized if necessary.

With `batch = true` the ranks are mapped onto the grid by `usermap`, a `nprow × npcol`
matrix of ranks (default: row-major order).

Fields of the underlying `gridinfo_t`, such as `iam`, `nprow` and `npcol`, are available as
properties.
"""
struct Grid{I, G}
    comm::MPI.Comm
    gridinfo::Base.RefValue{G}
end

for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
@eval begin
function gridmap!(g::Grid{$I}, nprow, npcol, usermap::AbstractMatrix{<:Integer})
    myrank = MPI.Comm_rank(g.comm)
    color = myrank ÷ (nprow * npcol)
    subcomm = MPI.Comm_split(g.comm, color, myrank)
    usermap = convert(Matrix{Cint}, usermap)
    $L.superlu_gridmap(subcomm, nprow, npcol, usermap, size(usermap, 1), g)
    return g
end
function gridinit!(g::Grid{$I}, nprow, npcol)
    $L.superlu_gridinit(g.comm, nprow, npcol, g)
    return g
end
function Grid{$I}(nprow::Integer, npcol::Integer, comm = MPI.COMM_WORLD; batch = false, usermap = nothing)
    $I == Int32 && libsuperlu_dist_Int32 === nothing &&
        (throw(ArgumentError("libsuperlu_dist_Int32 is not loaded.")))
    $I == Int64 && libsuperlu_dist_Int64 === nothing &&
        (throw(ArgumentError("libsuperlu_dist_Int64 is not loaded.")))

    !MPI.Initialized() && MPI.Init()
    g = Grid{$I, $L.gridinfo_t}(comm, cref($L.gridinfo_t))
    if !batch
        gridinit!(g, nprow, npcol)
    else
        usermap === nothing ? gridmap!(g, nprow, npcol) : gridmap!(g, nprow, npcol, usermap)
    end
    if g.iam == -1 || g.iam >= nprow * npcol
        $L.superlu_gridexit(g)
    else
        finalizer(g.gridinfo) do G
            !MPI.Finalized() && $L.superlu_gridexit(G)
        end
    end
    return g
end
end # end eval
end # end for

Base.unsafe_convert(::Type{Ptr{G}}, g::Grid{<:Any, G}) where G =
    Base.unsafe_convert(Ptr{G}, g.gridinfo)

function gridmap!(g::Grid, nprow, npcol)
    usermap = permutedims(LinearIndices((npcol, nprow))) .- 1
    return gridmap!(g, nprow, npcol, usermap)
end

function Base.getproperty(g::Grid, s::Symbol)
    # Julia level functions expect a Comm, not an MPI_Comm / Int32.
    s === :comm && return getfield(g, s)
    s === :gridinfo && return getfield(g, s)
    return getfield(getfield(g, :gridinfo)[], s)
end
Base.propertynames(g::Grid) = (:comm, :gridinfo, fieldnames(eltype(getfield(g, :gridinfo)))...)

# Option functions:
###################
"""
    Options{Ti}(; kwargs...)

Solver options (`superlu_dist_options_t`) for SuperLU_DIST with index type `Ti`.
They start from SuperLU_DIST's defaults (`set_default_options_dist`), and any field may be
set with a keyword argument or as a property afterwards, for example
`Options{Int64}(; ColPerm = SuperLUDIST.Common.MMD_AT_PLUS_A, PrintStat = SuperLUDIST.Common.NO)`.
"""
struct Options{I, O}
    options::Base.RefValue{O}
end
Options(; kwargs...) = Options{Int}(; kwargs...)

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    @eval function Options{$I}(; kwargs...)
        r = cref($L.superlu_dist_options_t)
        $L.set_default_options_dist(r)
        for (k, v) in kwargs
            setfield_ref!(r, k, v)
        end
        return Options{$I, $L.superlu_dist_options_t}(r)
    end
end
Base.getproperty(o::Options, s::Symbol) =
    s === :options ? getfield(o, s) : getfield(getfield(o, :options)[], s)
Base.setproperty!(o::Options, s::Symbol, v) = setfield_ref!(getfield(o, :options), s, v)
Base.propertynames(o::Options) = fieldnames(eltype(getfield(o, :options)))
Base.unsafe_convert(::Type{Ptr{O}}, o::Options{<:Any, O}) where O =
    Base.unsafe_convert(Ptr{O}, getfield(o, :options))

# ScalePerm (ScalePermstruct_t) functions:
##########################################
struct ScalePerm{T, I, S}
    scaleperm::Base.RefValue{S}
end
ScalePerm{T}(m, n) where T = ScalePerm{T, Int}(m, n)
ScalePerm{T, I}(m, n) where {T, Ti, I<:CIndex{Ti}} =
    ScalePerm{T, Ti}(m, n)

function Base.getproperty(g::ScalePerm, s::Symbol)
    s === :scaleperm && return Base.getfield(g, s)
    return getfield(g.scaleperm[], s)
end
for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    for T ∈ (Float32, Float64, ComplexF64)
    S = :($L.$(prefixname(T, :ScalePermstruct_t)))
    @eval begin
    function ScalePerm{$T, $I}(m, n)
        r = ScalePermstructInit(cref($S), m, n)
        return ScalePerm{$T, $I, $S}(r)
    end
    Base.unsafe_convert(T::Type{Ptr{$S}}, S::ScalePerm{$T, $I}) =
        Base.unsafe_convert(T, S.scaleperm)
end # end eval
end # end for
end # end for

# LUFactors (LUstruct_t) functions:
###################################
mutable struct LUFactors{T, I, S, G}
    LU::Base.RefValue{S}
    grid::G
    n::I
    # `Destroy_LU` may only be called once the factors have been computed.
    factored::Bool
end
LUFactors{T}(n, grid) where T = LUFactors{T, Int}(n, grid)
LUFactors{T, I}(n, grid) where {T, Ti, I<:CIndex{Ti}} = LUFactors{T, Ti}(n, grid)

function Base.getproperty(g::LUFactors, s::Symbol)
    s ∈ fieldnames(LUFactors) && return Base.getfield(g, s)
    return getfield(g.LU[], s)
end

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    for T ∈ (Float32, Float64, ComplexF64)
    S = :($L.$(prefixname(T, :LUstruct_t)))
    @eval begin
    function LUFactors{$T, $I}(n, grid::G) where G
        r = LUstructInit(cref($S), n)
        LU = LUFactors{$T, $I, $S, G}(r, grid, n, false)
        return finalizer(LU) do x
            MPI.Finalized() && return
            x.factored && Destroy_LU(x.LU, x.n, x.grid)
            LUstructFree(x.LU)
        end
    end
    Base.unsafe_convert(T::Type{Ptr{$S}}, S::LUFactors{$T, $I}) =
        Base.unsafe_convert(T, S.LU)
    end # end eval
    end # end for
end # end for

# LUStat (SuperLUStat_t) functions:
###################################
struct LUStat{I, S}
    stat::Base.RefValue{S}
end
LUStat() = LUStat{Int}()
LUStat{I}() where {Ti, I<:CIndex{Ti}} = LUStat{Ti}()

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    @eval begin
        function PStatInit(r::Base.RefValue{$L.SuperLUStat_t})
            $L.PStatInit(r)
            return finalizer(r) do x
                !MPI.Finalized() && $L.PStatFree(x)
            end
        end
        function LUStat{$I}()
            r = PStatInit(cref($L.SuperLUStat_t))
            return LUStat{$I, $L.SuperLUStat_t}(r)
        end
        Base.unsafe_convert(T::Type{Ptr{$L.SuperLUStat_t}}, S::LUStat{$I}) =
            Base.unsafe_convert(T, S.stat)

        function PStatPrint(options, stat::LUStat{$I}, grid)
            $L.PStatPrint(options, stat, grid)
        end
    end # end eval
end # end for

# SolveData (SOLVEstruct_t) functions:
######################################
mutable struct SolveData{T, I, S, O}
    data::Base.RefValue{S}
    options::O
end
SolveData{T}(options) where T = SolveData{T, Int}(options)

SolveData{T, I}(options) where {T, Ti, I<:CIndex{Ti}} =
    SolveData{T, Ti}(options)

function Base.getproperty(g::SolveData, s::Symbol)
    s === :options && return Base.getfield(g, s)
    s === :data && return Base.getfield(g, s)
    return getfield(g.data[], s)
end

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    for T ∈ (Float32, Float64, ComplexF64)
    S = :($L.$(prefixname(T, :SOLVEstruct_t)))
    @eval begin
    Base.unsafe_convert(T::Type{Ptr{$S}}, S::SolveData{$T, $I}) =
        Base.unsafe_convert(T, S.data)

    function SolveData{$T, $I}(options::O) where O <: Options{$I}
        S = SolveData{$T, $I, $S, O}(cref($S), options)
        return finalizer(S) do solve
            !MPI.Finalized() && options.SolveInitialized == Common.YES &&
            $L.$(prefixname(T, :SolveFinalize))(options, solve)
        end
    end
    end # end eval
end # end for
end # end for

"""
    SuperLUFactorization

The factorization returned by [`pgssvx!`](@ref) and `lu!`. It holds the matrix, the options
and SuperLU_DIST's factors, and solves further right-hand sides with `F \\ b` or
`ldiv!(F, b)`.
"""
mutable struct SuperLUFactorization{T, I, A, Opts, Solve, Perm, Factors, Stat, B} <: LinearAlgebra.Factorization{T}
    mat::A
    options::Opts
    solve::Solve
    perm::Perm
    factors::Factors
    stat::Stat
    berr::Vector{T}
    b::B
    function SuperLUFactorization{T, I, A, Opts, Solve, Perm, Factors, Stat, B}(
        mat::A, options::Opts, solve::Solve, perm::Perm,
        factors::Factors, stat::Stat, berr::Vector{T}, b::B
    ) where {
        T<:Union{Float32, Float64, ComplexF64},
        I <: Union{Int32, Int64},
        A <: AbstractSuperMatrix{T, I},
        Opts <: Options{I},
        Solve <: Union{SolveData{T, I}, Nothing},
        Perm <: ScalePerm{T, I},
        Factors <: LUFactors{T, I},
        Stat <: LUStat{I},
        B <: StridedVecOrMat{T}
    }
        return new(mat, options, solve, perm, factors, stat, berr, b)
    end
end
"""
    isfactored(F::SuperLUFactorization)

Whether `F` holds a computed factorization, so that further solves reuse it.
"""
isfactored(F::SuperLUFactorization) = F.options.Fact == Common.FACTORED

function SuperLUFactorization(
    A::AbstractSuperMatrix{Tv, Ti}, options::Opts,
    solve::Solve, perm::Perm, factors::Factors, stat::Stat, berr::Vector{Tv}, b::B
) where {Tv, Ti, Opts, Solve, Perm, Factors, Stat, B}
    return SuperLUFactorization{Tv, Ti, typeof(A), Opts, Solve, Perm, Factors, Stat, B}(
        A, options, solve, perm, factors, stat, berr, b
    )
end

"""
    PStatPrint(F::SuperLUFactorization)

Print SuperLU_DIST's statistics (timings, flops and memory) for the factorization `F`. This
is collective: every rank in the grid must call it.
"""
function PStatPrint(F::SuperLUFactorization)
    PStatPrint(F.options, F.stat, F.mat.grid)
end

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    libname = Symbol(:libsuperlu_dist_, I)
    @eval begin
        """
            superlu_set_num_threads(Ti, n)

        Set the number of OpenMP threads used by the SuperLU_DIST library with index type `Ti`
        on this rank.
        """
        function superlu_set_num_threads(::Type{$I}, n)
            omp_set_num_threads = dlsym(dlopen($libname), :omp_set_num_threads)
            ccall(omp_set_num_threads, Cvoid, (Cint,), n)
        end
    end
    for T ∈ (Float32, Float64, ComplexF64)
        @eval begin
        function inf_norm_error_dist(n, nrhs, b, ldb, xtrue::AbstractVecOrMat{$T}, ldx, grid::Grid{$I})
            return $L.$(prefixname(T, :inf_norm_error_dist))(n, nrhs, b, ldb, xtrue, ldx, grid)
        end
    end
    end
end
