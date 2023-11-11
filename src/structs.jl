# Grid (gridinfo_t) functions:
##############################
# const Grid{I} = SuperLUDIST_Common.gridinfo_t{I}
# const Grid3D{I} = SuperLUDIST_Common.gridinfo3d_t{I}
struct Grid{I}
    comm::MPI.Comm
    gridinfo::SuperLUDIST_Common.gridinfo_t{I}
end
struct Grid3D{I}
    comm::MPI.Comm
    gridinfo::SuperLUDIST_Common.gridinfo3d_t{I}
end



for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
libname = Symbol(:libsuperlu_dist_, I)
@eval begin
function gridmap!(g::Grid{$I}, nprow, npcol, usermap::Matrix{Int32})
    myrank = MPI.Comm_rank(g.comm)
    color = myrank ÷ (nprow * npcol)
    subcomm = MPI.Comm_split(g.comm, color, myrank)
    $L.superlu_gridmap(subcomm, nprow, npcl, usermap, size(usermap, 1), g)
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
    g = Grid{$I}(
        comm,
        SuperLUDIST_Common.gridinfo_t{$I}(
            Base.unsafe_convert(MPI.MPI_Comm, comm), 
            superlu_scope_t(comm), 
            superlu_scope_t(comm), 
            convert(Cint, MPI.Comm_rank(comm)), nprow, npcol
        )
    )
    if !batch
        gridinit!(g, nprow, npcol)
    else
        usermap === nothing ? gridmap!(g, nprow, npcol) : gridmap!(g, nprow, npcol, usermap)
    end
    if g.iam == -1 || g.iam >= nprow * npcol
        $L.superlu_gridexit(g)
        return g
    else
        finalizer(g.gridinfo) do G
            !MPI.Finalized() && $L.superlu_gridexit(G)
        end
        return g
    end
end
# Base.unsafe_convert(T::Type{Ptr{SuperLUDIST_Common.gridinfo_t{$I}}}, g::Grid{$I}) = 
    # Base.unsafe_convert(T, g.grid)
Base.unsafe_convert(::Type{Ptr{SuperLUDIST_Common.gridinfo_t{$I}}}, O::Grid{$I}) = 
    Ptr{gridinfo_t{$I}}(pointer_from_objref(O.gridinfo))
Base.unsafe_convert(
    ::Type{Ptr{SuperLUDIST_Common.gridinfo_t{$I}}}, 
    O::SuperLUDIST_Common.gridinfo_t{$I}
) = Ptr{gridinfo_t{$I}}(pointer_from_objref(O))

end # end eval
end # end for

function gridmap!(r, comm, nprow, npcol)
    usermap = LinearIndices((nprow, npcol))' .- 1
    return gridmap!(r, comm, nprow, npcol, usermap)
end

function SuperLUDIST_Common.superlu_scope_t(
    comm; Np = MPI.Comm_size(comm), Iam = MPI.Comm_rank(comm)
)
    return SuperLUDIST_Common.superlu_scope_t(
        Base.unsafe_convert(MPI.MPI_Comm, comm), Np, Iam
    )
end

function Base.getproperty(g::Grid, s::Symbol)
    # Julia level functions expect a Comm, not an MPI_Comm / Int32.
    s === :comm && return getfield(g, s)
    s === :gridinfo && return getfield(g, s)
    return getfield(g.gridinfo, s)
end

# Option functions:
###################
const Options = Common.superlu_dist_options_t
Base.unsafe_convert(::Type{Ptr{superlu_dist_options_t}}, O::superlu_dist_options_t) = 
    Ptr{superlu_dist_options_t}(pointer_from_objref(O))

# ScalePerm (ScalePermstruct_t) functions:
##########################################
struct ScalePerm{T, I, S}
    scaleperm::S
end
ScalePerm{T}(m, n) where T = ScalePerm{T, Int}(m, n)
ScalePerm{T, I}(m, n) where {T, Ti, I<:CIndex{Ti}} = 
    ScalePerm{T, Ti}(m, n)

function Base.getproperty(g::ScalePerm, s::Symbol)
    s === :scaleperm && return Base.getfield(g, s)
    return getproperty(g.scaleperm, s)
