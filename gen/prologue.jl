import MPI: MPI_Comm, MPI_Request, MPI_Datatype, MPI_Errhandler

# from <limits.h>, used by some of the generated macro constants
const INT_MAX = typemax(Cint)
