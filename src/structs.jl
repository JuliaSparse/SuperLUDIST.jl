# Grid (gridinfo_t) functions:
##############################
"""
    AbstractGrid{Ti}

A SuperLU_DIST process grid with index type `Ti`: a 2D [`Grid`](@ref) or a 3D [`Grid3D`](@ref).
"""
abstract type AbstractGrid{I} end

# SuperLU_DIST calls MPI_Abort for a grid with more ranks than `comm`, so check it here.
function checkgridshape(comm, dims::Integer...)
    shape = join(dims, " × ")
    all(>(0), dims) || throw(ArgumentError("The dimensions of a $shape grid must be positive."))
    np = MPI.Comm_size(comm)
    prod(dims) <= np || throw(ArgumentError(
        "A $shape grid needs $(prod(dims)) ranks, but the communicator has $np."
    ))
    return nothing
end

"""
    Grid{Ti}(nprow, npcol, comm = MPI.COMM_WORLD; batch = false, usermap = nothing)

A 2D `nprow × npcol` process grid for SuperLU_DIST with index type `Ti ∈ (Int32, Int64)`,
built from the first `nprow * npcol` ranks of `comm`. MPI is initialized if necessary.

With `batch = true` the ranks are mapped onto the grid by `usermap`, a `nprow × npcol`
matrix of ranks (default: row-major order).

Fields of the underlying `gridinfo_t`, such as `iam`, `nprow` and `npcol`, are available as
properties.
"""
struct Grid{I, G} <: AbstractGrid{I}
    comm::MPI.Comm
    gridinfo::Base.RefValue{G}
end

for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
@eval begin
function gridmap!(g::Grid{$I}, nprow, npcol, usermap::AbstractMatrix{<:Integer})
    size(usermap) == (nprow, npcol) || throw(DimensionMismatch(
        "usermap has size $(size(usermap)), but the grid is $nprow × $npcol."
    ))
    # Each batch of `nprow * npcol` consecutive ranks forms a grid, numbered by its ranks
    # 0, 1, ... in the batch, and SuperLU_DIST calls MPI_Abort for a batch that is short of
    # ranks or a usermap that names a rank twice or one outside the batch.
    np = MPI.Comm_size(g.comm)
    np % (nprow * npcol) == 0 || throw(ArgumentError(
        "Batches of $nprow × $npcol grids need a multiple of $(nprow * npcol) ranks, " *
        "but the communicator has $np."
    ))
    sort(vec(usermap)) == 0:(nprow * npcol - 1) || throw(ArgumentError(
        "usermap must name each rank 0:$(nprow * npcol - 1) of a batch once."
    ))
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
    checkgridshape(comm, nprow, npcol)
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

# The number of ranks in a grid.
gridsize(g::Grid) = g.nprow * g.npcol

# Grid3D (gridinfo3d_t) functions:
##################################
"""
    Grid3D{Ti}(nprow, npcol, npdep, comm = MPI.COMM_WORLD)

A 3D `nprow × npcol × npdep` process grid for SuperLU_DIST's communication-avoiding 3D
factorization, with index type `Ti ∈ (Int32, Int64)`, built from the first
`nprow * npcol * npdep` ranks of `comm`. It consists of `npdep` layers of `nprow × npcol` 2D
grids. `npdep` must be a power of two. MPI is initialized if necessary.

A [`DistributedSuperMatrix`](@ref) on a `Grid3D` is solved with SuperLU_DIST's `pgssvx3d`
drivers. Its rows must be distributed over all the ranks of the 3D grid.

Fields of the underlying `gridinfo3d_t`, such as `iam`, `nprow`, `npcol`, `npdep`, `grid2d`
(this rank's layer) and `zscp` (`zscp.Iam` is the layer number), are available as properties.
"""
struct Grid3D{I, G} <: AbstractGrid{I}
    comm::MPI.Comm
    gridinfo::Base.RefValue{G}
end