end
for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    libname = Symbol(:libsuperlu_dist_, I)
    for T ∈ (Float32, Float64, ComplexF64)
    @eval begin
    
    function ScalePerm{$T, $I}(m, n)
        r = Common.$(prefixname(T, :ScalePermstruct_t)){$I}(
            Common.NOEQUIL,
            Ptr{Cvoid}(), Ptr{Cvoid}(),
            Ptr{$I}(Libc.malloc(sizeof($I) * m)),
            Ptr{$I}(Libc.malloc(sizeof($I) * n))
        )
        
        return ScalePerm{$T, $I, typeof(r)}(finalizer(r) do x
            if !MPI.Finalized()
                Libc.free(x.perm_r)
                Libc.free(x.perm_c)
                (x.DiagScale == Common.ROW || x.DiagScale == Common.BOTH) && Libc.free(x.R)
                (x.DiagScale == Common.COL || x.DiagScale == Common.BOTH) && Libc.free(x.C)
            end
        end)
    end
    Base.unsafe_convert(T::Type{Ptr{$(prefixname(T, :ScalePermstruct_t)){$I}}}, S::ScalePerm{$T, $I}) = 
        Base.unsafe_convert(T, S.scaleperm)
    Base.unsafe_convert(T::Type{Ptr{$(prefixname(T, :ScalePermstruct_t)){$I}}}, S::$(prefixname(T, :ScalePermstruct_t)){$I}) = 
    Ptr{$(prefixname(T, :ScalePermstruct_t)){$I}}(pointer_from_objref(S))
end # end eval
end # end for
end # end for

# LUFactors (LUstruct_t) functions:
###################################
struct LUFactors{T, I, S, G}
    LU::S
    grid::G
    n::I
end
LUFactors{T}(n, grid) where T = LUFactors{T, Int}(n, grid)
LUFactors{T, I}(n, grid) where {T, Ti, I<:CIndex{Ti}} = LUFactors{T, Ti}(n, grid)

function Base.getproperty(g::LUFactors, s::Symbol)
    s === :LU && return Base.getfield(g, s)
    s === :grid && return Base.getfield(g, s)
    s === :n && return Base.getfield(g, s)
    return getproperty(g.LU, s)
end

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    libname = Symbol(:libsuperlu_dist_, I)
    for T ∈ (Float32, Float64, ComplexF64)
    @eval begin
    function LUFactors{$T, $I}(n, grid::G) where G
        r = Common.$(prefixname(T, :LUstruct_t)){$I}(Ptr{Cvoid}(), Ptr{Cvoid}(), Ptr{Cvoid}(), '\0')
        LUstructInit(r, n, grid)
        return LUFactors{$T, $I, eltype(r), G}(r, grid, n)
    end
    Base.unsafe_convert(T::Type{Ptr{$(prefixname(T, :LUstruct_t)){$I}}}, S::LUFactors{$T, $I}) = 
        Base.unsafe_convert(T, S.LU)
    Base.unsafe_convert(
        ::Type{Ptr{$(prefixname(T, :LUstruct_t)){$I}}}, 
        L::$(prefixname(T, :LUstruct_t)){$I}
    ) = Ptr{$(prefixname(T, :LUstruct_t)){$I}}(pointer_from_objref(L))
    end # end eval
    end # end for
end # end for

# LUStat (SuperLUStat_t) functions:
###################################
struct LUStat{I, S}
    stat::S
end
LUStat() = LUStat{Int}()
LUStat{I}() where {Ti, I<:CIndex{Ti}} = LUStat{Ti}()

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    libname = Symbol(:libsuperlu_dist_, I)
    @eval begin
        function PStatInit(r::SuperLUStat_t{$I})
            $L.PStatInit(r)
            return finalizer(r) do x
                !MPI.Finalized() && $L.PStatFree(x)
            end
        end
        function LUStat{$I}()
            r = SuperLUStat_t{$I}(
                Ptr{Cvoid}(),
                Ptr{Cvoid}(),
                Ptr{Cvoid}(),
                0, 0, 0, 0., 0., 0., 0, 0
            )
            PStatInit(r)
            return LUStat{$I, typeof(r)}(r)
        end
        Base.unsafe_convert(T::Type{Ptr{Common.SuperLUStat_t{$I}}}, S::LUStat{$I}) = 
            Base.unsafe_convert(T, S.stat)
        Base.unsafe_convert(
            ::Type{Ptr{Common.SuperLUStat_t{$I}}}, 
            S::Common.SuperLUStat_t{$I}
        ) = Ptr{Common.SuperLUStat_t{$I}}(pointer_from_objref(S))

        function PStatPrint(options, stat::LUStat{$I}, grid)
            $L.PStatPrint(options, stat, grid)
        end
    end # end eval
end # end for

# SolveData (SOLVEstruct_t) functions:
######################################
mutable struct SolveData{T, I, S}
    data::S
    options::Options
end
SolveData{T}(options) where T = SolveData{T, Int}(options)

