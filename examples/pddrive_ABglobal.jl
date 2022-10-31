using MPI
using SuperLU_DIST
MPI.Init()
gridref = Ref{SuperLU_DIST.gridinfo_t}()
nprow, npcol, nrhs = 2, 2, 1
root = 0
comm = MPI.COMM_WORLD
SuperLU_DIST.superlu_gridinit(comm, nprow, npcol, gridref)
grid = gridref[]

iam = grid.iam
if iam == -1
    @info "I was not in the grid :("
    SuperLU_DIST.superlu_gridexit(gridref)
    MPI.Finalize()
end

fp = open("examples/big.rua", "r")
fpp = Base.Libc.FILE(fp)


m, n, nnz = Ref{Int32}(), Ref{Int32}(), Ref{Int32}()
aref, asubref, xaref = Ref{Ptr{Float64}}(), Ref{Ptr{Int32}}(), Ref{Ptr{Int32}}()

if iam == root
    SuperLU_DIST.dreadhb_dist(iam, fpp, m, n, nnz, aref, asubref, xaref)
end

MPI.Bcast!(m, root, comm)
MPI.Bcast!(n, root, comm)
MPI.Bcast!(nnz, root, comm)
println("$iam has nnz: $(nnz[])\n")
MPI.Barrier(comm)
m = m[]
n = n[]
nnz = nnz[]
if iam != root
    SuperLU_DIST.dallocateA_dist(n, nnz, aref, asubref, xaref)
    println("$iam has allocated!")
end
MPI.Barrier(comm)
# don't need to check that iam == root, we allocated for everyone just above.
a = unsafe_wrap(Array, aref[], nnz)
asub = unsafe_wrap(Array, asubref[], nnz)
xa = unsafe_wrap(Array, xaref[], n + 1)


MPI.Bcast!(a, root, comm)
MPI.Bcast!(asub, root, comm)
MPI.Bcast!(xa, root, comm)
MPI.Barrier(comm)

A = Ref{SuperLU_DIST.SuperMatrix}()
SuperLU_DIST.dCreate_CompCol_Matrix_dist(
    A, m, n, nnz, a, asub, xa, 
    SuperLU_DIST.SLU_NC, SuperLU_DIST.SLU_D, SuperLU_DIST.SLU_GE
)
b = SuperLU_DIST.doubleMalloc_dist(m * nrhs)
xtrue = SuperLU_DIST.doubleMalloc_dist(n * nrhs)
xjl = unsafe_wrap(Array, xtrue, n * nrhs)
trans = Ref{Cchar}('N')
ldx = n
ldb = m
if iam == root
    SuperLU_DIST.dGenXtrue_dist(n, nrhs, xtrue, ldx)
end
MPI.Bcast!(xjl, root, comm)

SuperLU_DIST.dFillRHS_dist(trans, nrhs, xtrue, ldx, A, b, ldb)

berr = SuperLU_DIST.doubleMalloc_dist(nrhs)

options = Ref{SuperLU_DIST.superlu_dist_options_t}()
SuperLU_DIST.set_default_options_dist(options)

if iam == root
    SuperLU_DIST.print_options_dist(options)
end
ScalePermstruct = Ref{SuperLU_DIST.dScalePermstruct_t}()
SuperLU_DIST.dScalePermstructInit(m, n, ScalePermstruct)

LUstruct = Ref{SuperLU_DIST.dLUstruct_t}()
SuperLU_DIST.dLUstructInit(n, LUstruct)

stat = Ref{SuperLU_DIST.SuperLUStat_t}()
SuperLU_DIST.PStatInit(stat)


# NOTES: ONly A and L * U and RHS are distributed, everything else is replicated
info = Ref{Int32}()

# SuperLU_DIST.dPrint_CompCol_Matrix_dist(A)
# NOTE: PDDrive is the distributed driver.
# Can turn LU into CSC from SuperLU.
GC.@preserve a asub xa SuperLU_DIST.pdgssvx_ABglobal(
    options, A, ScalePermstruct, b, ldb, nrhs, 
    gridref, LUstruct, berr, stat, info)

SuperLU_DIST.dinf_norm_error_dist(n, nrhs, b, ldb, xtrue, ldx, gridref)
SuperLU_DIST.PStatPrint(options, stat, gridref)
SuperLU_DIST.PStatFree(stat)
SuperLU_DIST.Destroy_CompCol_Matrix_dist(A)
SuperLU_DIST.dDestroy_LU(n, gridref, LUstruct)
SuperLU_DIST.dScalePermstructFree(ScalePermstruct)
SuperLU_DIST.dLUstructFree(LUstruct)
SuperLU_DIST.superlu_free_dist.((b, xtrue, berr))
close(fp)

SuperLU_DIST.superlu_gridexit(gridref)

MPI.Finalize()

