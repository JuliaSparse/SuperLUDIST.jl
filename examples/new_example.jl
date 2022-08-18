using MPI
using SuperLU_DIST
#main(int argc, char *argv[]) llel for julia
const LSLU = SuperLU_DIST.Libsuperlu_dist

options = superlu_dist_options_t()
stat = SuperLUStat_t()
A = SuperMatrix()
ScalePermstruct = dScalePermstruct_t()
LUstruct = dLUstruct_t()
gridref = Ref{gridinfo_t}()
#C_NULL or something else?
m,n,a,nnz,asub,xa = 
Ref{Int64}(), 
Ref{Int64}(), 
Ref{Ptr{Float64}}(), 
Ref{Int64}(), 
Ref{Ptr{Int64}}(), 
Ref{Ptr{Int64}}()
info = C_NULL

"""
berr = 0.0
a, b, xtrue = 0.0, 0.0, 0.0

asub, xa = 0, 0
m, n, nnz = 0, 0, 0
nprow, npcol = 0, 0, 0

iam, info, ldb, ldx, nrhs = 0, 0, 0, 0, 0 

trans = C_NULL

#char     trans[1];
#char     **cpp, c;
#FILE *fp, *fopen();
#extern int cpp_defs();

nrhs = 1;  
"""
#m, n, nnz, a, asub, xa = 0, 0, 0, 0.0, 0, 0 # Remove later
MPI.Init()
#MPI_Init( &argc, &argv );
# How to pass the nprow and npcol? lets have them fixed value now
nprow = 1
npcol = 1
#Let have fixed file name for now! we will chage it later
fp = open("examples/g20.rua", "r")
println(MPI.COMM_WORLD)
superlu_gridinit(MPI.COMM_WORLD, nprow, npcol, gridref)
grid = gridref[]
println(grid.comm)
# exit()



iam = grid.iam

if iam == -1 
    LSLU.superlu_gridexit(Ref(grid))
    MPI.Finalize()
    exit()
end

print("\n")
print("hi")

fpp = Base.Libc.FILE(fp)

print("\n")
print("FILE ptr")


# LSLU.dreadhb_dist(iam, fpp, m, n, nnz, a, asub, xa)
#MPI.Finalize()

#grid.comm = MPI.COMM_WORLD

print("\n")
print("gird.coom")

if iam == 0
    # dreadhb_dist(int iam, FILE *fp, int_t *nrow, int_t *ncol, int_t *nonz, double **nzval, int_t **rowind, int_t **colptr)
    # @ccall libsuperlu_ddefs.dreadhb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, 
    #arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
    #print("hi")
    #MPI.Finalize()
    LSLU.dreadhb_dist(iam, fpp, m, n, nnz, a, asub, xa)
    m = m[]
    n = n[]
    nnz = nnz[]
    a = a[]
    asub = asub[]
    xa = xa[]
    print("\n")
    print("after dreadhb_dist")
    #print("hi")
    #MPI.Finalize()
    #Bcast vs Bcast! c ver MPI_Bcast( &m,   1,   mpi_int_t,  0, grid.comm );
    # MPI_Bcast(void *buffer, int count, MPI_Datatype datatype, int root, MPI_Comm comm)
    MPI.bcast(m, 0, MPI.Comm(grid.comm)) # Julia Bcast!(buf, root::Integer, comm::Comm)
    # I am leaving out count and  MPI_datatype hope MPI.jl handels it:)
    print("\n")
    print(m[])
	MPI.bcast(n, 0, MPI.Comm(grid.comm))
	MPI.bcast(nnz, 0, MPI.Comm(grid.comm))
	MPI.Bcast!(a, 0, MPI.Comm(grid.comm))
	MPI.Bcast!(asub, 0, MPI.Comm(grid.comm))
	MPI.Bcast!(xa, 0, MPI.Comm(grid.comm))
else 
    MPI.bcast(m, 0, MPI.COMM_WORLD) 
    print("\n")
    print("Bacst")
	MPI.bcast(n, 0, grid.comm)
	MPI.bcast(nnz, 0, grid.comm)

    LSLU.dallocateA_dist(n, nnz, Ref(a), Ref(asub), Ref(xa));

	MPI.Bcast!(a, 0, grid.comm)
	MPI.Bcast!(asub, 0, grid.comm)
	MPI.Bcast!(xa, 0, grid.comm)
end

print("#####")
MPI.Finalize()
#=
"""
@enum Dtype_t::UInt32 begin
    SLU_S = 0
    SLU_D = 1
    SLU_C = 2
    SLU_Z = 3
end

https://github.com/xiaoyeli/superlu_dist/blob/ac353e46cdf817b9738f679d4551efd879f15ead/SRC/supermatrix.h

dCreate_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t,
arg3::int_t, arg4::int_t, arg5::Ptr{Cdouble}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Stype_t, arg9::Dtype_t, arg10::Mtype_t)::Cvoid
"""
LSLU.dCreate_CompCol_Matrix_dist(Ref(A), m, n, nnz, Ref(a), Ref(asub), Ref(xa), SLU_NC, SLU_D, SLU_GE);

#if (!(b=doubleMalloc_dist(m*nrhs))) ABORT("Malloc fails for b[]")
#if (!(xtrue=doubleMalloc_dist(n*nrhs))) ABORT("Malloc fails for xtrue[]")
#libsuperlu_ddefs.doubleMalloc_dist(arg1::int_t)::Ptr{Cdouble}
b = LSLU.doubleMalloc_dist(m*nrhs)
xtrue = LSLU.doubleMalloc_dist(n*nrhs) #haven't init xtrue

trans = 'N'
ldx = n
ldb = m
dGenXtrue_dist(n, nrhs, xtrue, ldx);
dFillRHS_dist(trans, nrhs, xtrue, ldx, Ref(A), b, ldb);

#if ( !(berr = doubleMalloc_dist(nrhs)) ) ABORT("Malloc fails for berr[].");

berr = LSLU.doubleMalloc_dist(nrhs)
"""
options.Fact = DOFACT
options.Equil = YES
options.ColPerm = METIS_AT_PLUS_A
options.RowPerm = LargeDiag_MC64
options.ReplaceTinyPivot = YES
options.Trans = NOTRANS
options.IterRefine = DOUBLE
options.SolveInitialized = NO
options.RefineInitialized = NO
options.PrintStat = YES
"""
LSLU.set_default_options_dist(Ref(options))

if !iam
	LSLU.print_options_dist(&options)
end

LSLU.dScalePermstructInit(m, n, Ref(ScalePermstruct))
LSLU.dLUstructInit(n, Ref(LUstruct))

LSLU.PStatInit(Ref(stat))

LSLU.pdgssvx_ABglobal(Ref(options), Ref(A), Ref(ScalePermstruct), b, ldb,
 nrhs, Ref(grid), Ref(LUstruct), berr, Ref(stat), Ref(info))

if !iam
    LSLU.dinf_norm_error_dist(n, nrhs, b, ldb, xtrue, ldx, Ref(grid))
end

LSLU.PStatPrint(Ref(options), Ref(stat), Ref(grid))

LSLU.PStatFree(Ref(stat))
LSLU.Destroy_CompCol_Matrix_dist(Ref(A))
LSLU.dDestroy_LU(n, Ref(grid), Ref(LUstruct))
LSLU.dScalePermstructFree(Ref(ScalePermstruct))
LSLU.dLUstructFree(Ref(LUstruct))
LSLU.SUPERLU_FREE(b)
LSLU.SUPERLU_FREE(xtrue)
LSLU.SUPERLU_FREE(berr)
LSLU.close(fp)  #close and open in julia might be different!
=#