SolveData{T, I}(options) where {T, Ti, I<:CIndex{Ti}} = 
    SolveData{T, Ti}(options)

function Base.getproperty(g::SolveData, s::Symbol)
    s === :options && return Base.getfield(g, s)
    s === :data && return Base.getfield(g, s)
    return getproperty(g.data, s)
end

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    libname = Symbol(:libsuperlu_dist_, I)
    for T ∈ (Float32, Float64, ComplexF64)
    @eval begin
    Base.unsafe_convert(T::Type{Ptr{$L.$(prefixname(T, :SOLVEstruct_t)){$I}}}, S::SolveData{$T, $I}) = 
        Base.unsafe_convert(T, S.data)
    Base.unsafe_convert(
        T::Type{Ptr{$L.$(prefixname(T, :SOLVEstruct_t)){$I}}}, 
        S::$L.$(prefixname(T, :SOLVEstruct_t)){$I}
    ) = Ptr{$L.$(prefixname(T, :SOLVEstruct_t)){$I}}(pointer_from_objref(S))
        
    function SolveData{$T, $I}(options)
        r = $L.$(prefixname(T, :SOLVEstruct_t)){$I}(
            Ptr{Cvoid}(),
            Ptr{Cvoid}(),
            0,
            Ptr{Cvoid}(),
            Ptr{Cvoid}(),
            Ptr{Cvoid}(),
            Ptr{Cvoid}(),
            Ptr{Cvoid}(),
            Ptr{Cvoid}(),
            Ptr{Cvoid}()
        )
        S = SolveData{$T, $I, eltype(r)}(r, options)
        return finalizer(S) do solve
            !MPI.Finalized() && options.SolveInitialized == Common.YES &&
            $L.$(prefixname(T, :SolveFinalize))(options, solve)
        end
    end
    end # end eval
end # end for
end # end for

mutable struct SuperLUFactorization{T, I, A, Solve, Perm, Factors, Stat, B} <: LinearAlgebra.Factorization{T}
    mat::A
    options::Options
    solve::Solve
    perm::Perm
    factors::Factors
    stat::Stat
    berr::Vector{T}
    b::B
    function SuperLUFactorization{T, I, A, Solve, Perm, Factors, Stat, B}(
        mat::A, options::Options, solve::Solve, perm::Perm,
        factors::Factors, stat::Stat, berr::Vector{T}, b::B
    ) where {
        T<:Union{Float32, Float64, ComplexF64}, 
        I <: Union{Int32, Int64}, 
        A <: AbstractSuperMatrix{T, I},
        Solve <: Union{SolveData{T, I}, Nothing},
        Perm <: ScalePerm{T, I},
        Factors <: LUFactors{T, I},
        Stat <: LUStat{I},
        B <: StridedVecOrMat{T}
    }
        return new(mat, options, solve, perm, factors, stat, berr, b)
    end
end
isfactored(F::SuperLUFactorization) = F.options.Fact == Common.FACTORED

function SuperLUFactorization(
    A::AbstractSuperMatrix{Tv, Ti}, options, 
    solve::Solve, perm::Perm, factors::Factors, stat::Stat, berr::Vector{Tv}, b::B
) where {Tv, Ti, Solve, Perm, Factors, Stat, B}
    return SuperLUFactorization{Tv, Ti, typeof(A), Solve, Perm, Factors, Stat, B}(
        A, options, solve, perm, factors, stat, berr, b
    )
end

function PStatPrint(F::SuperLUFactorization)
    PStatPrint(F.options, F.stat, F.mat.grid)
end

for I ∈ (:Int32, :Int64)
    L = Symbol(String(:SuperLU_) * String(I))
    libname = Symbol(:libsuperlu_dist_, I)
    @eval begin
        superlu_set_num_threads(::Type{$I}, n) = 
            ccall(
                (:omp_set_num_threads_, $libname), Cvoid, (Ref{Int32},), Int32(n)
            )
        # SuperMatrix functions:
        ########################
        Base.unsafe_convert(T::Type{Ptr{SuperMatrix{$I}}}, A::AbstractSuperMatrix{<:Any, $I}) = 
            Base.unsafe_convert(T, A.supermatrix)
    end
    for T ∈ (Float32, Float64, ComplexF64)
        @eval begin
        function inf_norm_error_dist(n, nrhs, b, ldb, xtrue::AbstractVector{$T}, ldx, grid::Grid{$I})
            return $L.$(prefixname(T, :inf_norm_error_dist))(n, nrhs, b, ldb, xtrue, ldx, grid)
        end
    end
    end
end