for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
@eval begin
function Grid3D{$I}(nprow::Integer, npcol::Integer, npdep::Integer, comm = MPI.COMM_WORLD)
    $I == Int32 && libsuperlu_dist_Int32 === nothing &&
        (throw(ArgumentError("libsuperlu_dist_Int32 is not loaded.")))
    $I == Int64 && libsuperlu_dist_Int64 === nothing &&
        (throw(ArgumentError("libsuperlu_dist_Int64 is not loaded.")))
    ispow2(npdep) || throw(ArgumentError("npdep = $npdep must be a power of two."))

    !MPI.Initialized() && MPI.Init()
    checkgridshape(comm, nprow, npcol, npdep)
    g = Grid3D{$I, $L.gridinfo3d_t}(comm, cref($L.gridinfo3d_t))
    $L.superlu_gridinit3d(comm, nprow, npcol, npdep, g)
    # Ranks outside the grid have iam == -1 and no communicators to free.
    if g.iam != -1
        finalizer(g.gridinfo) do G
            !MPI.Finalized() && $L.superlu_gridexit3d(G)
        end
    end
    return g
end
Base.unsafe_convert(::Type{Ptr{$L.gridinfo3d_t}}, g::Grid3D{$I}) =
    Base.unsafe_convert(Ptr{$L.gridinfo3d_t}, getfield(g, :gridinfo))
# Routines that work on this rank's 2D layer take the embedded `grid2d`.
Base.unsafe_convert(::Type{Ptr{$L.gridinfo_t}}, g::Grid3D{$I}) = Ptr{$L.gridinfo_t}(
    Base.unsafe_convert(Ptr{$L.gridinfo3d_t}, g) +
    fieldoffset($L.gridinfo3d_t, Base.fieldindex($L.gridinfo3d_t, :grid2d))
)
end # end eval
end # end for

function Base.getproperty(g::Grid3D, s::Symbol)
    s === :comm && return getfield(g, s)
    s === :gridinfo && return getfield(g, s)
    return getfield(getfield(g, :gridinfo)[], s)
end
gridsize(g::Grid3D) = g.nprow * g.npcol * g.npdep
Base.propertynames(g::Grid3D) = (:comm, :gridinfo, fieldnames(eltype(getfield(g, :gridinfo)))...)

# Whether this rank is in the grid. The others have no grid communicator.
ingrid(g::AbstractGrid) = g.iam != -1 && g.iam < gridsize(g)
# The communicator of the grid's ranks, which SuperLU_DIST's drivers are collective over.
gridcomm(g::AbstractGrid) = MPI.Comm(getfield(getfield(g, :gridinfo)[], :comm))

