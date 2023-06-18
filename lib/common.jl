# common structs between int32 and int64:

module SuperLUDIST_Common
import MPI: MPI_Comm, MPI_Request, MPI_Datatype, MPI_Errhandler
using SuperLU_Base.Common
export gridinfo_t, gridinfo3d_t, C_Tree, superlu_scope_t, commRequests_t

struct commRequests_t
    L_diag_blk_recv_req::Ptr{MPI_Request}
    L_diag_blk_send_req::Ptr{MPI_Request}
    U_diag_blk_recv_req::Ptr{MPI_Request}
    U_diag_blk_send_req::Ptr{MPI_Request}
    recv_req::Ptr{MPI_Request}
    recv_requ::Ptr{MPI_Request}
    send_req::Ptr{MPI_Request}
    send_requ::Ptr{MPI_Request}
end
struct C_Tree
    sendRequests_::NTuple{2, MPI_Request}
    comm_::MPI_Comm
    myRoot_::Cint
    destCnt_::Cint
    myDests_::NTuple{2, Cint}
    myRank_::Cint
    msgSize_::Cint
    tag_::Cint
    empty_::yes_no_t
    type_::MPI_Datatype
end
struct superlu_scope_t
    comm::MPI_Comm
    Np::Cint
    Iam::Cint
end

struct gridinfo_t{I}
    comm::MPI_Comm
    rscp::superlu_scope_t
    cscp::superlu_scope_t
    iam::Cint
    nprow::I
    npcol::I
end

struct gridinfo3d_t{I}
    comm::MPI_Comm
    rscp::superlu_scope_t
    cscp::superlu_scope_t
    zscp::superlu_scope_t
    grid2d::gridinfo_t{I}
    iam::Cint
    nprow::I
    npcol::I
    npdep::I
    rankorder::Cint
end
end