# Option functions:
###################
"""
    Options{Ti}(; kwargs...)

Solver options (`superlu_dist_options_t`) for SuperLU\\_DIST with index type `Ti`.
They start from SuperLU\\_DIST's defaults (`set_default_options_dist`), and any field may be
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
        # As SuperLU_DIST's 3D examples do, print the statistics of layer 0 only. Ranks
        # outside the grid (iam == -1) have no layer, and their zscp is left zeroed.
        function PStatPrint(options, stat::LUStat{$I}, grid::Grid3D{$I})
            grid.iam != -1 && grid.zscp.Iam == 0 && $L.PStatPrint(options, stat, grid)
            return nothing
        end
    end # end eval
end # end for

# SolveData (SOLVEstruct_t) functions:
######################################
mutable struct SolveData{T, I, S, O, G}
    data::Base.RefValue{S}
    options::O
    # The `Grid3D` of a 3D solve, whose gathered matrix must be freed with the solve data.
    grid::G
    # The number of right-hand sides the solve is set up for: the triangular solve's
    # communication in 2D, and in 3D pgssvx3d's redistribution of B (at least 1), which it
    # only sets up when it factorizes from scratch.
    nrhs::Int
end
SolveData{T}(options, grid = nothing) where T = SolveData{T, Int}(options, grid)

SolveData{T, I}(options, grid = nothing) where {T, Ti, I<:CIndex{Ti}} =
    SolveData{T, Ti}(options, grid)

function Base.getproperty(g::SolveData, s::Symbol)
    s === :options && return Base.getfield(g, s)
    s === :data && return Base.getfield(g, s)
    s === :grid && return Base.getfield(g, s)
    s === :nrhs && return Base.getfield(g, s)
    return getfield(g.data[], s)
end

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    for T ∈ (Float32, Float64, ComplexF64)
    S = :($L.$(prefixname(T, :SOLVEstruct_t)))
    @eval begin
    Base.unsafe_convert(T::Type{Ptr{$S}}, S::SolveData{$T, $I}) =
        Base.unsafe_convert(T, S.data)

    function SolveData{$T, $I}(
        options::O, grid::Union{Nothing, AbstractGrid{$I}} = nothing
    ) where O <: Options{$I}
        g = grid isa Grid3D ? grid : nothing
        S = SolveData{$T, $I, $S, O, typeof(g)}(cref($S), options, g, 0)
        return finalizer(S) do solve
            MPI.Finalized() && return
            # `options` may say that another solve data was initialized, and `gstrs_comm`
            # is only allocated by `SolveInit`.
            options.SolveInitialized == Common.YES && solve.gstrs_comm != C_NULL &&
                $L.$(prefixname(T, :SolveFinalize))(options, solve)
            # `A3d` is only allocated by the first call to `pgssvx3d`.
            g === nothing || solve.A3d == C_NULL ||
                $L.$(prefixname(T, :Destroy_A3d_gathered_on_2d))(solve, g)
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
mutable struct SuperLUFactorization{T, I, A, Opts, Solve, Perm, Factors, Stat, R} <: LinearAlgebra.Factorization{T}
    mat::A
    options::Opts
    solve::Solve
    perm::Perm
    factors::Factors
    stat::Stat
    # The componentwise backward error of each column of the last solve.
    berr::Vector{R}
    # The number of right-hand sides of the last call to pgssvx.
    nrhs::Int
    function SuperLUFactorization{T, I, A, Opts, Solve, Perm, Factors, Stat, R}(
        mat::A, options::Opts, solve::Solve, perm::Perm,
        factors::Factors, stat::Stat, berr::Vector{R}, nrhs::Integer
    ) where {
        T<:Union{Float32, Float64, ComplexF64},
        I <: Union{Int32, Int64},
        A <: AbstractSuperMatrix{T, I},
        Opts <: Options{I},
        Solve <: Union{SolveData{T, I}, Nothing},
        Perm <: ScalePerm{T, I},
        Factors <: LUFactors{T, I},
        Stat <: LUStat{I},
        R <: Union{Float32, Float64}
    }
        R === real(T) || throw(ArgumentError("berr must be a Vector{$(real(T))}"))
        return new(mat, options, solve, perm, factors, stat, berr, nrhs)
    end
end
"""
    isfactored(F::SuperLUFactorization)

Whether `F` holds a computed factorization, so that further solves reuse it.
"""
isfactored(F::SuperLUFactorization) = F.options.Fact == Common.FACTORED

function SuperLUFactorization(
    A::AbstractSuperMatrix{Tv, Ti}, options::Opts,
    solve::Solve, perm::Perm, factors::Factors, stat::Stat, berr::AbstractVector,
    b::AbstractVecOrMat
) where {Tv, Ti, Opts, Solve, Perm, Factors, Stat}
    # SuperLU_DIST writes real backward errors, also for complex matrices.
    berr = berr isa Vector{real(Tv)} ? berr : Vector{real(Tv)}(undef, length(berr))
    return SuperLUFactorization{Tv, Ti, typeof(A), Opts, Solve, Perm, Factors, Stat, real(Tv)}(
        A, options, solve, perm, factors, stat, berr, size(b, 2)
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

# `omp_set_num_threads` of the OpenMP runtime that `lib` is linked against.
function omp_set_num_threads_ptr(lib)
    f = dlsym(dlopen(lib), :omp_set_num_threads; throw_error = false)
    f === nothing || return f
    # On Windows a library's handle only finds its own symbols, so look in the OpenMP
    # runtime (libgomp or libomp) that it loaded.
    for l in dllist()
        occursin(r"^lib(g|i5)?omp"i, basename(l)) || continue
        f = dlsym(dlopen(l), :omp_set_num_threads; throw_error = false)
        f === nothing || return f
    end
    error("Could not find omp_set_num_threads in $lib or a loaded OpenMP library.")
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
            ccall(omp_set_num_threads_ptr($libname), Cvoid, (Cint,), n)
        end
    end
    for T ∈ (Float32, Float64, ComplexF64)
        @eval begin
        function inf_norm_error_dist(n, nrhs, b, ldb, xtrue::AbstractVecOrMat{$T}, ldx, grid::AbstractGrid{$I})
            return $L.$(prefixname(T, :inf_norm_error_dist))(n, nrhs, b, ldb, xtrue, ldx, grid)
        end
    end
    end
end
