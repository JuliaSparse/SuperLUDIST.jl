module SuperLU_Int32

import MPI: MPI_Comm, MPI_Request, MPI_Datatype, MPI_Errhandler

# from <limits.h>, used by some of the generated macro constants
const INT_MAX = typemax(Cint)

using ..SuperLUDIST_Common
import ..SuperLUDIST: libsuperlu_dist_Int32


function superlu_abort_and_exit_dist(arg1)
    @ccall libsuperlu_dist_Int32.superlu_abort_and_exit_dist(arg1::Ptr{Cchar})::Cvoid
end

function superlu_malloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.superlu_malloc_dist(arg1::Csize_t)::Ptr{Cvoid}
end

function superlu_free_dist(arg1)
    @ccall libsuperlu_dist_Int32.superlu_free_dist(arg1::Ptr{Cvoid})::Cvoid
end

const int_t = Cint

function SuperLU_timer_dist_()
    @ccall libsuperlu_dist_Int32.SuperLU_timer_dist_()::Cdouble
end

mutable struct CUevent_st end

const gpuEvent_t = Ptr{CUevent_st}

struct SuperMatrix
    Stype::Stype_t
    Dtype::Dtype_t
    Mtype::Mtype_t
    nrow::int_t
    ncol::int_t
    Store::Ptr{Cvoid}
end

"""
    NCformat

The storage schemes are defined as follows. *
"""
struct NCformat
    nnz::int_t
    nzval::Ptr{Cvoid}
    rowind::Ptr{int_t}
    colptr::Ptr{int_t}
end

struct NRformat
    nnz::int_t
    nzval::Ptr{Cvoid}
    colind::Ptr{int_t}
    rowptr::Ptr{int_t}
end

struct SCformat
    nnz::int_t
    nsuper::int_t
    nzval::Ptr{Cvoid}
    nzval_colptr::Ptr{int_t}
    rowind::Ptr{int_t}
    rowind_colptr::Ptr{int_t}
    col_to_sup::Ptr{int_t}
    sup_to_col::Ptr{int_t}
end

struct SCPformat
    nnz::int_t
    nsuper::int_t
    nzval::Ptr{Cvoid}
    nzval_colbeg::Ptr{int_t}
    nzval_colend::Ptr{int_t}
    rowind::Ptr{int_t}
    rowind_colbeg::Ptr{int_t}
    rowind_colend::Ptr{int_t}
    col_to_sup::Ptr{int_t}
    sup_to_colbeg::Ptr{int_t}
    sup_to_colend::Ptr{int_t}
end

struct NCPformat
    nnz::int_t
    nzval::Ptr{Cvoid}
    rowind::Ptr{int_t}
    colbeg::Ptr{int_t}
    colend::Ptr{int_t}
end

struct DNformat
    lda::int_t
    nzval::Ptr{Cvoid}
end

struct NRformat_loc
    nnz_loc::int_t
    m_loc::int_t
    fst_row::int_t
    nzval::Ptr{Cvoid}
    rowptr::Ptr{int_t}
    colind::Ptr{int_t}
end

struct NRformat_loc3d
    A_nfmt::Ptr{NRformat_loc}
    B3d::Ptr{Cvoid}
    ldb::Cint
    nrhs::Cint
    m_loc::Cint
    B2d::Ptr{Cvoid}
    row_counts_int::Ptr{Cint}
    row_disp::Ptr{Cint}
    nnz_counts_int::Ptr{Cint}
    nnz_disp::Ptr{Cint}
    b_counts_int::Ptr{Cint}
    b_disp::Ptr{Cint}
    num_procs_to_send::Cint
    procs_to_send_list::Ptr{Cint}
    send_count_list::Ptr{Cint}
    num_procs_to_recv::Cint
    procs_recv_from_list::Ptr{Cint}
    recv_count_list::Ptr{Cint}
end

const flops_t = Cfloat

const Logical = Cuchar

struct SuperLUStat_t
    panel_histo::Ptr{Cint}
    utime::Ptr{Cdouble}
    ops::Ptr{flops_t}
    TinyPivots::Cint
    RefineSteps::Cint
    num_look_aheads::Cint
    current_buffer::Cfloat
    peak_buffer::Cfloat
    gpu_buffer::Cfloat
    MaxActiveBTrees::int_t
    MaxActiveRTrees::int_t
    ScatterMOPCounter::Cdouble
    ScatterMOPTimer::Cdouble
    GemmFLOPCounter::Cdouble
    GemmFLOPTimer::Cdouble
    cPCIeH2D::Cdouble
    cPCIeD2H::Cdouble
    tHost_PCIeH2D::Cdouble
    tHost_PCIeD2H::Cdouble
    isOffloaded::Ptr{Cint}
    GemmStart::Ptr{gpuEvent_t}
    GemmEnd::Ptr{gpuEvent_t}
    ScatterEnd::Ptr{gpuEvent_t}
    ePCIeH2D::Ptr{gpuEvent_t}
    ePCIeD2H_Start::Ptr{gpuEvent_t}
    ePCIeD2H_End::Ptr{gpuEvent_t}
end

struct e_node
    size::Cint
    mem::Ptr{Cvoid}
end

const SuperLU_ExpHeader = e_node

struct SuperLU_LU_stack_t
    size::Cint
    used::Cint
    top1::Cint
    top2::Cint
    array::Ptr{Cvoid}
end

"""
    SCT_t

* For 3D code 
"""
struct SCT_t
    datatransfer_count::int_t
    schurPhiCallCount::int_t
    PhiMemCpyCounter::int_t
    acc_load_imbal::Cdouble
    LookAheadGEMMFlOp::Cdouble
    PhiWaitTimer_2::Cdouble
    LookAheadGEMMTimer::Cdouble
    LookAheadRowSepTimer::Cdouble
    LookAheadScatterTimer::Cdouble
    GatherTimer::Cdouble
    GatherMOP::Cdouble
    scatter_mem_op_counter::Cdouble
    LookAheadRowSepMOP::Cdouble
    scatter_mem_op_timer::Cdouble
    schur_flop_counter::Cdouble
    schur_flop_timer::Cdouble
    CPUOffloadTimer::Cdouble
    PhiWaitTimer::Cdouble
    NetSchurUpTimer::Cdouble
    AssemblyTimer::Cdouble
    PhiMemCpyTimer::Cdouble
    datatransfer_timer::Cdouble
    LookAheadScatterMOP::Cdouble
    schurPhiCallTimer::Cdouble
    autotunetime::Cdouble
    Predicted_acc_sch_time::Ptr{Cdouble}
    Predicted_acc_gemm_time::Ptr{Cdouble}
    Predicted_acc_scatter_time::Ptr{Cdouble}
    trf2_flops::Cdouble
    trf2_time::Cdouble
    offloadable_flops::Cdouble
    offloadable_mops::Cdouble
    SchurCompUdtThreadTime::Ptr{Cdouble}
    Predicted_host_sch_time::Ptr{Cdouble}
    Measured_host_sch_time::Ptr{Cdouble}
    pdgstrs2_timer::Cdouble
    pdgstrf2_timer::Cdouble
    lookaheadupdatetimer::Cdouble
    OffloadSectionTimer::Cdouble
    pdgstrfTimer::Cdouble
    Local_Dgstrf2_Thread_tl::Ptr{Cdouble}
    Wait_UDiagBlock_Recv_tl::Cdouble
    Wait_LDiagBlock_Recv_tl::Cdouble
    Recv_UDiagBlock_tl::Cdouble
    Wait_UDiagBlockSend_tl::Cdouble
    L_PanelUpdate_tl::Cdouble
    U_PanelUpdate_tl::Cdouble
    Bcast_UPanel_tl::Cdouble
    Bcast_LPanel_tl::Cdouble
    Wait_LSend_tl::Cdouble
    Wait_USend_tl::Cdouble
    Wait_URecv_tl::Cdouble
    Wait_LRecv_tl::Cdouble
    GetAijLock_Thread_tl::Ptr{Cdouble}
    PDGSTRS2_tl::Cdouble
    Phase_Factor_tl::Cdouble
    Phase_LU_Update_tl::Cdouble
    Phase_SC_Update_tl::Cdouble
    ancsReduce::Cdouble
    gatherLUtimer::Cdouble
    tFactor3D::NTuple{32, Cdouble}
    tSchCompUdt3d::NTuple{32, Cdouble}
    tAsyncPipeTail::Cdouble
    tStartup::Cdouble
    tStartupGPU::Cdouble
    commVolFactor::Cdouble
    commVolRed::Cdouble
    tDiagFactorPanelSolve::Cdouble
    tPanelBcast::Cdouble
end

"""
    Pslu_freeable_t

\\brief

<pre>
-- Structure returned by the symbolic factorization routine

Memory is allocated during parallel symbolic factorization
symbfact_dist, and freed after dist_symbLU routine.

(xlsub,lsub): lsub[*] contains the compressed subscript of
rectangular supernodes; xlsub[j] points to the starting
location of the j-th column in lsub[*]. Note that xlsub 
is indexed by column.
Storage: row subscripts

(xusub,usub): lsub[*] contains the compressed subscript of
rectangular supernodes; xusub[j] points to the starting
location of the j-th row in usub[*]. Note that xusub 
is indexed by rows.
Storage: column subscripts

(xsup_beg_loc,xsup_end_loc, supno_loc) describes mapping between 
     supernode and column, information local to each processor:
xsup_beg_loc[s] is the leading column of the local s-th supernode.
xsup_end_loc[s] is the last column of the local s-th supernode.
     supno[i] is the supernode no to which column i belongs;
</pre>
"""
struct Pslu_freeable_t
    xlsub::Ptr{int_t}
    lsub::Ptr{int_t}
    szLsub::int_t
    xusub::Ptr{int_t}
    usub::Ptr{int_t}
    szUsub::int_t
    supno_loc::Ptr{int_t}
    xsup_beg_loc::Ptr{int_t}
    xsup_end_loc::Ptr{int_t}
    nvtcs_loc::int_t
    globToLoc::Ptr{int_t}
    maxNvtcsPProc::int_t
    nnzLU::Int64
end

"""
    Llu_symbfact_t

\\brief

<pre>
-- The structures are determined by symbfact_dist and not used thereafter.

(xlsub,lsub): lsub[*] contains the compressed subscript of L, as described above
     for Pslu_freeable_t.  This structure is used internally in symbfact_dist.
(xusub,usub): usub[*] contains the compressed subscript of U, as described above
     for Pslu_freeable_t.  This structure is used internally in symbfact_dist.

(xlsubPr,lsubPr): contains the pruned structure of the graph of
     L, stored by rows as a linked list.
xlsubPr[j] points to the starting location of the j-th 
     row in lsub[*].
Storage: original row subscripts.
     It contains the structure corresponding to one node in the sep_tree.
     In each independent domain formed by x vertices, xlsubPr is of size x.
     Allocated and freed during domain_symbolic.
     For the other nodes in the level tree, formed by a maximum of 
     maxNvtcsNds_loc, xlsubPr is of size maxNvtcsNds_loc. 
     Allocated after domain_symbolic, freed at the end of symbolic_dist
     routine.
(xusubPr,usubPr): contains the pruned structure of the graph of
     U, stored by columns as a linked list.  Similar to (xlsubPr,lsubPr),
     except that it is column oriented. 

This is allocated during symbolic factorization symbfact_dist.
</pre>
"""
struct Llu_symbfact_t
    xlsubPr::Ptr{int_t}
    lsubPr::Ptr{int_t}
    szLsubPr::int_t
    indLsubPr::int_t
    xusubPr::Ptr{int_t}
    usubPr::Ptr{int_t}
    szUsubPr::int_t
    indUsubPr::int_t
    xlsub_rcvd::Ptr{int_t}
    xlsub::Ptr{int_t}
    lsub::Ptr{int_t}
    szLsub::int_t
    nextl::int_t
    xusub_rcvd::Ptr{int_t}
    xusub::Ptr{int_t}
    usub::Ptr{int_t}
    szUsub::int_t
    nextu::int_t
    cntelt_vtcs::Ptr{int_t}
    cntelt_vtcsA_lvl::Ptr{int_t}
    MemModel::LU_space_t
    no_expand::int_t
    no_expand_pr::int_t
    no_expcp::int_t
end

"""
    vtcsInfo_symbfact_t

! \\brief Local information on vertices distribution 
"""
struct vtcsInfo_symbfact_t
    maxSzBlk::int_t
    maxNvtcsNds_loc::int_t
    maxNeltsVtx::int_t
    nblks_loc::int_t
    begEndBlks_loc::Ptr{int_t}
    curblk_loc::int_t
    nvtcs_loc::int_t
    nvtcsLvl_loc::int_t
    filledSep::Cint
    nnz_asup_loc::int_t
    nnz_ainf_loc::int_t
    xusub_nextLvl::int_t
    xlsub_nextLvl::int_t
    fstVtx_nextLvl::int_t
end

"""
    matrix_symbfact_t

! \\brief Structure used for redistributing A for the symbolic factorization algorithm 
"""
struct matrix_symbfact_t
    x_ainf::Ptr{int_t}
    ind_ainf::Ptr{int_t}
    x_asup::Ptr{int_t}
    ind_asup::Ptr{int_t}
end

struct comm_symbfact_t
    rcv_interLvl::Ptr{int_t}
    snd_interLvl::Ptr{int_t}
    snd_interSz::Ptr{int_t}
    snd_LinterSz::Ptr{int_t}
    snd_vtxinter::Ptr{int_t}
    snd_intraLvl::Ptr{int_t}
    snd_intraSz::int_t
    snd_LintraSz::int_t
    rcv_intraLvl::Ptr{int_t}
    rcv_buf::Ptr{int_t}
    rcv_bufSz::int_t
    snd_buf::Ptr{int_t}
    snd_bufSz::int_t
    ptr_rcvBuf::Ptr{int_t}
end

"""
    psymbfact_stat_t

! \\brief statistics collected during parallel symbolic factorization 
"""
struct psymbfact_stat_t
    fill_par::int_t
    relax_seps::Cfloat
    relax_curSep::Cfloat
    relax_gen::Cfloat
    nops::Cfloat
    nDnsCurSep::int_t
    nDnsUpSeps::int_t
    no_shmSnd::Cfloat
    no_msgsSnd::Cfloat
    maxsz_msgSnd::int_t
    sz_msgsSnd::Cfloat
    no_shmRcvd::Cfloat
    no_msgsRcvd::Cfloat
    maxsz_msgRcvd::int_t
    sz_msgsRcvd::Cfloat
    no_msgsCol::Cfloat
    maxsz_msgCol::int_t
    sz_msgsCol::Cfloat
    fill_pelt::NTuple{6, Cfloat}
    estimLSz::int_t
    estimUSz::int_t
    maxSzLPr::int_t
    maxSzUPr::int_t
    maxSzBuf::int_t
    szDnsSep::int_t
    allocMem::Cfloat
end

const handle_t = Int64

struct superlu_scope_t
    comm::MPI_Comm
    Np::Cint
    Iam::Cint
end

struct gridinfo_t
    comm::MPI_Comm
    rscp::superlu_scope_t
    cscp::superlu_scope_t
    iam::Cint
    nprow::int_t
    npcol::int_t
end

struct gridinfo3d_t
    comm::MPI_Comm
    rscp::superlu_scope_t
    cscp::superlu_scope_t
    zscp::superlu_scope_t
    grid2d::gridinfo_t
    iam::Cint
    nprow::int_t
    npcol::int_t
    npdep::int_t
    rankorder::Cint
end

struct Glu_persist_t
    xsup::Ptr{int_t}
    supno::Ptr{int_t}
end

struct Glu_freeable_t
    lsub::Ptr{int_t}
    xlsub::Ptr{int_t}
    usub::Ptr{int_t}
    xusub::Ptr{int_t}
    nzlmax::int_t
    nzumax::int_t
    MemModel::LU_space_t
    nnzLU::Int64
end

struct pxgstrs_comm_t
    B_to_X_SendCnt::Ptr{Cint}
    X_to_B_SendCnt::Ptr{Cint}
    ptr_to_ibuf::Ptr{Cint}
    ptr_to_dbuf::Ptr{Cint}
    X_to_B_iSendCnt::Ptr{Cint}
    X_to_B_vSendCnt::Ptr{Cint}
    disp_ibuf::Ptr{Cint}
    send_ibuf::Ptr{int_t}
    send_dbuf::Ptr{Cvoid}
    x2b::int_t
    b2x::int_t
    send_ibuf2::Ptr{int_t}
    recv_ibuf2::Ptr{int_t}
    send_dbuf2::Ptr{Cvoid}
    recv_dbuf2::Ptr{Cvoid}
end

struct superlu_dist_options_t
    Fact::fact_t
    Equil::yes_no_t
    DiagInv::yes_no_t
    ColPerm::colperm_t
    Trans::trans_t
    IterRefine::IterRefine_t
    DiagPivotThresh::Cdouble
    SymmetricMode::yes_no_t
    PivotGrowth::yes_no_t
    ConditionNumber::yes_no_t
    RowPerm::rowperm_t
    SolveOnly::yes_no_t
    GPURES::yes_no_t
    ILU_level::Cint
    ILU_DropRule::Cint
    ILU_DropTol::Cdouble
    ILU_FillFactor::Cdouble
    ILU_Norm::norm_t
    ILU_FillTol::Cdouble
    ILU_MILU::milu_t
    ILU_MILU_Dim::Cdouble
    UserDefineSupernode::yes_no_t
    ParSymbFact::yes_no_t
    ReplaceTinyPivot::yes_no_t
    SolveInitialized::yes_no_t
    RefineInitialized::yes_no_t
    PrintStat::yes_no_t
    lookahead_etree::yes_no_t
    num_lookaheads::Cint
    superlu_relax::Cint
    superlu_maxsup::Cint
    superlu_rankorder::NTuple{4, Cchar}
    superlu_lbs::NTuple{4, Cchar}
    superlu_n_gemm::Cint
    superlu_max_buffer_size::int_t
    superlu_num_gpu_streams::Cint
    superlu_acc_offload::Cint
    batchCount::Cint
    SymPattern::yes_no_t
    Use_TensorCore::yes_no_t
    Algo3d::yes_no_t
    UseGMRES::Cint
end

struct superlu_dist_mem_usage_t
    for_lu::Cfloat
    total::Cfloat
    expansions::Cint
    nnzL::Int64
    nnzU::Int64
end

struct Ucb_indptr_t
    lbnum::int_t
    indpos::int_t
end

struct Ublock_info_t
    rukp::int_t
    iukp::int_t
    jb::int_t
    full_u_cols::int_t
    eo::int_t
    ncols::int_t
    StCol::int_t
end

struct Remain_info_t
    lptr::int_t
    ib::int_t
    eo::int_t
    nrows::int_t
    FullRow::int_t
    StRow::int_t
end

struct etree_node
    id::Cint
    key::Cint
    next::Ptr{Cvoid}
end

struct superlu_pair
    ind::Cint
    val::Cint
end

"""
    uPanelInfo_t

--------*
"""
struct uPanelInfo_t
    nub::int_t
    klst::int_t
    ldu::int_t
    usub::Ptr{int_t}
end

struct lPanelInfo_t
    lsub::Ptr{int_t}
    lusup::Ptr{Cvoid}
    luptr0::int_t
    nlb::int_t
    nsupr::int_t
end

struct packLUInfo_t
    Ublock_info::Ptr{Ublock_info_t}
    Remain_info::Ptr{Remain_info_t}
    uPanelInfo::Ptr{uPanelInfo_t}
    lPanelInfo::Ptr{lPanelInfo_t}
end

struct HyP_t
    lookAhead_info::Ptr{Remain_info_t}
    Remain_info::Ptr{Remain_info_t}
    Ublock_info::Ptr{Ublock_info_t}
    Ublock_info_Phi::Ptr{Ublock_info_t}
    first_l_block_acc::int_t
    first_u_block_acc::int_t
    last_offload::int_t
    Lblock_dirty_bit::Ptr{int_t}
    Ublock_dirty_bit::Ptr{int_t}
    lookAhead_L_buff::Ptr{Cvoid}
    Remain_L_buff::Ptr{Cvoid}
    lookAheadBlk::int_t
    RemainBlk::int_t
    num_look_aheads::int_t
    nsupers::int_t
    ldu::int_t
    ldu_Phi::int_t
    num_u_blks::int_t
    num_u_blks_Phi::int_t
    jj_cpu::int_t
    bigU_Phi::Ptr{Cvoid}
    bigU_host::Ptr{Cvoid}
    Lnbrow::int_t
    Rnbrow::int_t
    buffer_size::int_t
    bigu_size::int_t
    offloadCondition::Cint
    superlu_acc_offload::Cint
    nGPUStreams::Cint
end

struct local_l_blk_info_t
    luptrj::int_t
    lptrj::int_t
    lib::int_t
end

struct local_u_blk_info_t
    iuip::int_t
    ruip::int_t
    ljb::int_t
end

struct perm_array_t
    perm_c_supno::Ptr{int_t}
    iperm_c_supno::Ptr{int_t}
end

struct factStat_t
    factored::Ptr{Cint}
    factored_D::Ptr{Cint}
    factored_L::Ptr{Cint}
    factored_U::Ptr{Cint}
    IrecvPlcd_D::Ptr{Cint}
    IbcastPanel_L::Ptr{Cint}
    IbcastPanel_U::Ptr{Cint}
    gpuLUreduced::Ptr{Cint}
end

struct d2Hreduce_t
    next_col::int_t
    next_k::int_t
    kljb::int_t
    kijb::int_t
    copyL_kljb::int_t
    copyU_kljb::int_t
    l_copy_len::int_t
    u_copy_len::int_t
    kindexL::Ptr{int_t}
    kindexU::Ptr{int_t}
    mkrow::int_t
    mkcol::int_t
    ksup_size::int_t
end

struct treeList_t
    numChild::int_t
    numDescendents::int_t
    left::int_t
    right::int_t
    extra::int_t
    childrenList::Ptr{int_t}
    depth::int_t
    weight::Cdouble
    iWeight::Cdouble
    scuWeight::Cdouble
end

struct treeTopoInfo_t
    numLvl::int_t
    eTreeTopLims::Ptr{int_t}
    myIperm::Ptr{int_t}
end

struct gEtreeInfo_t
    setree::Ptr{int_t}
    numChildLeft::Ptr{int_t}
end

struct sForest_t
    nNodes::int_t
    nodeList::Ptr{int_t}
    numLvl::int_t
    numTrees::int_t
    topoInfo::treeTopoInfo_t
    weight::Cdouble
    cost::Cdouble
end

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

struct factNodelists_t
    iperm_c_supno::Ptr{int_t}
    iperm_u::Ptr{int_t}
    perm_u::Ptr{int_t}
    indirect::Ptr{Cint}
    indirect2::Ptr{Cint}
end

struct msgs_t
    msgcnt::Ptr{Cint}
    msgcntU::Ptr{Cint}
end

struct xtrsTimer_t
    trsDataSendXY::Cdouble
    trsDataSendZ::Cdouble
    trsDataRecvXY::Cdouble
    trsDataRecvZ::Cdouble
    t_pxReDistribute_X_to_B::Cdouble
    t_pxReDistribute_B_to_X::Cdouble
    t_forwardSolve::Cdouble
    tfs_compute::Cdouble
    tfs_comm::Cdouble
    trs_comm_z::Cdouble
    t_gather_x::Cdouble
    t_init_b::Cdouble
    t_backwardSolve::Cdouble
    tbs_compute::Cdouble
    tbs_comm::Cdouble
    tbs_tree::NTuple{64, Cdouble}
    tfs_tree::NTuple{64, Cdouble}
    trsMsgSentXY::int_t
    trsMsgSentZ::int_t
    trsMsgRecvXY::int_t
    trsMsgRecvZ::int_t
    ppXmem::Cdouble
end

function superlu_gridinit(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.superlu_gridinit(arg1::MPI_Comm, arg2::Cint, arg3::Cint, arg4::Ptr{gridinfo_t})::Cvoid
end

function superlu_gridmap(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.superlu_gridmap(arg1::MPI_Comm, arg2::Cint, arg3::Cint, arg4::Ptr{Cint}, arg5::Cint, arg6::Ptr{gridinfo_t})::Cvoid
end

function superlu_gridexit(arg1)
    @ccall libsuperlu_dist_Int32.superlu_gridexit(arg1::Ptr{gridinfo_t})::Cvoid
end

function superlu_gridinit3d(Bcomm, nprow, npcol, npdep, grid)
    @ccall libsuperlu_dist_Int32.superlu_gridinit3d(Bcomm::MPI_Comm, nprow::Cint, npcol::Cint, npdep::Cint, grid::Ptr{gridinfo3d_t})::Cvoid
end

function superlu_gridmap3d(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.superlu_gridmap3d(arg1::MPI_Comm, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Ptr{Cint}, arg6::Ptr{gridinfo3d_t})::Cvoid
end

function superlu_gridexit3d(grid)
    @ccall libsuperlu_dist_Int32.superlu_gridexit3d(grid::Ptr{gridinfo3d_t})::Cvoid
end

function set_default_options_dist(arg1)
    @ccall libsuperlu_dist_Int32.set_default_options_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function print_options_dist(arg1)
    @ccall libsuperlu_dist_Int32.print_options_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function print_sp_ienv_dist(arg1)
    @ccall libsuperlu_dist_Int32.print_sp_ienv_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function Destroy_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.Destroy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_SuperNode_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.Destroy_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_SuperMatrix_Store_dist(arg1)
    @ccall libsuperlu_dist_Int32.Destroy_SuperMatrix_Store_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_CompCol_Permuted_dist(arg1)
    @ccall libsuperlu_dist_Int32.Destroy_CompCol_Permuted_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.Destroy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_CompRow_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.Destroy_CompRow_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function sp_colorder(arg1, arg2, perm_c, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sp_colorder(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, perm_c::Ptr{Cint}, arg4::Ptr{int_t}, arg5::Ptr{SuperMatrix})::Cvoid
end

function sp_symetree_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sp_symetree_dist(arg1::Ptr{int_t}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::int_t, arg5::Ptr{int_t})::Cint
end

function sp_coletree_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.sp_coletree_dist(arg1::Ptr{int_t}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::int_t, arg5::int_t, arg6::Ptr{int_t})::Cint
end

function get_perm_c_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.get_perm_c_dist(arg1::Cint, arg2::Cint, arg3::Ptr{SuperMatrix}, arg4::Ptr{Cint})::Cvoid
end

function get_perm_c_batch(options, batchCount, SparseMatrix_handles, CpivPtr)
    @ccall libsuperlu_dist_Int32.get_perm_c_batch(options::Ptr{superlu_dist_options_t}, batchCount::Cint, SparseMatrix_handles::Ptr{handle_t}, CpivPtr::Ptr{Ptr{Cint}})::Cvoid
end

function get_perm_c_vbatch(options, batchCount, SparseMatrix_handles, CpivPtr)
    @ccall libsuperlu_dist_Int32.get_perm_c_vbatch(options::Ptr{superlu_dist_options_t}, batchCount::Cint, SparseMatrix_handles::Ptr{handle_t}, CpivPtr::Ptr{Ptr{Cint}})::Cvoid
end

function at_plus_a_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.at_plus_a_dist(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function getata_dist(m, n, nz, colptr, rowind, atanz, ata_colptr, ata_rowind)
    @ccall libsuperlu_dist_Int32.getata_dist(m::int_t, n::int_t, nz::int_t, colptr::Ptr{int_t}, rowind::Ptr{int_t}, atanz::Ptr{int_t}, ata_colptr::Ptr{Ptr{int_t}}, ata_rowind::Ptr{Ptr{int_t}})::Cvoid
end

function get_metis_dist(n, bnz, b_colptr, b_rowind, perm_c)
    @ccall libsuperlu_dist_Int32.get_metis_dist(n::int_t, bnz::int_t, b_colptr::Ptr{int_t}, b_rowind::Ptr{int_t}, perm_c::Ptr{Cint})::Cvoid
end

function get_colamd_dist(m, n, nnz, colptr, rowind, perm_c)
    @ccall libsuperlu_dist_Int32.get_colamd_dist(m::Cint, n::Cint, nnz::Cint, colptr::Ptr{int_t}, rowind::Ptr{int_t}, perm_c::Ptr{Cint})::Cvoid
end

function genmmd_dist_(arg1, arg2, arg3, invp, perm, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.genmmd_dist_(arg1::Ptr{int_t}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, invp::Ptr{Cint}, perm::Ptr{Cint}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Ptr{int_t}, arg12::Ptr{int_t})::Cint
end

function bcast_tree(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.bcast_tree(arg1::Ptr{Cvoid}, arg2::Cint, arg3::MPI_Datatype, arg4::Cint, arg5::Cint, arg6::Ptr{gridinfo_t}, arg7::Cint, arg8::Ptr{Cint})::Cvoid
end

function symbfact(arg1, arg2, arg3, perm_c, etree, arg6, arg7)
    @ccall libsuperlu_dist_Int32.symbfact(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Ptr{SuperMatrix}, perm_c::Ptr{Cint}, etree::Ptr{int_t}, arg6::Ptr{Glu_persist_t}, arg7::Ptr{Glu_freeable_t})::int_t
end

function symbfact_SubInit(options, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.symbfact_SubInit(options::Ptr{superlu_dist_options_t}, arg2::fact_t, arg3::Ptr{Cvoid}, arg4::int_t, arg5::int_t, arg6::int_t, arg7::int_t, arg8::Ptr{Glu_persist_t}, arg9::Ptr{Glu_freeable_t})::int_t
end

function symbfact_SubXpand(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.symbfact_SubXpand(arg1::int_t, arg2::int_t, arg3::int_t, arg4::MemType, arg5::Ptr{int_t}, arg6::Ptr{Glu_freeable_t})::int_t
end

function symbfact_SubFree(arg1)
    @ccall libsuperlu_dist_Int32.symbfact_SubFree(arg1::Ptr{Glu_freeable_t})::Cint
end

function ilu_level_symbfact(arg1, arg2, perm_c, etree, arg5, arg6)
    @ccall libsuperlu_dist_Int32.ilu_level_symbfact(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, perm_c::Ptr{Cint}, etree::Ptr{int_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{Glu_freeable_t})::int_t
end

function countnz_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.countnz_dist(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{Glu_freeable_t})::Cvoid
end

function fixupL_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.fixupL_dist(arg1::int_t, arg2::Ptr{Cint}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{Glu_freeable_t})::Int64
end

function TreePostorder_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.TreePostorder_dist(arg1::int_t, arg2::Ptr{int_t})::Ptr{int_t}
end

function smach_dist(arg1)
    @ccall libsuperlu_dist_Int32.smach_dist(arg1::Ptr{Cchar})::Cfloat
end

function dmach_dist(arg1)
    @ccall libsuperlu_dist_Int32.dmach_dist(arg1::Ptr{Cchar})::Cdouble
end

function int32Malloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.int32Malloc_dist(arg1::Cint)::Ptr{Cint}
end

function int32Calloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.int32Calloc_dist(arg1::Cint)::Ptr{Cint}
end

function intMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.intMalloc_dist(arg1::int_t)::Ptr{int_t}
end

function intCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.intCalloc_dist(arg1::int_t)::Ptr{int_t}
end

function mc64id_dist(arg1)
    @ccall libsuperlu_dist_Int32.mc64id_dist(arg1::Ptr{Cint})::Cint
end

function arrive_at_ublock(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.arrive_at_ublock(arg1::Cint, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{Cint}, arg5::Ptr{Cint}, arg6::Ptr{Cint}, arg7::int_t, arg8::int_t, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t})::Cvoid
end

function estimate_bigu_size(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.estimate_bigu_size(arg1::int_t, arg2::Ptr{Ptr{int_t}}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t})::int_t
end

function sp_ienv_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sp_ienv_dist(arg1::Cint, arg2::Ptr{superlu_dist_options_t})::int_t
end

function ifill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.ifill_dist(arg1::Ptr{Cint}, arg2::Cint, arg3::Cint)::Cvoid
end

function super_stats_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.super_stats_dist(arg1::int_t, arg2::Ptr{int_t})::Cvoid
end

function get_diag_procs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.get_diag_procs(arg1::int_t, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{int_t}})::Cvoid
end

function QuerySpace_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.QuerySpace_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Glu_freeable_t}, arg4::Ptr{superlu_dist_mem_usage_t})::int_t
end

function xerr_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.xerr_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cint})::Cint
end

function pxerr_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.pxerr_dist(arg1::Ptr{Cchar}, arg2::Ptr{gridinfo_t}, arg3::int_t)::Cvoid
end

function PStatInit(arg1)
    @ccall libsuperlu_dist_Int32.PStatInit(arg1::Ptr{SuperLUStat_t})::Cvoid
end

function PStatClear(arg1)
    @ccall libsuperlu_dist_Int32.PStatClear(arg1::Ptr{SuperLUStat_t})::Cvoid
end

function PStatFree(arg1)
    @ccall libsuperlu_dist_Int32.PStatFree(arg1::Ptr{SuperLUStat_t})::Cvoid
end

function PStatPrint(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.PStatPrint(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperLUStat_t}, arg3::Ptr{gridinfo_t})::Cvoid
end

function log_memory(arg1, arg2)
    @ccall libsuperlu_dist_Int32.log_memory(arg1::Int64, arg2::Ptr{SuperLUStat_t})::Cvoid
end

function print_memorylog(arg1, arg2)
    @ccall libsuperlu_dist_Int32.print_memorylog(arg1::Ptr{SuperLUStat_t}, arg2::Ptr{Cchar})::Cvoid
end

function superlu_dist_GetVersionNumber(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.superlu_dist_GetVersionNumber(arg1::Ptr{Cint}, arg2::Ptr{Cint}, arg3::Ptr{Cint})::Cint
end

function quickSort(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.quickSort(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t)::Cvoid
end

function quickSortM(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.quickSortM(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t)::Cvoid
end

function partition(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.partition(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t)::int_t
end

function partitionM(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.partitionM(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t)::int_t
end

function compareInt_t(a, b)
    @ccall libsuperlu_dist_Int32.compareInt_t(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function compareInt(a, b)
    @ccall libsuperlu_dist_Int32.compareInt(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function compareDouble(a, b)
    @ccall libsuperlu_dist_Int32.compareDouble(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function dist_checkArrayEq(arr, length, datatype, src_rank, dest_rank, communicator, compare)
    @ccall libsuperlu_dist_Int32.dist_checkArrayEq(arr::Ptr{Cvoid}, length::Cint, datatype::MPI_Datatype, src_rank::Cint, dest_rank::Cint, communicator::MPI_Comm, compare::Ptr{Cvoid})::Cint
end

function symbfact_dist(arg1, arg2, arg3, arg4, perm_c, perm_r, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.symbfact_dist(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{SuperMatrix}, perm_c::Ptr{Cint}, perm_r::Ptr{Cint}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Pslu_freeable_t}, arg10::Ptr{MPI_Comm}, arg11::Ptr{MPI_Comm}, arg12::Ptr{superlu_dist_mem_usage_t})::Cfloat
end

function get_perm_c_parmetis(arg1, perm_r, perm_c, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.get_perm_c_parmetis(arg1::Ptr{SuperMatrix}, perm_r::Ptr{Cint}, perm_c::Ptr{Cint}, arg4::Cint, arg5::Cint, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{gridinfo_t}, arg9::Ptr{MPI_Comm})::Cfloat
end

function psymbfact_LUXpandMem(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.psymbfact_LUXpandMem(arg1::Cint, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::Cint, arg7::Cint, arg8::Cint, arg9::Ptr{Pslu_freeable_t}, arg10::Ptr{Llu_symbfact_t}, arg11::Ptr{vtcsInfo_symbfact_t}, arg12::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_LUXpand(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.psymbfact_LUXpand(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::int_t, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Ptr{Pslu_freeable_t}, arg11::Ptr{Llu_symbfact_t}, arg12::Ptr{vtcsInfo_symbfact_t}, arg13::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_LUXpand_RL(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.psymbfact_LUXpand_RL(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{Pslu_freeable_t}, arg8::Ptr{Llu_symbfact_t}, arg9::Ptr{vtcsInfo_symbfact_t}, arg10::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_prLUXpand(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.psymbfact_prLUXpand(arg1::int_t, arg2::int_t, arg3::Cint, arg4::Ptr{Llu_symbfact_t}, arg5::Ptr{psymbfact_stat_t})::int_t
end

function isort(N, ARRAY1, ARRAY2)
    @ccall libsuperlu_dist_Int32.isort(N::int_t, ARRAY1::Ptr{int_t}, ARRAY2::Ptr{int_t})::Cvoid
end

function isort1(N, ARRAY)
    @ccall libsuperlu_dist_Int32.isort1(N::int_t, ARRAY::Ptr{int_t})::Cvoid
end

function gemm_division_cpu_gpu(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.gemm_division_cpu_gpu(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{Cint}, arg3::Ptr{Cint}, arg4::Ptr{Cint}, arg5::Cint, arg6::Cint, arg7::Cint, arg8::Ptr{Cint}, arg9::Cint, arg10::int_t)::Cvoid
end

function get_gpublas_nb()
    @ccall libsuperlu_dist_Int32.get_gpublas_nb()::int_t
end

function get_num_gpu_streams()
    @ccall libsuperlu_dist_Int32.get_num_gpu_streams()::int_t
end

function getnGPUStreams()
    @ccall libsuperlu_dist_Int32.getnGPUStreams()::Cint
end

function get_mpi_process_per_gpu()
    @ccall libsuperlu_dist_Int32.get_mpi_process_per_gpu()::Cint
end

function sizeof_int_t()
    @ccall libsuperlu_dist_Int32.sizeof_int_t()::Cint
end

function printGPUStats(nsupers, stat, arg3)
    @ccall libsuperlu_dist_Int32.printGPUStats(nsupers::Cint, stat::Ptr{SuperLUStat_t}, arg3::Ptr{gridinfo3d_t})::Cvoid
end

function estimate_cpu_time(m, n, k)
    @ccall libsuperlu_dist_Int32.estimate_cpu_time(m::Cint, n::Cint, k::Cint)::Cdouble
end

function get_thread_per_process()
    @ccall libsuperlu_dist_Int32.get_thread_per_process()::Cint
end

function get_max_buffer_size()
    @ccall libsuperlu_dist_Int32.get_max_buffer_size()::int_t
end

function get_min(arg1, arg2)
    @ccall libsuperlu_dist_Int32.get_min(arg1::Ptr{int_t}, arg2::int_t)::int_t
end

function compare_pair(arg1, arg2)
    @ccall libsuperlu_dist_Int32.compare_pair(arg1::Ptr{Cvoid}, arg2::Ptr{Cvoid})::Cint
end

function static_partition(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.static_partition(arg1::Ptr{superlu_pair}, arg2::int_t, arg3::Ptr{int_t}, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Cint)::int_t
end

function get_acc_offload(arg1)
    @ccall libsuperlu_dist_Int32.get_acc_offload(arg1::Ptr{superlu_dist_options_t})::Cint
end

function get_acc_solve()
    @ccall libsuperlu_dist_Int32.get_acc_solve()::Cint
end

function get_new3dsolve()
    @ccall libsuperlu_dist_Int32.get_new3dsolve()::Cint
end

function get_new3dsolvetreecomm()
    @ccall libsuperlu_dist_Int32.get_new3dsolvetreecomm()::Cint
end

function print_panel_seg_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.print_panel_seg_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t})::Cvoid
end

function check_repfnz_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.check_repfnz_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{int_t})::Cvoid
end

function CheckZeroDiagonal(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.CheckZeroDiagonal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t})::int_t
end

function check_perm_dist(what, n, perm)
    @ccall libsuperlu_dist_Int32.check_perm_dist(what::Ptr{Cchar}, n::Cint, perm::Ptr{Cint})::Cint
end

function PrintDouble5(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.PrintDouble5(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cdouble})::Cvoid
end

function PrintInt10(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.PrintInt10(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{int_t})::Cvoid
end

function PrintInt32(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.PrintInt32(arg1::Ptr{Cchar}, arg2::Cint, arg3::Ptr{Cint})::Cvoid
end

function file_PrintInt10(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.file_PrintInt10(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{int_t})::Cint
end

function file_PrintInt32(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.file_PrintInt32(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::Cint, arg4::Ptr{Cint})::Cint
end

function file_PrintLong10(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.file_PrintLong10(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{int_t})::Cint
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
    myIdx::Cint
end

function C_RdTree_Create_nv(tree, comm, ranks, rank_cnt, msgSize, precision, needrecvrd, needsendrd)
    @ccall libsuperlu_dist_Int32.C_RdTree_Create_nv(tree::Ptr{C_Tree}, comm::MPI_Comm, ranks::Ptr{Cint}, rank_cnt::Cint, msgSize::Cint, precision::Cchar, needrecvrd::Ptr{Cint}, needsendrd::Ptr{Cint})::Cvoid
end

function C_RdTree_Nullify(tree)
    @ccall libsuperlu_dist_Int32.C_RdTree_Nullify(tree::Ptr{C_Tree})::Cvoid
end

function C_RdTree_IsRoot(tree)
    @ccall libsuperlu_dist_Int32.C_RdTree_IsRoot(tree::Ptr{C_Tree})::yes_no_t
end

function C_RdTree_forwardMessageSimple(Tree, localBuffer, msgSize)
    @ccall libsuperlu_dist_Int32.C_RdTree_forwardMessageSimple(Tree::Ptr{C_Tree}, localBuffer::Ptr{Cvoid}, msgSize::Cint)::Cvoid
end

function C_RdTree_waitSendRequest(Tree)
    @ccall libsuperlu_dist_Int32.C_RdTree_waitSendRequest(Tree::Ptr{C_Tree})::Cvoid
end

function C_BcTree_Create_nv(tree, comm, ranks, rank_cnt, msgSize, precision, needrecv)
    @ccall libsuperlu_dist_Int32.C_BcTree_Create_nv(tree::Ptr{C_Tree}, comm::MPI_Comm, ranks::Ptr{Cint}, rank_cnt::Cint, msgSize::Cint, precision::Cchar, needrecv::Ptr{Cint})::Cvoid
end

function C_BcTree_Nullify(tree)
    @ccall libsuperlu_dist_Int32.C_BcTree_Nullify(tree::Ptr{C_Tree})::Cvoid
end

function C_BcTree_IsRoot(tree)
    @ccall libsuperlu_dist_Int32.C_BcTree_IsRoot(tree::Ptr{C_Tree})::yes_no_t
end

function C_BcTree_forwardMessageSimple(tree, localBuffer, msgSize)
    @ccall libsuperlu_dist_Int32.C_BcTree_forwardMessageSimple(tree::Ptr{C_Tree}, localBuffer::Ptr{Cvoid}, msgSize::Cint)::Cvoid
end

function C_BcTree_waitSendRequest(tree)
    @ccall libsuperlu_dist_Int32.C_BcTree_waitSendRequest(tree::Ptr{C_Tree})::Cvoid
end

function DistPrint(function_name, value, Units, grid)
    @ccall libsuperlu_dist_Int32.DistPrint(function_name::Ptr{Cchar}, value::Cdouble, Units::Ptr{Cchar}, grid::Ptr{gridinfo_t})::Cvoid
end

function DistPrint3D(function_name, value, Units, grid3d)
    @ccall libsuperlu_dist_Int32.DistPrint3D(function_name::Ptr{Cchar}, value::Cdouble, Units::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function treeImbalance3D(grid3d, SCT)
    @ccall libsuperlu_dist_Int32.treeImbalance3D(grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cvoid
end

function slu_SCT_printComm3D(grid3d, SCT)
    @ccall libsuperlu_dist_Int32.slu_SCT_printComm3D(grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cvoid
end

function zAllocBcast(size, ptr, grid3d)
    @ccall libsuperlu_dist_Int32.zAllocBcast(size::int_t, ptr::Ptr{Ptr{Cvoid}}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function zAllocBcast_gridID(size, ptr, gridID, grid3d)
    @ccall libsuperlu_dist_Int32.zAllocBcast_gridID(size::int_t, ptr::Ptr{Ptr{Cvoid}}, gridID::int_t, grid3d::Ptr{gridinfo3d_t})::int_t
end

function permCol_SymbolicFact3d(options, n, GA, perm_c, etree, Glu_persist, Glu_freeable, stat, symb_mem_usage, grid3d)
    @ccall libsuperlu_dist_Int32.permCol_SymbolicFact3d(options::Ptr{superlu_dist_options_t}, n::Cint, GA::Ptr{SuperMatrix}, perm_c::Ptr{Cint}, etree::Ptr{int_t}, Glu_persist::Ptr{Glu_persist_t}, Glu_freeable::Ptr{Glu_freeable_t}, stat::Ptr{SuperLUStat_t}, symb_mem_usage::Ptr{superlu_dist_mem_usage_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function createSuperGridMap(nsuper, maxLvl, myTreeIdxs, myZeroTrIdxs, gNodeCount, gNodeLists)
    @ccall libsuperlu_dist_Int32.createSuperGridMap(nsuper::int_t, maxLvl::int_t, myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, gNodeCount::Ptr{int_t}, gNodeLists::Ptr{Ptr{int_t}})::Ptr{SupernodeToGridMap_t}
end

function createSupernode2TreeMap(nsupers, maxLvl, gNodeCount, gNodeLists)
    @ccall libsuperlu_dist_Int32.createSupernode2TreeMap(nsupers::int_t, maxLvl::int_t, gNodeCount::Ptr{int_t}, gNodeLists::Ptr{Ptr{int_t}})::Ptr{int_t}
end

function allocBcastArray(array, size, root, comm)
    @ccall libsuperlu_dist_Int32.allocBcastArray(array::Ptr{Ptr{Cvoid}}, size::int_t, root::Cint, comm::MPI_Comm)::Cvoid
end

function allocBcastLargeArray(array, size, root, comm)
    @ccall libsuperlu_dist_Int32.allocBcastLargeArray(array::Ptr{Ptr{Cvoid}}, size::Int64, root::Cint, comm::MPI_Comm)::Cvoid
end

function create_iperm_c_supno(nsupers, n, options, Glu_persist, etree, Lrowind_bc_ptr, Ufstnz_br_ptr, grid3d)
    @ccall libsuperlu_dist_Int32.create_iperm_c_supno(nsupers::int_t, n::Cint, options::Ptr{superlu_dist_options_t}, Glu_persist::Ptr{Glu_persist_t}, etree::Ptr{int_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, grid3d::Ptr{gridinfo3d_t})::Ptr{int_t}
end

function fillEtreeInfo(nsupers, setree, treeList)
    @ccall libsuperlu_dist_Int32.fillEtreeInfo(nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t})::gEtreeInfo_t
end

function compute_sForests(nsupers, Glu_persist, etree, grid3d)
    @ccall libsuperlu_dist_Int32.compute_sForests(nsupers::int_t, Glu_persist::Ptr{Glu_persist_t}, etree::Ptr{int_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{Ptr{sForest_t}}
end

function getBrecvTree(nlb, sforest, bmod, grid)
    @ccall libsuperlu_dist_Int32.getBrecvTree(nlb::int_t, sforest::Ptr{sForest_t}, bmod::Ptr{Cint}, grid::Ptr{gridinfo_t})::Ptr{Cint}
end

function getBrecvTree_newsolve(nlb, nsupers, supernodeMask, bmod, grid)
    @ccall libsuperlu_dist_Int32.getBrecvTree_newsolve(nlb::int_t, nsupers::int_t, supernodeMask::Ptr{Cint}, bmod::Ptr{Cint}, grid::Ptr{gridinfo_t})::Ptr{Cint}
end

function getNrootUsolveTree(nbrecvmod, sforest, brecv, bmod, grid)
    @ccall libsuperlu_dist_Int32.getNrootUsolveTree(nbrecvmod::Ptr{int_t}, sforest::Ptr{sForest_t}, brecv::Ptr{Cint}, bmod::Ptr{Cint}, grid::Ptr{gridinfo_t})::Cint
end

function getNbrecvX(sforest, Urbs, grid)
    @ccall libsuperlu_dist_Int32.getNbrecvX(sforest::Ptr{sForest_t}, Urbs::Ptr{int_t}, grid::Ptr{gridinfo_t})::Cint
end

function getNbrecvX_newsolve(nsupers, supernodeMask, Urbs, Ucb_indptr, grid)
    @ccall libsuperlu_dist_Int32.getNbrecvX_newsolve(nsupers::int_t, supernodeMask::Ptr{Cint}, Urbs::Ptr{int_t}, Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}, grid::Ptr{gridinfo_t})::Cint
end

function getNrootUsolveTree_newsolve(nbrecvmod, nsupers, supernodeMask, brecv, bmod, grid)
    @ccall libsuperlu_dist_Int32.getNrootUsolveTree_newsolve(nbrecvmod::Ptr{int_t}, nsupers::int_t, supernodeMask::Ptr{Cint}, brecv::Ptr{Cint}, bmod::Ptr{Cint}, grid::Ptr{gridinfo_t})::Cint
end

function getNfrecvmodLeaf(nleaf, sforest, frecv, fmod, grid)
    @ccall libsuperlu_dist_Int32.getNfrecvmodLeaf(nleaf::Ptr{Cint}, sforest::Ptr{sForest_t}, frecv::Ptr{Cint}, fmod::Ptr{Cint}, grid::Ptr{gridinfo_t})::int_t
end

function getNfrecvmod_newsolve(nleaf, nsupers, supernodeMask, frecv, fmod, grid)
    @ccall libsuperlu_dist_Int32.getNfrecvmod_newsolve(nleaf::Ptr{Cint}, nsupers::int_t, supernodeMask::Ptr{Cint}, frecv::Ptr{Cint}, fmod::Ptr{Cint}, grid::Ptr{gridinfo_t})::int_t
end

function getfrecv_newsolve(nsupers, supernodeMask, nlb, fmod, mod_bit, grid)
    @ccall libsuperlu_dist_Int32.getfrecv_newsolve(nsupers::int_t, supernodeMask::Ptr{Cint}, nlb::int_t, fmod::Ptr{Cint}, mod_bit::Ptr{Cint}, grid::Ptr{gridinfo_t})::Ptr{Cint}
end

function getfrecvLeaf(sforest, nlb, fmod, mod_bit, grid)
    @ccall libsuperlu_dist_Int32.getfrecvLeaf(sforest::Ptr{sForest_t}, nlb::int_t, fmod::Ptr{Cint}, mod_bit::Ptr{Cint}, grid::Ptr{gridinfo_t})::Ptr{Cint}
end

function getNfrecvx_newsolve(nsupers, supernodeMask, Lrowind_bc_ptr, Lindval_loc_bc_ptr, grid)
    @ccall libsuperlu_dist_Int32.getNfrecvx_newsolve(nsupers::int_t, supernodeMask::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lindval_loc_bc_ptr::Ptr{Ptr{int_t}}, grid::Ptr{gridinfo_t})::Cint
end

function getNfrecvxLeaf(sforest, Lrowind_bc_ptr, grid)
    @ccall libsuperlu_dist_Int32.getNfrecvxLeaf(sforest::Ptr{sForest_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, grid::Ptr{gridinfo_t})::Cint
end

function getfmod_newsolve(nlb, nsupers, supernodeMask, Lrowind_bc_ptr, Lindval_loc_bc_ptr, grid)
    @ccall libsuperlu_dist_Int32.getfmod_newsolve(nlb::int_t, nsupers::int_t, supernodeMask::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lindval_loc_bc_ptr::Ptr{Ptr{int_t}}, grid::Ptr{gridinfo_t})::Ptr{Cint}
end

function getfmodLeaf(nlb, fmod_i)
    @ccall libsuperlu_dist_Int32.getfmodLeaf(nlb::int_t, fmod_i::Ptr{Cint})::Ptr{Cint}
end

function getldu(knsupc, iklrow, usub)
    @ccall libsuperlu_dist_Int32.getldu(knsupc::int_t, iklrow::int_t, usub::Ptr{int_t})::Cint
end

function getBmod3d(treeId, nlb, sforest, xsup, Ufstnz_br_ptr, supernode2treeMap, grid)
    @ccall libsuperlu_dist_Int32.getBmod3d(treeId::int_t, nlb::int_t, sforest::Ptr{sForest_t}, xsup::Ptr{int_t}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, supernode2treeMap::Ptr{int_t}, grid::Ptr{gridinfo_t})::Ptr{Cint}
end

function getBmod3d_newsolve(nlb, nsupers, supernodeMask, xsup, Ufstnz_br_ptr, grid)
    @ccall libsuperlu_dist_Int32.getBmod3d_newsolve(nlb::int_t, nsupers::int_t, supernodeMask::Ptr{Cint}, xsup::Ptr{int_t}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, grid::Ptr{gridinfo_t})::Ptr{Cint}
end

function getPerm_c_supno(nsupers, n, arg3, etree, Glu_persist, Lrowind_bc_ptr, Ufstnz_br_ptr, arg8)
    @ccall libsuperlu_dist_Int32.getPerm_c_supno(nsupers::int_t, n::Cint, arg3::Ptr{superlu_dist_options_t}, etree::Ptr{int_t}, Glu_persist::Ptr{Glu_persist_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, arg8::Ptr{gridinfo_t})::Ptr{int_t}
end

function getPerm_c_supno_allgrid(nsupers, options, etree, Glu_persist, Lrowind_bc_ptr, Ufstnz_br_ptr, grid3d)
    @ccall libsuperlu_dist_Int32.getPerm_c_supno_allgrid(nsupers::int_t, options::Ptr{superlu_dist_options_t}, etree::Ptr{int_t}, Glu_persist::Ptr{Glu_persist_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, grid3d::Ptr{gridinfo3d_t})::Ptr{int_t}
end

function slu_SCT_init(arg1)
    @ccall libsuperlu_dist_Int32.slu_SCT_init(arg1::Ptr{SCT_t})::Cvoid
end

function slu_SCT_print(grid, SCT)
    @ccall libsuperlu_dist_Int32.slu_SCT_print(grid::Ptr{gridinfo_t}, SCT::Ptr{SCT_t})::Cvoid
end

function slu_SCT_printSummary(grid, SCT)
    @ccall libsuperlu_dist_Int32.slu_SCT_printSummary(grid::Ptr{gridinfo_t}, SCT::Ptr{SCT_t})::Cvoid
end

function slu_SCT_print3D(grid3d, SCT)
    @ccall libsuperlu_dist_Int32.slu_SCT_print3D(grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cvoid
end

function slu_SCT_free(arg1)
    @ccall libsuperlu_dist_Int32.slu_SCT_free(arg1::Ptr{SCT_t})::Cvoid
end

function setree2list(nsuper, setree)
    @ccall libsuperlu_dist_Int32.setree2list(nsuper::int_t, setree::Ptr{int_t})::Ptr{treeList_t}
end

function free_treelist(nsuper, treeList)
    @ccall libsuperlu_dist_Int32.free_treelist(nsuper::int_t, treeList::Ptr{treeList_t})::Cint
end

function calcTreeWeight(nsupers, setree, treeList, xsup)
    @ccall libsuperlu_dist_Int32.calcTreeWeight(nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t}, xsup::Ptr{int_t})::int_t
end

function getDescendList(k, dlist, treeList)
    @ccall libsuperlu_dist_Int32.getDescendList(k::int_t, dlist::Ptr{int_t}, treeList::Ptr{treeList_t})::int_t
end

function getCommonAncestorList(k, alist, seTree, treeList)
    @ccall libsuperlu_dist_Int32.getCommonAncestorList(k::int_t, alist::Ptr{int_t}, seTree::Ptr{int_t}, treeList::Ptr{treeList_t})::int_t
end

function getCommonAncsCount(k, treeList)
    @ccall libsuperlu_dist_Int32.getCommonAncsCount(k::int_t, treeList::Ptr{treeList_t})::int_t
end

function getPermNodeList(nnode, nlist, perm_c_sup, iperm_c_sup)
    @ccall libsuperlu_dist_Int32.getPermNodeList(nnode::int_t, nlist::Ptr{int_t}, perm_c_sup::Ptr{int_t}, iperm_c_sup::Ptr{int_t})::Ptr{int_t}
end

function getEtreeLB(nnodes, perm_l, gTopOrder)
    @ccall libsuperlu_dist_Int32.getEtreeLB(nnodes::int_t, perm_l::Ptr{int_t}, gTopOrder::Ptr{int_t})::Ptr{int_t}
end

function getSubTreeRoots(k, numSubtrees, treeList)
    @ccall libsuperlu_dist_Int32.getSubTreeRoots(k::int_t, numSubtrees::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{int_t}
end

function merg_perms(nperms, nnodes, perms)
    @ccall libsuperlu_dist_Int32.merg_perms(nperms::int_t, nnodes::Ptr{int_t}, perms::Ptr{Ptr{int_t}})::Ptr{int_t}
end

function getGlobal_iperm(nsupers, nperms, perms, nnodes)
    @ccall libsuperlu_dist_Int32.getGlobal_iperm(nsupers::int_t, nperms::int_t, perms::Ptr{Ptr{int_t}}, nnodes::Ptr{int_t})::Ptr{int_t}
end

function log2i(index)
    @ccall libsuperlu_dist_Int32.log2i(index::int_t)::int_t
end

function supernodal_etree(nsuper, etree, supno, xsup)
    @ccall libsuperlu_dist_Int32.supernodal_etree(nsuper::int_t, etree::Ptr{int_t}, supno::Ptr{int_t}, xsup::Ptr{int_t})::Ptr{int_t}
end

function testSubtreeNodelist(nsupers, numList, nodeList, nodeCount)
    @ccall libsuperlu_dist_Int32.testSubtreeNodelist(nsupers::int_t, numList::int_t, nodeList::Ptr{Ptr{int_t}}, nodeCount::Ptr{int_t})::int_t
end

function testListPerm(nodeCount, nodeList, permList, gTopLevel)
    @ccall libsuperlu_dist_Int32.testListPerm(nodeCount::int_t, nodeList::Ptr{int_t}, permList::Ptr{int_t}, gTopLevel::Ptr{int_t})::int_t
end

function topological_ordering(nsuper, setree)
    @ccall libsuperlu_dist_Int32.topological_ordering(nsuper::int_t, setree::Ptr{int_t})::Ptr{int_t}
end

function Etree_LevelBoundry(perm, tsort_etree, nsuper)
    @ccall libsuperlu_dist_Int32.Etree_LevelBoundry(perm::Ptr{int_t}, tsort_etree::Ptr{int_t}, nsuper::int_t)::Ptr{int_t}
end

function calculate_num_children(nsuper, setree)
    @ccall libsuperlu_dist_Int32.calculate_num_children(nsuper::int_t, setree::Ptr{int_t})::Ptr{int_t}
end

function Print_EtreeLevelBoundry(Etree_LvlBdry, max_level, nsuper)
    @ccall libsuperlu_dist_Int32.Print_EtreeLevelBoundry(Etree_LvlBdry::Ptr{int_t}, max_level::int_t, nsuper::int_t)::Cvoid
end

function print_etree_leveled(setree, tsort_etree, nsuper)
    @ccall libsuperlu_dist_Int32.print_etree_leveled(setree::Ptr{int_t}, tsort_etree::Ptr{int_t}, nsuper::int_t)::Cvoid
end

function print_etree(setree, iperm, nsuper)
    @ccall libsuperlu_dist_Int32.print_etree(setree::Ptr{int_t}, iperm::Ptr{int_t}, nsuper::int_t)::Cvoid
end

function printFileList(sname, nnodes, dlist, setree)
    @ccall libsuperlu_dist_Int32.printFileList(sname::Ptr{Cchar}, nnodes::int_t, dlist::Ptr{int_t}, setree::Ptr{int_t})::int_t
end

function getLastDepBtree(nsupers, treeList)
    @ccall libsuperlu_dist_Int32.getLastDepBtree(nsupers::int_t, treeList::Ptr{treeList_t})::Ptr{Cint}
end

function getReplicatedTrees(grid3d)
    @ccall libsuperlu_dist_Int32.getReplicatedTrees(grid3d::Ptr{gridinfo3d_t})::Ptr{int_t}
end

function getGridTrees(grid3d)
    @ccall libsuperlu_dist_Int32.getGridTrees(grid3d::Ptr{gridinfo3d_t})::Ptr{int_t}
end

function getNodeList(maxLvl, setree, nnodes, treeHeads, treeList)
    @ccall libsuperlu_dist_Int32.getNodeList(maxLvl::int_t, setree::Ptr{int_t}, nnodes::Ptr{int_t}, treeHeads::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{Ptr{int_t}}
end

function calcNumNodes(maxLvl, treeHeads, treeList)
    @ccall libsuperlu_dist_Int32.calcNumNodes(maxLvl::int_t, treeHeads::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{int_t}
end

function getTreeHeads(maxLvl, nsupers, treeList)
    @ccall libsuperlu_dist_Int32.getTreeHeads(maxLvl::int_t, nsupers::int_t, treeList::Ptr{treeList_t})::Ptr{int_t}
end

function getMyIperm(nnodes, nsupers, myPerm)
    @ccall libsuperlu_dist_Int32.getMyIperm(nnodes::int_t, nsupers::int_t, myPerm::Ptr{int_t})::Ptr{int_t}
end

function getMyTopOrder(nnodes, myPerm, myIperm, setree)
    @ccall libsuperlu_dist_Int32.getMyTopOrder(nnodes::int_t, myPerm::Ptr{int_t}, myIperm::Ptr{int_t}, setree::Ptr{int_t})::Ptr{int_t}
end

function getMyEtLims(nnodes, myTopOrder)
    @ccall libsuperlu_dist_Int32.getMyEtLims(nnodes::int_t, myTopOrder::Ptr{int_t})::Ptr{int_t}
end

function getMyTreeTopoInfo(nnodes, nsupers, myPerm, setree)
    @ccall libsuperlu_dist_Int32.getMyTreeTopoInfo(nnodes::int_t, nsupers::int_t, myPerm::Ptr{int_t}, setree::Ptr{int_t})::treeTopoInfo_t
end

function getNestDissForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_dist_Int32.getNestDissForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{Ptr{sForest_t}}
end

function getTreePermForest(myTreeIdxs, myZeroTrIdxs, sForests, perm_c_supno, iperm_c_supno, grid3d)
    @ccall libsuperlu_dist_Int32.getTreePermForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t}, perm_c_supno::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{Ptr{int_t}}
end

function getTreePermFr(myTreeIdxs, sForests, grid3d)
    @ccall libsuperlu_dist_Int32.getTreePermFr(myTreeIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t}}, grid3d::Ptr{gridinfo3d_t})::Ptr{Ptr{int_t}}
end

function getMyNodeCountsFr(maxLvl, myTreeIdxs, sForests)
    @ccall libsuperlu_dist_Int32.getMyNodeCountsFr(maxLvl::int_t, myTreeIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t}})::Ptr{int_t}
end

function getNodeListFr(maxLvl, sForests)
    @ccall libsuperlu_dist_Int32.getNodeListFr(maxLvl::int_t, sForests::Ptr{Ptr{sForest_t}})::Ptr{Ptr{int_t}}
end

function getNodeCountsFr(maxLvl, sForests)
    @ccall libsuperlu_dist_Int32.getNodeCountsFr(maxLvl::int_t, sForests::Ptr{Ptr{sForest_t}})::Ptr{int_t}
end

function getIsNodeInMyGrid(nsupers, maxLvl, myNodeCount, treePerm)
    @ccall libsuperlu_dist_Int32.getIsNodeInMyGrid(nsupers::int_t, maxLvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}})::Ptr{Cint}
end

function printForestWeightCost(sForests, SCT, grid3d)
    @ccall libsuperlu_dist_Int32.printForestWeightCost(sForests::Ptr{Ptr{sForest_t}}, SCT::Ptr{SCT_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function getGreedyLoadBalForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_dist_Int32.getGreedyLoadBalForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{Ptr{sForest_t}}
end

function getForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_dist_Int32.getForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{Ptr{sForest_t}}
end

function getBigUSize(arg1, nsupers, grid, Lrowind_bc_ptr)
    @ccall libsuperlu_dist_Int32.getBigUSize(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, grid::Ptr{gridinfo_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}})::int_t
end

function getSCUweight(nsupers, treeList, xsup, Lrowind_bc_ptr, Ufstnz_br_ptr, grid3d)
    @ccall libsuperlu_dist_Int32.getSCUweight(nsupers::int_t, treeList::Ptr{treeList_t}, xsup::Ptr{int_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function getSCUweight_allgrid(nsupers, treeList, xsup, Lrowind_bc_ptr, Ufstnz_br_ptr, grid3d)
    @ccall libsuperlu_dist_Int32.getSCUweight_allgrid(nsupers::int_t, treeList::Ptr{treeList_t}, xsup::Ptr{int_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function Wait_LUDiagSend(k, U_diag_blk_send_req, L_diag_blk_send_req, grid, SCT)
    @ccall libsuperlu_dist_Int32.Wait_LUDiagSend(k::int_t, U_diag_blk_send_req::Ptr{MPI_Request}, L_diag_blk_send_req::Ptr{MPI_Request}, grid::Ptr{gridinfo_t}, SCT::Ptr{SCT_t})::Cint
end

function applyRowPerm(colptr, rowind, perm_r, n)
    @ccall libsuperlu_dist_Int32.applyRowPerm(colptr::Ptr{int_t}, rowind::Ptr{int_t}, perm_r::Ptr{Cint}, n::int_t)::Cvoid
end

function getNsupers(n, Glu_persist)
    @ccall libsuperlu_dist_Int32.getNsupers(n::Cint, Glu_persist::Ptr{Glu_persist_t})::Cint
end

function set_tag_ub()
    @ccall libsuperlu_dist_Int32.set_tag_ub()::Cint
end

function getNumThreads(arg1)
    @ccall libsuperlu_dist_Int32.getNumThreads(arg1::Cint)::Cint
end

function num_full_cols_U(kk, Ufstnz_br_ptr, xsup, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.num_full_cols_U(kk::int_t, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t})::int_t
end

function getFactPerm(arg1)
    @ccall libsuperlu_dist_Int32.getFactPerm(arg1::int_t)::Ptr{int_t}
end

function getFactIperm(arg1, arg2)
    @ccall libsuperlu_dist_Int32.getFactIperm(arg1::Ptr{int_t}, arg2::int_t)::Ptr{int_t}
end

function initCommRequests(comReqs, grid)
    @ccall libsuperlu_dist_Int32.initCommRequests(comReqs::Ptr{commRequests_t}, grid::Ptr{gridinfo_t})::int_t
end

function initFactStat(nsupers, factStat)
    @ccall libsuperlu_dist_Int32.initFactStat(nsupers::Cint, factStat::Ptr{factStat_t})::int_t
end

function freeFactStat(factStat)
    @ccall libsuperlu_dist_Int32.freeFactStat(factStat::Ptr{factStat_t})::Cint
end

function initFactNodelists(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.initFactNodelists(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{factNodelists_t})::int_t
end

function freeFactNodelists(fNlists)
    @ccall libsuperlu_dist_Int32.freeFactNodelists(fNlists::Ptr{factNodelists_t})::Cint
end

function initMsgs(msgs)
    @ccall libsuperlu_dist_Int32.initMsgs(msgs::Ptr{msgs_t})::int_t
end

function getNumLookAhead(arg1)
    @ccall libsuperlu_dist_Int32.getNumLookAhead(arg1::Ptr{superlu_dist_options_t})::int_t
end

function initCommRequestsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_dist_Int32.initCommRequestsArr(mxLeafNode::int_t, ldt::int_t, grid::Ptr{gridinfo_t})::Ptr{Ptr{commRequests_t}}
end

function freeCommRequestsArr(mxLeafNode, comReqss)
    @ccall libsuperlu_dist_Int32.freeCommRequestsArr(mxLeafNode::int_t, comReqss::Ptr{Ptr{commRequests_t}})::Cint
end

function initMsgsArr(numLA)
    @ccall libsuperlu_dist_Int32.initMsgsArr(numLA::int_t)::Ptr{Ptr{msgs_t}}
end

function freeMsgsArr(numLA, msgss)
    @ccall libsuperlu_dist_Int32.freeMsgsArr(numLA::int_t, msgss::Ptr{Ptr{msgs_t}})::Cint
end

function Trs2_InitUblock_info(klst, nb, arg3, usub, arg5, arg6)
    @ccall libsuperlu_dist_Int32.Trs2_InitUblock_info(klst::int_t, nb::int_t, arg3::Ptr{Ublock_info_t}, usub::Ptr{int_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{SuperLUStat_t})::int_t
end

function Cmpfunc_R_info(a, b)
    @ccall libsuperlu_dist_Int32.Cmpfunc_R_info(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function Cmpfunc_U_info(a, b)
    @ccall libsuperlu_dist_Int32.Cmpfunc_U_info(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function sort_R_info(Remain_info, n)
    @ccall libsuperlu_dist_Int32.sort_R_info(Remain_info::Ptr{Remain_info_t}, n::Cint)::Cint
end

function sort_U_info(Ublock_info, n)
    @ccall libsuperlu_dist_Int32.sort_U_info(Ublock_info::Ptr{Ublock_info_t}, n::Cint)::Cint
end

function sort_R_info_elm(Remain_info, n)
    @ccall libsuperlu_dist_Int32.sort_R_info_elm(Remain_info::Ptr{Remain_info_t}, n::Cint)::Cint
end

function sort_U_info_elm(Ublock_info, n)
    @ccall libsuperlu_dist_Int32.sort_U_info_elm(Ublock_info::Ptr{Ublock_info_t}, n::Cint)::Cint
end

function printTRStimer(xtrsTimer, grid3d)
    @ccall libsuperlu_dist_Int32.printTRStimer(xtrsTimer::Ptr{xtrsTimer_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function initTRStimer(xtrsTimer, grid)
    @ccall libsuperlu_dist_Int32.initTRStimer(xtrsTimer::Ptr{xtrsTimer_t}, grid::Ptr{gridinfo_t})::Cvoid
end

function getTreePerm(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, perm_c_supno, iperm_c_supno, grid3d)
    @ccall libsuperlu_dist_Int32.getTreePerm(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, perm_c_supno::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{Ptr{int_t}}
end

function getMyNodeCounts(maxLvl, myTreeIdxs, gNodeCount)
    @ccall libsuperlu_dist_Int32.getMyNodeCounts(maxLvl::int_t, myTreeIdxs::Ptr{int_t}, gNodeCount::Ptr{int_t})::Ptr{int_t}
end

function checkIntVector3d(vec, len, grid3d)
    @ccall libsuperlu_dist_Int32.checkIntVector3d(vec::Ptr{int_t}, len::int_t, grid3d::Ptr{gridinfo3d_t})::int_t
end

function reduceStat(PHASE, stat, grid3d)
    @ccall libsuperlu_dist_Int32.reduceStat(PHASE::PhaseType, stat::Ptr{SuperLUStat_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function Wait_LSend(k, grid, ToSendR, s, arg5)
    @ccall libsuperlu_dist_Int32.Wait_LSend(k::int_t, grid::Ptr{gridinfo_t}, ToSendR::Ptr{Ptr{Cint}}, s::Ptr{MPI_Request}, arg5::Ptr{SCT_t})::int_t
end

function Wait_USend(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.Wait_USend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t}, arg3::Ptr{SCT_t})::int_t
end

function Check_LRecv(arg1, msgcnt)
    @ccall libsuperlu_dist_Int32.Check_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint})::int_t
end

function Wait_UDiagBlockSend(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.Wait_UDiagBlockSend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t}, arg3::Ptr{SCT_t})::int_t
end

function Wait_LDiagBlockSend(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.Wait_LDiagBlockSend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t}, arg3::Ptr{SCT_t})::int_t
end

function Wait_UDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_dist_Int32.Wait_UDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Test_UDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_dist_Int32.Test_UDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Wait_LDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_dist_Int32.Wait_LDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Test_LDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_dist_Int32.Test_LDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function LDiagBlockRecvWait(k, factored_U, arg3, arg4)
    @ccall libsuperlu_dist_Int32.LDiagBlockRecvWait(k::int_t, factored_U::Ptr{Cint}, arg3::Ptr{MPI_Request}, arg4::Ptr{gridinfo_t})::int_t
end

function num_full_cols_U_mod(kk, usub, xsup, grid, perm_u, ldu)
    @ccall libsuperlu_dist_Int32.num_full_cols_U_mod(kk::int_t, usub::Ptr{int_t}, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, perm_u::Ptr{int_t}, ldu::Ptr{int_t})::int_t
end

struct sScalePermstruct_t
    DiagScale::DiagScale_t
    R::Ptr{Cfloat}
    C::Ptr{Cfloat}
    perm_r::Ptr{Cint}
    perm_c::Ptr{Cint}
    d_perm_r::Ptr{Cint}
    d_perm_c::Ptr{Cint}
    d_R::Ptr{Cfloat}
    d_C::Ptr{Cfloat}
end

struct sLocalLU_t
    Lrowind_bc_ptr::Ptr{Ptr{int_t}}
    Lrowind_bc_dat::Ptr{int_t}
    Lrowind_bc_offset::Ptr{Clong}
    Lrowind_bc_cnt::Clong
    Lnzval_bc_ptr::Ptr{Ptr{Cfloat}}
    Lnzval_bc_dat::Ptr{Cfloat}
    Lnzval_bc_offset::Ptr{Clong}
    Lnzval_bc_cnt::Clong
    Linv_bc_ptr::Ptr{Ptr{Cfloat}}
    Linv_bc_dat::Ptr{Cfloat}
    Linv_bc_offset::Ptr{Clong}
    Linv_bc_cnt::Clong
    Lindval_loc_bc_ptr::Ptr{Ptr{int_t}}
    Lindval_loc_bc_dat::Ptr{int_t}
    Lindval_loc_bc_offset::Ptr{Clong}
    Lindval_loc_bc_cnt::Clong
    Ucolind_bc_ptr::Ptr{Ptr{int_t}}
    Ucolind_bc_dat::Ptr{int_t}
    Ucolind_bc_offset::Ptr{Int64}
    Ucolind_bc_cnt::Int64
    Unzval_bc_ptr::Ptr{Ptr{Cfloat}}
    Unzval_bc_dat::Ptr{Cfloat}
    Unzval_bc_offset::Ptr{Int64}
    Unzval_bc_cnt::Int64
    Uindval_loc_bc_ptr::Ptr{Ptr{int_t}}
    Uindval_loc_bc_dat::Ptr{int_t}
    Uindval_loc_bc_offset::Ptr{Int64}
    Uindval_loc_bc_cnt::Int64
    Uind_br_ptr::Ptr{Ptr{int_t}}
    Uind_br_dat::Ptr{int_t}
    Uind_br_offset::Ptr{Int64}
    Uind_br_cnt::Int64
    Ucolind_br_ptr::Ptr{Ptr{int_t}}
    Ucolind_br_dat::Ptr{int_t}
    Ucolind_br_offset::Ptr{Int64}
    Ucolind_br_cnt::Int64
    Unzval_br_new_ptr::Ptr{Ptr{Cfloat}}
    Unzval_br_new_dat::Ptr{Cfloat}
    Unzval_br_new_offset::Ptr{Int64}
    Unzval_br_new_cnt::Int64
    Unnz::Ptr{int_t}
    Lrowind_bc_2_lsum::Ptr{Ptr{int_t}}
    Uinv_bc_ptr::Ptr{Ptr{Cfloat}}
    Uinv_bc_dat::Ptr{Cfloat}
    Uinv_bc_offset::Ptr{Clong}
    Uinv_bc_cnt::Clong
    Ufstnz_br_ptr::Ptr{Ptr{int_t}}
    Ufstnz_br_dat::Ptr{int_t}
    Ufstnz_br_offset::Ptr{Clong}
    Ufstnz_br_cnt::Clong
    Unzval_br_ptr::Ptr{Ptr{Cfloat}}
    Unzval_br_dat::Ptr{Cfloat}
    Unzval_br_offset::Ptr{Clong}
    Unzval_br_cnt::Clong
    LBtree_ptr::Ptr{C_Tree}
    LRtree_ptr::Ptr{C_Tree}
    UBtree_ptr::Ptr{C_Tree}
    URtree_ptr::Ptr{C_Tree}
    Lsub_buf_2::NTuple{50, Ptr{int_t}}
    Lval_buf_2::NTuple{50, Ptr{Cfloat}}
    Usub_buf_2::NTuple{50, Ptr{int_t}}
    Uval_buf_2::NTuple{50, Ptr{Cfloat}}
    ujrow::Ptr{Cfloat}
    bufmax::NTuple{5, int_t}
    ToRecv::Ptr{Cint}
    ToSendD::Ptr{Cint}
    ToSendR::Ptr{Ptr{Cint}}
    fmod::Ptr{Cint}
    fsendx_plist::Ptr{Ptr{Cint}}
    frecv::Ptr{Cint}
    nfrecvx::Cint
    nfsendx::Cint
    bmod::Ptr{Cint}
    bsendx_plist::Ptr{Ptr{Cint}}
    brecv::Ptr{Cint}
    nbrecvx::Cint
    nbsendx::Cint
    mod_bit::Ptr{Cint}
    nleaf::Cint
    nroot::Cint
    ilsum::Ptr{int_t}
    ldalsum::int_t
    SolveMsgSent::int_t
    SolveMsgVol::int_t
    bcols_masked::Ptr{Cint}
    UT_SOLVE::int_t
    L_SOLVE::int_t
    FRECV::int_t
    ut_ldalsum::int_t
    ut_ilsum::Ptr{int_t}
    utmod::Ptr{int_t}
    ut_sendx_plist::Ptr{Ptr{int_t}}
    utrecv::Ptr{int_t}
    n_utsendx::int_t
    n_utrecvx::int_t
    n_utrecvmod::int_t
    ut_modbit::Ptr{int_t}
    Urbs::Ptr{int_t}
    Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}
    Ucb_inddat::Ptr{Ucb_indptr_t}
    Ucb_indoffset::Ptr{Clong}
    Ucb_indcnt::Clong
    Ucb_valptr::Ptr{Ptr{int_t}}
    Ucb_valdat::Ptr{int_t}
    Ucb_valoffset::Ptr{Clong}
    Ucb_valcnt::Clong
    n::int_t
    nfrecvmod::int_t
    inv::int_t
    nbcol_masked::Cint
    d_Lrowind_bc_dat::Ptr{int_t}
    d_Lrowind_bc_offset::Ptr{Clong}
    d_Lnzval_bc_dat::Ptr{Cfloat}
    d_Lnzval_bc_offset::Ptr{Clong}
    d_Ucolind_bc_dat::Ptr{int_t}
    d_Ucolind_bc_offset::Ptr{Int64}
    d_Uind_br_dat::Ptr{int_t}
    d_Uind_br_offset::Ptr{Int64}
    d_Unzval_bc_dat::Ptr{Cfloat}
    d_Unzval_bc_offset::Ptr{Clong}
    d_Ucolind_br_dat::Ptr{int_t}
    d_Ucolind_br_offset::Ptr{Int64}
    d_Unzval_br_new_dat::Ptr{Cfloat}
    d_Unzval_br_new_offset::Ptr{Int64}
    d_Linv_bc_dat::Ptr{Cfloat}
    d_Uinv_bc_dat::Ptr{Cfloat}
    d_Linv_bc_offset::Ptr{Clong}
    d_Uinv_bc_offset::Ptr{Clong}
    d_Lindval_loc_bc_dat::Ptr{int_t}
    d_Lindval_loc_bc_offset::Ptr{Int64}
    d_Uindval_loc_bc_dat::Ptr{int_t}
    d_Uindval_loc_bc_offset::Ptr{Int64}
    d_bcols_masked::Ptr{Cint}
    d_ilsum::Ptr{int_t}
    d_xsup::Ptr{int_t}
    d_supno::Ptr{int_t}
    d_LBtree_ptr::Ptr{C_Tree}
    d_LRtree_ptr::Ptr{C_Tree}
    d_UBtree_ptr::Ptr{C_Tree}
    d_URtree_ptr::Ptr{C_Tree}
    d_grid::Ptr{gridinfo_t}
end

struct sLUValSubBuf_t
    Lsub_buf::Ptr{int_t}
    Lval_buf::Ptr{Cfloat}
    Usub_buf::Ptr{int_t}
    Uval_buf::Ptr{Cfloat}
end

struct strf3Dpartition_t
    nsupers::int_t
    gEtreeInfo::gEtreeInfo_t
    iperm_c_supno::Ptr{int_t}
    myNodeCount::Ptr{int_t}
    myTreeIdxs::Ptr{int_t}
    myZeroTrIdxs::Ptr{int_t}
    treePerm::Ptr{Ptr{int_t}}
    sForests::Ptr{Ptr{sForest_t}}
    supernode2treeMap::Ptr{int_t}
    supernodeMask::Ptr{Cint}
    LUvsb::Ptr{sLUValSubBuf_t}
    superGridMap::Ptr{SupernodeToGridMap_t}
    d_superGridMap::Ptr{SupernodeToGridMap_t}
    maxLvl::Cint
    mxLeafNode::Cint
    diagDims::Ptr{Cint}
    gemmCsizes::Ptr{Cint}
end

struct sLUstruct_t
    etree::Ptr{int_t}
    Glu_persist::Ptr{Glu_persist_t}
    Llu::Ptr{sLocalLU_t}
    trf3Dpart::Ptr{strf3Dpartition_t}
    dt::Cchar
end

struct psgsmv_comm_t
    extern_start::Ptr{int_t}
    ind_tosend::Ptr{int_t}
    ind_torecv::Ptr{int_t}
    ptr_ind_tosend::Ptr{int_t}
    ptr_ind_torecv::Ptr{int_t}
    SendCounts::Ptr{Cint}
    RecvCounts::Ptr{Cint}
    val_tosend::Ptr{Cvoid}
    val_torecv::Ptr{Cvoid}
    TotalIndSend::int_t
    TotalValSend::int_t
end

struct sSOLVEstruct_t
    row_to_proc::Ptr{int_t}
    inv_perm_c::Ptr{Cint}
    num_diag_procs::int_t
    diag_procs::Ptr{int_t}
    diag_len::Ptr{int_t}
    gsmv_comm::Ptr{psgsmv_comm_t}
    gstrs_comm::Ptr{pxgstrs_comm_t}
    A_colind_gsmv::Ptr{int_t}
    xrow_to_proc::Ptr{int_t}
    A3d::Ptr{NRformat_loc3d}
    d_lsum::Ptr{Cfloat}
    d_lsum_save::Ptr{Cfloat}
    d_x::Ptr{Cfloat}
    d_fmod_save::Ptr{Cint}
    d_fmod::Ptr{Cint}
    d_bmod_save::Ptr{Cint}
    d_bmod::Ptr{Cint}
    d_ptr_to_idbuf_X2B::Ptr{Cint}
    d_ptr_to_idbuf_X2B_save::Ptr{Cint}
    d_ptr_to_idbuf_B2X::Ptr{Cint}
    d_ptr_to_idbuf_B2X_save::Ptr{Cint}
    d_inv_perm_c::Ptr{Cint}
    d_ptr_to_idbuf_PermuteC::Ptr{Cint}
    d_ptr_to_idbuf_PermuteC_save::Ptr{Cint}
    d_row_to_proc::Ptr{int_t}
    d_diag_procs::Ptr{int_t}
    d_send_idbuf_B2X::Ptr{Cfloat}
    d_send_idbuf_X2B::Ptr{Cfloat}
    d_send_idbuf_PermuteC::Ptr{Cfloat}
    d_recv_idbuf_B2X::Ptr{Cfloat}
    d_recv_idbuf_X2B::Ptr{Cfloat}
    d_recv_idbuf_PermuteC::Ptr{Cfloat}
end

"""
    svbatch_ctx_t

\\brief Persistent state for repeated batch solves that share one sparsity
 pattern.  Callers hold it only as the opaque handle F[0], see
 psgssvx3d_csc_vbatch().

Everything here is built on the Fact = DOFACT call and reused on every
subsequent SamePattern_SameRowPerm call: the internal 1x1x1 grid, the
stacked block-diagonal matrix A_big and its CSR arrays, and the
factorization metadata (etree, perm_c of the big system, symbolic
factorization, and the distributed L/U structure).
"""
struct svbatch_ctx_t
    initialized::Cint
    batchCount::Cint
    nrhs::Cint
    m_big::Cint
    n_big::Cint
    nnz_big::Cint
    gridalloc::Cint
    grid::gridinfo3d_t
    options_big::superlu_dist_options_t
    ScalePermstruct::sScalePermstruct_t
    LUstruct::sLUstruct_t
    SOLVEstruct::sSOLVEstruct_t
    A_big::SuperMatrix
    a_big::Ptr{Cfloat}
    colind::Ptr{int_t}
    rowptr::Ptr{int_t}
    b::Ptr{Cfloat}
    berr::Ptr{Cfloat}
end

function scuStatUpdate(knsupc, HyP, SCT, stat)
    @ccall libsuperlu_dist_Int32.scuStatUpdate(knsupc::int_t, HyP::Ptr{HyP_t}, SCT::Ptr{SCT_t}, stat::Ptr{SuperLUStat_t})::int_t
end

struct sscuBufs_t
    bigU::Ptr{Cfloat}
    bigV::Ptr{Cfloat}
end

struct sdiagFactBufs_t
    BlockLFactor::Ptr{Cfloat}
    BlockUFactor::Ptr{Cfloat}
end

struct sxT_struct
    xT::Ptr{Cfloat}
    ldaspaT::int_t
    ilsumT::Ptr{int_t}
end

struct slsumBmod_buff_t
    tX::Ptr{Cfloat}
    tU::Ptr{Cfloat}
    indCols::Ptr{int_t}
end

function sCreate_CompCol_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.sCreate_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{Cfloat}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Stype_t, arg9::Dtype_t, arg10::Mtype_t)::Cvoid
end

function sCreate_CompRowLoc_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.sCreate_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{Cfloat}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Stype_t, arg11::Dtype_t, arg12::Mtype_t)::Cvoid
end

function sCompRow_to_CompCol_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sCompRow_to_CompCol_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{Cfloat}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{Ptr{Cfloat}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{Ptr{int_t}})::Cvoid
end

function sCompCol_to_CompRow_dist(m, n, nnz, a, colptr, rowind, at, rowptr, colind)
    @ccall libsuperlu_dist_Int32.sCompCol_to_CompRow_dist(m::int_t, n::int_t, nnz::int_t, a::Ptr{Cfloat}, colptr::Ptr{int_t}, rowind::Ptr{int_t}, at::Ptr{Ptr{Cfloat}}, rowptr::Ptr{Ptr{int_t}}, colind::Ptr{Ptr{int_t}})::Cvoid
end

function psCompRow_loc_to_CompCol_global(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.psCompRow_loc_to_CompCol_global(arg1::int_t, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperMatrix})::Cint
end

function sCopy_CompCol_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sCopy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function sCreate_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sCreate_Dense_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::Ptr{Cfloat}, arg5::int_t, arg6::Stype_t, arg7::Dtype_t, arg8::Mtype_t)::Cvoid
end

function sCreate_SuperNode_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.sCreate_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{Cfloat}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Stype_t, arg12::Dtype_t, arg13::Mtype_t)::Cvoid
end

function sCopy_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.sCopy_Dense_Matrix_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cfloat}, arg4::int_t, arg5::Ptr{Cfloat}, arg6::int_t)::Cvoid
end

function sallocateA_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sallocateA_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Ptr{int_t}}, arg5::Ptr{Ptr{int_t}})::Cvoid
end

function sGenXtrue_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.sGenXtrue_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cfloat}, arg4::int_t)::Cvoid
end

function sFillRHS_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sFillRHS_dist(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cfloat}, arg4::int_t, arg5::Ptr{SuperMatrix}, arg6::Ptr{Cfloat}, arg7::int_t)::Cvoid
end

function screate_matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.screate_matrix(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function screate_matrix_rb(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.screate_matrix_rb(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function screate_matrix_dat(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.screate_matrix_dat(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function screate_matrix_postfix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.screate_matrix_postfix(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{Cchar}, arg9::Ptr{gridinfo_t})::Cint
end

function sScalePermstructInit(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.sScalePermstructInit(arg1::int_t, arg2::int_t, arg3::Ptr{sScalePermstruct_t})::Cvoid
end

function sScalePermstructFree(arg1)
    @ccall libsuperlu_dist_Int32.sScalePermstructFree(arg1::Ptr{sScalePermstruct_t})::Cvoid
end

function sgsequ_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sgsequ_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat}, arg7::Ptr{Cint})::Cvoid
end

function slangs_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.slangs_dist(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix})::Cfloat
end

function slaqgs_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.slaqgs_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Cfloat, arg5::Cfloat, arg6::Cfloat, arg7::Ptr{Cchar})::Cvoid
end

function psgsequ(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.psgsequ(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat}, arg7::Ptr{Cint}, arg8::Ptr{gridinfo_t})::Cvoid
end

function pslangs(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.pslangs(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t})::Cfloat
end

function pslaqgs(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pslaqgs(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Cfloat, arg5::Cfloat, arg6::Cfloat, arg7::Ptr{Cchar})::Cvoid
end

function psPermute_Dense_Matrix(arg1, arg2, arg3, perm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.psPermute_Dense_Matrix(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, perm::Ptr{Cint}, arg5::Ptr{Cfloat}, arg6::Cint, arg7::Ptr{Cfloat}, arg8::Cint, arg9::Cint, arg10::Ptr{gridinfo_t})::Cint
end

function psPermute_Dense_Matrix_gpu_wrap(fst_row, m_loc, n, d_X, ldx, d_B, ldb, nrhs, grid, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.psPermute_Dense_Matrix_gpu_wrap(fst_row::int_t, m_loc::int_t, n::int_t, d_X::Ptr{Cfloat}, ldx::int_t, d_B::Ptr{Cfloat}, ldb::int_t, nrhs::Cint, grid::Ptr{gridinfo_t}, SOLVEstruct::Ptr{sSOLVEstruct_t})::Cint
end

function sundo_equilibration_rhs_wrap(B, ldb, m_loc, nrhs, fst_row, notran, rowequ, colequ, ScalePermstruct)
    @ccall libsuperlu_dist_Int32.sundo_equilibration_rhs_wrap(B::Ptr{Cfloat}, ldb::int_t, m_loc::int_t, nrhs::Cint, fst_row::int_t, notran::Cint, rowequ::Cint, colequ::Cint, ScalePermstruct::Ptr{sScalePermstruct_t})::Cvoid
end

function sscale_and_copy_rhs_wrap(B, ldb, X, ldx, m_loc, nrhs, fst_row, notran, rowequ, colequ, ScalePermstruct)
    @ccall libsuperlu_dist_Int32.sscale_and_copy_rhs_wrap(B::Ptr{Cfloat}, ldb::int_t, X::Ptr{Cfloat}, ldx::int_t, m_loc::int_t, nrhs::Cint, fst_row::int_t, notran::Cint, rowequ::Cint, colequ::Cint, ScalePermstruct::Ptr{sScalePermstruct_t})::Cvoid
end

function sdevice_matcopy_wrap(m, nrhs, dst, lddst, src, ldsrc)
    @ccall libsuperlu_dist_Int32.sdevice_matcopy_wrap(m::int_t, nrhs::Cint, dst::Ptr{Cfloat}, lddst::int_t, src::Ptr{Cfloat}, ldsrc::int_t)::Cvoid
end

function sdevice_add_to_vec_wrap(dst, src, n)
    @ccall libsuperlu_dist_Int32.sdevice_add_to_vec_wrap(dst::Ptr{Cfloat}, src::Ptr{Cfloat}, n::int_t)::Cvoid
end

function strs_B_init3d_zero_inactive_gpu_wrap(x, nrhs, nsupers, nlb, ilsum, xsup, superGridMap, nprow, npcol, myrow, mycol)
    @ccall libsuperlu_dist_Int32.strs_B_init3d_zero_inactive_gpu_wrap(x::Ptr{Cfloat}, nrhs::Cint, nsupers::int_t, nlb::int_t, ilsum::Ptr{int_t}, xsup::Ptr{int_t}, superGridMap::Ptr{SupernodeToGridMap_t}, nprow::Cint, npcol::Cint, myrow::Cint, mycol::Cint)::Cvoid
end

function strs_X_gather3d_pack_gpu_wrap(packbuf, x, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.strs_X_gather3d_pack_gpu_wrap(packbuf::Ptr{Cfloat}, x::Ptr{Cfloat}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function strs_X_gather3d_unpack_gpu_wrap(x, packbuf, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.strs_X_gather3d_unpack_gpu_wrap(x::Ptr{Cfloat}, packbuf::Ptr{Cfloat}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function strs_X_gather3d_pack_zero_gpu_wrap(packbuf, x, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.strs_X_gather3d_pack_zero_gpu_wrap(packbuf::Ptr{Cfloat}, x::Ptr{Cfloat}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function strs_X_gather3d_unpack_add_gpu_wrap(x, packbuf, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.strs_X_gather3d_unpack_add_gpu_wrap(x::Ptr{Cfloat}, packbuf::Ptr{Cfloat}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function sSolveInit_nvshmem_gpures(options, fst_row, m_loc, nrhs, n, grid, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.sSolveInit_nvshmem_gpures(options::Ptr{superlu_dist_options_t}, fst_row::int_t, m_loc::int_t, nrhs::int_t, n::int_t, grid::Ptr{gridinfo_t}, SOLVEstruct::Ptr{sSOLVEstruct_t})::Cint
end

function sFree_nvshmem_gpures(options, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.sFree_nvshmem_gpures(options::Ptr{superlu_dist_options_t}, SOLVEstruct::Ptr{sSOLVEstruct_t})::Cvoid
end

function sp_strsv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sp_strsv_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cchar}, arg3::Ptr{Cchar}, arg4::Ptr{SuperMatrix}, arg5::Ptr{SuperMatrix}, arg6::Ptr{Cfloat}, arg7::Ptr{Cint})::Cint
end

function sp_sgemv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sp_sgemv_dist(arg1::Ptr{Cchar}, arg2::Cfloat, arg3::Ptr{SuperMatrix}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cfloat, arg7::Ptr{Cfloat}, arg8::Cint)::Cint
end

function sp_sgemm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sp_sgemm_dist(arg1::Ptr{Cchar}, arg2::Cint, arg3::Cfloat, arg4::Ptr{SuperMatrix}, arg5::Ptr{Cfloat}, arg6::Cint, arg7::Cfloat, arg8::Ptr{Cfloat}, arg9::Cint)::Cint
end

function sdistribute(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.sdistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{Glu_freeable_t}, arg5::Ptr{sLUstruct_t}, arg6::Ptr{gridinfo_t})::Cfloat
end

function psgssvx_ABglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.psgssvx_ABglobal(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{sScalePermstruct_t}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t}, arg8::Ptr{sLUstruct_t}, arg9::Ptr{Cfloat}, arg10::Ptr{SuperLUStat_t}, arg11::Ptr{Cint})::Cvoid
end

function psdistribute(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.psdistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{sScalePermstruct_t}, arg5::Ptr{Glu_freeable_t}, arg6::Ptr{sLUstruct_t}, arg7::Ptr{gridinfo_t})::Cfloat
end

function psdistribute_allgrid(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid, supernodeMask)
    @ccall libsuperlu_dist_Int32.psdistribute_allgrid(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{sScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{sLUstruct_t}, grid::Ptr{gridinfo_t}, supernodeMask::Ptr{Cint})::Cfloat
end

function psdistribute_allgrid_index_only(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid, supernodeMask)
    @ccall libsuperlu_dist_Int32.psdistribute_allgrid_index_only(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{sScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{sLUstruct_t}, grid::Ptr{gridinfo_t}, supernodeMask::Ptr{Cint})::Cfloat
end

function psgssvx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.psgssvx(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{sScalePermstruct_t}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t}, arg8::Ptr{sLUstruct_t}, arg9::Ptr{sSOLVEstruct_t}, arg10::Ptr{Cfloat}, arg11::Ptr{SuperLUStat_t}, arg12::Ptr{Cint})::Cvoid
end

function psCompute_Diag_Inv(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.psCompute_Diag_Inv(arg1::int_t, arg2::Ptr{sLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{Cint})::Cvoid
end

function sSolveInit(arg1, arg2, perm_r, perm_c, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.sSolveInit(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, perm_r::Ptr{Cint}, perm_c::Ptr{Cint}, arg5::int_t, arg6::int_t, arg7::Ptr{sLUstruct_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{sSOLVEstruct_t}, arg10::Ptr{sScalePermstruct_t})::Cint
end

function sSolveFinalize(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sSolveFinalize(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{sSOLVEstruct_t})::Cvoid
end

function sDestroy_A3d_gathered_on_2d(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sDestroy_A3d_gathered_on_2d(arg1::Ptr{sSOLVEstruct_t}, arg2::Ptr{gridinfo3d_t})::Cvoid
end

function psgstrs_init(arg1, arg2, arg3, arg4, perm_r, perm_c, grid, arg8, arg9)
    @ccall libsuperlu_dist_Int32.psgstrs_init(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, perm_r::Ptr{Cint}, perm_c::Ptr{Cint}, grid::Ptr{gridinfo_t}, arg8::Ptr{Glu_persist_t}, arg9::Ptr{sSOLVEstruct_t})::int_t
end

function psgstrs_init_device_lsum_x(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.psgstrs_init_device_lsum_x(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{gridinfo_t}, arg6::Ptr{sLUstruct_t}, arg7::Ptr{sSOLVEstruct_t}, arg8::Ptr{Cint})::int_t
end

function psgstrs_delete_device_lsum_x(arg1)
    @ccall libsuperlu_dist_Int32.psgstrs_delete_device_lsum_x(arg1::Ptr{sSOLVEstruct_t})::int_t
end

function pxgstrs_finalize(arg1)
    @ccall libsuperlu_dist_Int32.pxgstrs_finalize(arg1::Ptr{pxgstrs_comm_t})::Cvoid
end

function sldperm_dist(arg1, arg2, arg3, arg4, arg5, arg6, perm, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sldperm_dist(arg1::Cint, arg2::Cint, arg3::int_t, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Cfloat}, perm::Ptr{Cint}, arg8::Ptr{Cfloat}, arg9::Ptr{Cfloat})::Cint
end

function sstatic_schedule(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sstatic_schedule(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{sLUstruct_t}, arg5::Ptr{gridinfo_t}, arg6::Ptr{SuperLUStat_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Cint})::Cint
end

function sLUstructInit(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sLUstructInit(arg1::int_t, arg2::Ptr{sLUstruct_t})::Cvoid
end

function sLUstructFree(arg1)
    @ccall libsuperlu_dist_Int32.sLUstructFree(arg1::Ptr{sLUstruct_t})::Cvoid
end

function sDestroy_LU(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.sDestroy_LU(arg1::int_t, arg2::Ptr{gridinfo_t}, arg3::Ptr{sLUstruct_t})::Cvoid
end

function sDestroy_Tree(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.sDestroy_Tree(arg1::int_t, arg2::Ptr{gridinfo_t}, arg3::Ptr{sLUstruct_t})::Cvoid
end

function sscatter_l(ib, ljb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, usub, lsub, tempv, indirect_thread, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, grid)
    @ccall libsuperlu_dist_Int32.sscatter_l(ib::Cint, ljb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, usub::Ptr{int_t}, lsub::Ptr{int_t}, tempv::Ptr{Cfloat}, indirect_thread::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{Cfloat}}, grid::Ptr{gridinfo_t})::Cvoid
end

function sscatter_u(ib, jb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, lsub, usub, tempv, Ufstnz_br_ptr, Unzval_br_ptr, grid)
    @ccall libsuperlu_dist_Int32.sscatter_u(ib::Cint, jb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, lsub::Ptr{int_t}, usub::Ptr{int_t}, tempv::Ptr{Cfloat}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{Cfloat}}, grid::Ptr{gridinfo_t})::Cvoid
end

function psgstrf(arg1, arg2, arg3, anorm, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.psgstrf(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, anorm::Cfloat, arg5::Ptr{sLUstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SuperLUStat_t}, arg8::Ptr{Cint})::int_t
end

function psgstrs_Bglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.psgstrs_Bglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{sLUstruct_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{Cfloat}, arg6::int_t, arg7::Cint, arg8::Ptr{SuperLUStat_t}, arg9::Ptr{Cint})::Cvoid
end

function psgstrs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.psgstrs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{sLUstruct_t}, arg4::Ptr{sScalePermstruct_t}, arg5::Ptr{gridinfo_t}, arg6::Ptr{Cfloat}, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Cint, arg11::Ptr{sSOLVEstruct_t}, arg12::Ptr{SuperLUStat_t}, arg13::Ptr{Cint})::Cvoid
end

function psgstrf2_trsm(options, k0, k, thresh, arg5, arg6, arg7, arg8, tag_ub, arg10, info)
    @ccall libsuperlu_dist_Int32.psgstrf2_trsm(options::Ptr{superlu_dist_options_t}, k0::int_t, k::int_t, thresh::Cdouble, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{sLocalLU_t}, arg8::Ptr{MPI_Request}, tag_ub::Cint, arg10::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function psgstrs2_omp(k0, k, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.psgstrs2_omp(k0::int_t, k::int_t, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{sLocalLU_t}, arg6::Ptr{Ublock_info_t}, arg7::Ptr{SuperLUStat_t})::Cvoid
end

function psReDistribute_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.psReDistribute_B_to_X(B::Ptr{Cfloat}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{Cfloat}, arg8::Ptr{sScalePermstruct_t}, arg9::Ptr{Glu_persist_t}, arg10::Ptr{gridinfo_t}, arg11::Ptr{sSOLVEstruct_t})::int_t
end

function slsum_fmod(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.slsum_fmod(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::int_t, arg11::int_t, arg12::Ptr{int_t}, arg13::Ptr{gridinfo_t}, arg14::Ptr{sLocalLU_t}, arg15::Ptr{MPI_Request}, arg16::Ptr{SuperLUStat_t})::Cvoid
end

function slsum_bmod(arg1, arg2, arg3, arg4, arg5, bmod, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int32.slsum_bmod(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Cint, arg5::int_t, bmod::Ptr{Cint}, arg7::Ptr{int_t}, arg8::Ptr{Ptr{Ucb_indptr_t}}, arg9::Ptr{Ptr{int_t}}, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{sLocalLU_t}, arg13::Ptr{MPI_Request}, arg14::Ptr{SuperLUStat_t})::Cvoid
end

function slsum_fmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, fmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int32.slsum_fmod_inv(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::int_t, fmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{gridinfo_t}, arg10::Ptr{sLocalLU_t}, arg11::Ptr{Ptr{SuperLUStat_t}}, arg12::Ptr{int_t}, arg13::Ptr{int_t}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function slsum_fmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int32.slsum_fmod_inv_master(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{sLocalLU_t}, arg13::Ptr{Ptr{SuperLUStat_t}}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function slsum_bmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    @ccall libsuperlu_dist_Int32.slsum_bmod_inv(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{sLocalLU_t}, arg14::Ptr{Ptr{SuperLUStat_t}}, arg15::Ptr{int_t}, arg16::Ptr{int_t}, arg17::int_t, arg18::int_t, arg19::Cint, arg20::Cint)::Cvoid
end

function slsum_bmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    @ccall libsuperlu_dist_Int32.slsum_bmod_inv_master(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{sLocalLU_t}, arg14::Ptr{Ptr{SuperLUStat_t}}, arg15::int_t, arg16::int_t, arg17::Cint, arg18::Cint)::Cvoid
end

function sComputeLevelsets(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.sComputeLevelsets(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t}, arg6::Ptr{int_t})::Cvoid
end

function psconvertU(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.psconvertU(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{sLUstruct_t}, arg4::Ptr{SuperLUStat_t}, arg5::Cint)::Cvoid
end

function slsum_fmod_inv_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, fmod, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48)
    @ccall libsuperlu_dist_Int32.slsum_fmod_inv_gpu_wrap(arg1::Cint, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat}, arg7::Cint, arg8::Cint, arg9::int_t, fmod::Ptr{Cint}, arg11::Ptr{C_Tree}, arg12::Ptr{C_Tree}, arg13::Ptr{int_t}, arg14::Ptr{int_t}, arg15::Ptr{Int64}, arg16::Ptr{Cfloat}, arg17::Ptr{Int64}, arg18::Ptr{Cfloat}, arg19::Ptr{Int64}, arg20::Ptr{int_t}, arg21::Ptr{Int64}, arg22::Ptr{int_t}, arg23::Ptr{Cint}, arg24::Ptr{gridinfo_t}, arg25::int_t, arg26::Ptr{UInt64}, arg27::Ptr{UInt64}, arg28::Ptr{Cfloat}, arg29::Ptr{Cfloat}, arg30::Ptr{Cint}, arg31::Ptr{Cint}, arg32::Ptr{Cint}, arg33::Ptr{Cint}, arg34::Ptr{Cint}, arg35::Ptr{Cint}, arg36::Ptr{Cint}, arg37::Ptr{Cint}, arg38::Ptr{Cint}, arg39::Ptr{Cint}, arg40::Ptr{Cint}, arg41::Ptr{Cint}, arg42::Ptr{Cint}, arg43::Ptr{Cint}, arg44::Ptr{Cint}, arg45::Ptr{Cint}, arg46::Ptr{Cint}, arg47::Ptr{Cint}, arg48::Cint)::Cvoid
end

function slsum_bmod_inv_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50, arg51, arg52, arg53, arg54)
    @ccall libsuperlu_dist_Int32.slsum_bmod_inv_gpu_wrap(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Cint, arg6::Ptr{Cfloat}, arg7::Ptr{Cfloat}, arg8::Cint, arg9::Cint, arg10::int_t, arg11::Ptr{Cint}, arg12::Ptr{C_Tree}, arg13::Ptr{C_Tree}, arg14::Ptr{int_t}, arg15::Ptr{int_t}, arg16::Ptr{Int64}, arg17::Ptr{int_t}, arg18::Ptr{Int64}, arg19::Ptr{int_t}, arg20::Ptr{Int64}, arg21::Ptr{Cfloat}, arg22::Ptr{Int64}, arg23::Ptr{Cfloat}, arg24::Ptr{Int64}, arg25::Ptr{Cfloat}, arg26::Ptr{Int64}, arg27::Ptr{int_t}, arg28::Ptr{Int64}, arg29::Ptr{int_t}, arg30::Ptr{gridinfo_t}, arg31::int_t, arg32::Ptr{UInt64}, arg33::Ptr{UInt64}, arg34::Ptr{Cfloat}, arg35::Ptr{Cfloat}, arg36::Ptr{Cint}, arg37::Ptr{Cint}, arg38::Ptr{Cint}, arg39::Ptr{Cint}, arg40::Ptr{Cint}, arg41::Ptr{Cint}, arg42::Ptr{Cint}, arg43::Ptr{Cint}, arg44::Ptr{Cint}, arg45::Ptr{Cint}, arg46::Ptr{Cint}, arg47::Ptr{Cint}, arg48::Ptr{Cint}, arg49::Ptr{Cint}, arg50::Ptr{Cint}, arg51::Ptr{Cint}, arg52::Ptr{Cint}, arg53::Ptr{Cint}, arg54::Cint)::Cvoid
end

function psReDistribute_B_to_X_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    @ccall libsuperlu_dist_Int32.psReDistribute_B_to_X_gpu_wrap(arg1::Ptr{Cfloat}, arg2::int_t, arg3::int_t, arg4::Cint, arg5::int_t, arg6::int_t, arg7::Ptr{Cfloat}, arg8::Ptr{sScalePermstruct_t}, arg9::Ptr{sSOLVEstruct_t}, arg10::Ptr{Glu_persist_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{int_t}, arg14::Ptr{int_t}, arg15::Ptr{int_t})::Cvoid
end

function psReDistribute_X_to_B_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.psReDistribute_X_to_B_gpu_wrap(arg1::Ptr{Cfloat}, arg2::int_t, arg3::int_t, arg4::Cint, arg5::int_t, arg6::int_t, arg7::int_t, arg8::Ptr{Cfloat}, arg9::Ptr{sScalePermstruct_t}, arg10::Ptr{sSOLVEstruct_t}, arg11::Ptr{Glu_persist_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{gridinfo_t}, arg14::Ptr{int_t}, arg15::Ptr{int_t}, arg16::Ptr{int_t})::Cvoid
end

function psgsrfs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.psgsrfs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cfloat, arg5::Ptr{sLUstruct_t}, arg6::Ptr{sScalePermstruct_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{Cfloat}, arg9::int_t, arg10::Ptr{Cfloat}, arg11::int_t, arg12::Cint, arg13::Ptr{sSOLVEstruct_t}, arg14::Ptr{Cfloat}, arg15::Ptr{SuperLUStat_t}, arg16::Ptr{Cint})::Cvoid
end

function psgsrfs3d(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
    @ccall libsuperlu_dist_Int32.psgsrfs3d(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cfloat, arg5::Ptr{sLUstruct_t}, arg6::Ptr{sScalePermstruct_t}, arg7::Ptr{gridinfo3d_t}, arg8::Ptr{strf3Dpartition_t}, arg9::Ptr{Cfloat}, arg10::int_t, arg11::Ptr{Cfloat}, arg12::int_t, arg13::Cint, arg14::Ptr{sSOLVEstruct_t}, arg15::Ptr{Cfloat}, arg16::Ptr{SuperLUStat_t}, arg17::Ptr{Cint})::Cvoid
end

function psgssvx3d_d2(options, A, ScalePermstruct, B, ldb, nrhs, grid3d, LUstruct, SOLVEstruct, berr, err_bounds, stat, info, xtrue)
    @ccall libsuperlu_dist_Int32.psgssvx3d_d2(options::Ptr{superlu_dist_options_t}, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{sScalePermstruct_t}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, LUstruct::Ptr{sLUstruct_t}, SOLVEstruct::Ptr{sSOLVEstruct_t}, berr::Ptr{Cfloat}, err_bounds::Ptr{Cfloat}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint}, xtrue::Ptr{Cdouble})::Cvoid
end

function psgsrfs3d_d2(options, n, A, anorm, LUstruct, ScalePermstruct, grid3d, trf3Dpartition, B, ldb, X, ldx, nrhs, SOLVEstruct, err_bounds, stat, info, xtrue)
    @ccall libsuperlu_dist_Int32.psgsrfs3d_d2(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, anorm::Cfloat, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, grid3d::Ptr{gridinfo3d_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, B::Ptr{Cfloat}, ldb::int_t, X::Ptr{Cfloat}, ldx::int_t, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, err_bounds::Ptr{Cfloat}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint}, xtrue::Ptr{Cdouble})::Cvoid
end

function psgssvx_d2(options, A, ScalePermstruct, B, ldb, nrhs, grid, LUstruct, SOLVEstruct, err_bounds, stat, info, xtrue)
    @ccall libsuperlu_dist_Int32.psgssvx_d2(options::Ptr{superlu_dist_options_t}, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{sScalePermstruct_t}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, grid::Ptr{gridinfo_t}, LUstruct::Ptr{sLUstruct_t}, SOLVEstruct::Ptr{sSOLVEstruct_t}, err_bounds::Ptr{Cfloat}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint}, xtrue::Ptr{Cdouble})::Cvoid
end

function psgmres(arg1, arg2, arg3, arg4, arg5, arg6, arg7, X, m_loc, fst_row, restart, maxit, rtol, atol, gs, arg16, totit, arg18, arg19)
    @ccall libsuperlu_dist_Int32.psgmres(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{sLUstruct_t}, arg5::Ptr{sScalePermstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{psgsmv_comm_t}, X::Ptr{Cfloat}, m_loc::int_t, fst_row::int_t, restart::Cint, maxit::Cint, rtol::Cdouble, atol::Cdouble, gs::Cint, arg16::Ptr{sSOLVEstruct_t}, totit::Ptr{Cint}, arg18::Ptr{SuperLUStat_t}, arg19::Ptr{Cint})::Cvoid
end

function psgmres3d(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, X, m_loc, fst_row, restart, maxit, rtol, atol, gs, arg17, totit, arg19, arg20)
    @ccall libsuperlu_dist_Int32.psgmres3d(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{sLUstruct_t}, arg5::Ptr{sScalePermstruct_t}, arg6::Ptr{gridinfo3d_t}, arg7::Ptr{strf3Dpartition_t}, arg8::Ptr{psgsmv_comm_t}, X::Ptr{Cfloat}, m_loc::int_t, fst_row::int_t, restart::Cint, maxit::Cint, rtol::Cdouble, atol::Cdouble, gs::Cint, arg17::Ptr{sSOLVEstruct_t}, totit::Ptr{Cint}, arg19::Ptr{SuperLUStat_t}, arg20::Ptr{Cint})::Cvoid
end

function psgsrfs_ABXglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int32.psgsrfs_ABXglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cfloat, arg5::Ptr{sLUstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{Cfloat}, arg8::int_t, arg9::Ptr{Cfloat}, arg10::int_t, arg11::Cint, arg12::Ptr{Cfloat}, arg13::Ptr{SuperLUStat_t}, arg14::Ptr{Cint})::Cvoid
end

function psgsmv_AXglobal_setup(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.psgsmv_AXglobal_setup(arg1::Ptr{SuperMatrix}, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{int_t})::Cint
end

function psgsmv_AXglobal(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.psgsmv_AXglobal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Cfloat}, arg4::Ptr{int_t}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat})::Cint
end

function psgsmv_AXglobal_abs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.psgsmv_AXglobal_abs(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Cfloat}, arg4::Ptr{int_t}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat})::Cint
end

function psgsmv_init(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.psgsmv_init(arg1::Ptr{SuperMatrix}, arg2::Ptr{int_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{psgsmv_comm_t})::Cvoid
end

function psgsmv(arg1, arg2, arg3, arg4, x, ax)
    @ccall libsuperlu_dist_Int32.psgsmv(arg1::int_t, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t}, arg4::Ptr{psgsmv_comm_t}, x::Ptr{Cfloat}, ax::Ptr{Cfloat})::Cvoid
end

function psgsmv_finalize(arg1)
    @ccall libsuperlu_dist_Int32.psgsmv_finalize(arg1::Ptr{psgsmv_comm_t})::Cvoid
end

function sinitLsumBmod_buff(ns, nrhs, lbmod_buf)
    @ccall libsuperlu_dist_Int32.sinitLsumBmod_buff(ns::int_t, nrhs::Cint, lbmod_buf::Ptr{slsumBmod_buff_t})::int_t
end

function sleafForestBackSolve3d(options, treeId, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, recvbuf, send_req, nrhs, lbmod_buf, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.sleafForestBackSolve3d(options::Ptr{superlu_dist_options_t}, treeId::int_t, n::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{Cfloat}, lsum::Ptr{Cfloat}, recvbuf::Ptr{Cfloat}, send_req::Ptr{MPI_Request}, nrhs::Cint, lbmod_buf::Ptr{slsumBmod_buff_t}, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function snonLeafForestBackSolve3d(treeId, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, xT_s, recvbuf, send_req, nrhs, lbmod_buf, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.snonLeafForestBackSolve3d(treeId::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{Cfloat}, lsum::Ptr{Cfloat}, xT_s::Ptr{sxT_struct}, recvbuf::Ptr{Cfloat}, send_req::Ptr{MPI_Request}, nrhs::Cint, lbmod_buf::Ptr{slsumBmod_buff_t}, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function slasum_bmod_Tree(pTree, cTree, lsum, x, xT_s, nrhs, lbmod_buf, LUstruct, trf3Dpartition, grid3d, stat)
    @ccall libsuperlu_dist_Int32.slasum_bmod_Tree(pTree::int_t, cTree::int_t, lsum::Ptr{Cfloat}, x::Ptr{Cfloat}, xT_s::Ptr{sxT_struct}, nrhs::Cint, lbmod_buf::Ptr{slsumBmod_buff_t}, LUstruct::Ptr{sLUstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function slsumForestBsolve(k, treeId, lsum, x, xT_s, nrhs, lbmod_buf, LUstruct, trf3Dpartition, grid3d, stat)
    @ccall libsuperlu_dist_Int32.slsumForestBsolve(k::int_t, treeId::int_t, lsum::Ptr{Cfloat}, x::Ptr{Cfloat}, xT_s::Ptr{sxT_struct}, nrhs::Cint, lbmod_buf::Ptr{slsumBmod_buff_t}, LUstruct::Ptr{sLUstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function sbCastXk2Pck(k, xT_s, nrhs, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.sbCastXk2Pck(k::int_t, xT_s::Ptr{sxT_struct}, nrhs::Cint, LUstruct::Ptr{sLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function slsumReducePrK(k, x, lsum, recvbuf, nrhs, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.slsumReducePrK(k::int_t, x::Ptr{Cfloat}, lsum::Ptr{Cfloat}, recvbuf::Ptr{Cfloat}, nrhs::Cint, LUstruct::Ptr{sLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function snonLeafForestForwardSolve3d(treeId, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, xT_s, recvbuf, rtemp, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.snonLeafForestForwardSolve3d(treeId::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{Cfloat}, lsum::Ptr{Cfloat}, xT_s::Ptr{sxT_struct}, recvbuf::Ptr{Cfloat}, rtemp::Ptr{Cfloat}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function sleafForestForwardSolve3d(options, treeId, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, recvbuf, rtemp, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.sleafForestForwardSolve3d(options::Ptr{superlu_dist_options_t}, treeId::int_t, n::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{Cfloat}, lsum::Ptr{Cfloat}, recvbuf::Ptr{Cfloat}, rtemp::Ptr{Cfloat}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function strs_compute_communication_structure(options, n, LUstruct, supernodeMask, grid)
    @ccall libsuperlu_dist_Int32.strs_compute_communication_structure(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{sLUstruct_t}, supernodeMask::Ptr{Cint}, grid::Ptr{gridinfo_t})::Cint
end

function sreduceSolvedX_newsolve(options, treeId, sender, receiver, x, nrhs, trf3Dpartition, LUstruct, grid3d, recvbuf, xtrsTimer)
    @ccall libsuperlu_dist_Int32.sreduceSolvedX_newsolve(options::Ptr{superlu_dist_options_t}, treeId::int_t, sender::int_t, receiver::int_t, x::Ptr{Cfloat}, nrhs::Cint, trf3Dpartition::Ptr{strf3Dpartition_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, recvbuf::Ptr{Cfloat}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function slsum_fmod_leaf(treeId, trf3Dpartition, lsum, x, xk, rtemp, nrhs, knsupc, k, fmod, nlb, lptr, luptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.slsum_fmod_leaf(treeId::int_t, trf3Dpartition::Ptr{strf3Dpartition_t}, lsum::Ptr{Cfloat}, x::Ptr{Cfloat}, xk::Ptr{Cfloat}, rtemp::Ptr{Cfloat}, nrhs::Cint, knsupc::Cint, k::int_t, fmod::Ptr{Cint}, nlb::int_t, lptr::int_t, luptr::int_t, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{sLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function slsum_fmod_leaf_newsolve(trf3Dpartition, lsum, x, xk, rtemp, nrhs, knsupc, k, fmod, nlb, lptr, luptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.slsum_fmod_leaf_newsolve(trf3Dpartition::Ptr{strf3Dpartition_t}, lsum::Ptr{Cfloat}, x::Ptr{Cfloat}, xk::Ptr{Cfloat}, rtemp::Ptr{Cfloat}, nrhs::Cint, knsupc::Cint, k::int_t, fmod::Ptr{Cint}, nlb::int_t, lptr::int_t, luptr::int_t, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{sLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function slsum_bmod_GG(lsum, x, xk, nrhs, lbmod_buf, k, bmod, Urbs, Ucb_indptr, Ucb_valptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.slsum_bmod_GG(lsum::Ptr{Cfloat}, x::Ptr{Cfloat}, xk::Ptr{Cfloat}, nrhs::Cint, lbmod_buf::Ptr{slsumBmod_buff_t}, k::int_t, bmod::Ptr{Cint}, Urbs::Ptr{int_t}, Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}, Ucb_valptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{sLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function slsum_bmod_GG_newsolve(trf3Dpartition, lsum, x, xk, nrhs, lbmod_buf, k, bmod, Urbs, Ucb_indptr, Ucb_valptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.slsum_bmod_GG_newsolve(trf3Dpartition::Ptr{strf3Dpartition_t}, lsum::Ptr{Cfloat}, x::Ptr{Cfloat}, xk::Ptr{Cfloat}, nrhs::Cint, lbmod_buf::Ptr{slsumBmod_buff_t}, k::int_t, bmod::Ptr{Cint}, Urbs::Ptr{int_t}, Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}, Ucb_valptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{sLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function psReDistribute3d_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, ScalePermstruct, Glu_persist, grid3d, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.psReDistribute3d_B_to_X(B::Ptr{Cfloat}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{Cfloat}, ScalePermstruct::Ptr{sScalePermstruct_t}, Glu_persist::Ptr{Glu_persist_t}, grid3d::Ptr{gridinfo3d_t}, SOLVEstruct::Ptr{sSOLVEstruct_t})::int_t
end

function psReDistribute3d_X_to_B(n, B, m_loc, ldb, fst_row, nrhs, x, ilsum, ScalePermstruct, Glu_persist, grid3d, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.psReDistribute3d_X_to_B(n::int_t, B::Ptr{Cfloat}, m_loc::int_t, ldb::int_t, fst_row::int_t, nrhs::Cint, x::Ptr{Cfloat}, ilsum::Ptr{int_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, Glu_persist::Ptr{Glu_persist_t}, grid3d::Ptr{gridinfo3d_t}, SOLVEstruct::Ptr{sSOLVEstruct_t})::int_t
end

function psgstrs3d(arg1, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, B, m_loc, fst_row, ldb, nrhs, SOLVEstruct, stat, info)
    @ccall libsuperlu_dist_Int32.psgstrs3d(arg1::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, B::Ptr{Cfloat}, m_loc::int_t, fst_row::int_t, ldb::int_t, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function psgstrs3d_newsolve(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, B, m_loc, fst_row, ldb, nrhs, SOLVEstruct, stat, info)
    @ccall libsuperlu_dist_Int32.psgstrs3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, B::Ptr{Cfloat}, m_loc::int_t, fst_row::int_t, ldb::int_t, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function psgsTrBackSolve3d(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, xT_s, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.psgsTrBackSolve3d(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{Cfloat}, lsum3d::Ptr{Cfloat}, xT_s::Ptr{sxT_struct}, recvbuf::Ptr{Cfloat}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function psgsTrForwardSolve3d(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, xT_s, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.psgsTrForwardSolve3d(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{Cfloat}, lsum3d::Ptr{Cfloat}, xT_s::Ptr{sxT_struct}, recvbuf::Ptr{Cfloat}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function psgsTrForwardSolve3d_newsolve(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.psgsTrForwardSolve3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{sLUstruct_t}, ScalePermstruct::Ptr{sScalePermstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{Cfloat}, lsum3d::Ptr{Cfloat}, recvbuf::Ptr{Cfloat}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function psgsTrBackSolve3d_newsolve(options, n, LUstruct, trf3Dpartition, grid3d, x3d, lsum3d, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.psgsTrBackSolve3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{sLUstruct_t}, trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{Cfloat}, lsum3d::Ptr{Cfloat}, recvbuf::Ptr{Cfloat}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{sSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function sbroadcastAncestor3d(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.sbroadcastAncestor3d(trf3Dpartition::Ptr{strf3Dpartition_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function slocalSolveXkYk(trtype, k, x, nrhs, LUstruct, grid, stat)
    @ccall libsuperlu_dist_Int32.slocalSolveXkYk(trtype::trtype_t, k::int_t, x::Ptr{Cfloat}, nrhs::Cint, LUstruct::Ptr{sLUstruct_t}, grid::Ptr{gridinfo_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function siBcastXk2Pck(k, x, nrhs, sendList, send_req, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.siBcastXk2Pck(k::int_t, x::Ptr{Cfloat}, nrhs::Cint, sendList::Ptr{Ptr{Cint}}, send_req::Ptr{MPI_Request}, LUstruct::Ptr{sLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function strs_B_init3d(nsupers, x, nrhs, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.strs_B_init3d(nsupers::int_t, x::Ptr{Cfloat}, nrhs::Cint, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function strs_X_gather3d(options, x, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.strs_X_gather3d(options::Ptr{superlu_dist_options_t}, x::Ptr{Cfloat}, nrhs::Cint, trf3Dpartition::Ptr{strf3Dpartition_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function sfsolveReduceLsum3d(treeId, sender, receiver, lsum, recvbuf, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.sfsolveReduceLsum3d(treeId::int_t, sender::int_t, receiver::int_t, lsum::Ptr{Cfloat}, recvbuf::Ptr{Cfloat}, nrhs::Cint, trf3Dpartition::Ptr{strf3Dpartition_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function sbsolve_Xt_bcast(ilvl, xT_s, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.sbsolve_Xt_bcast(ilvl::int_t, xT_s::Ptr{sxT_struct}, nrhs::Cint, trf3Dpartition::Ptr{strf3Dpartition_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function sp2pSolvedX3d(treeId, sender, receiver, x, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.sp2pSolvedX3d(treeId::int_t, sender::int_t, receiver::int_t, x::Ptr{Cfloat}, nrhs::Cint, trf3Dpartition::Ptr{strf3Dpartition_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function floatMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.floatMalloc_dist(arg1::int_t)::Ptr{Cfloat}
end

function floatCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.floatCalloc_dist(arg1::int_t)::Ptr{Cfloat}
end

function suser_malloc_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.suser_malloc_dist(arg1::int_t, arg2::int_t)::Ptr{Cvoid}
end

function suser_free_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.suser_free_dist(arg1::int_t, arg2::int_t)::Cvoid
end

function sQuerySpace_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sQuerySpace_dist(arg1::int_t, arg2::Ptr{sLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{superlu_dist_mem_usage_t})::int_t
end

function sClone_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sClone_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function sCopy_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sCopy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function sZero_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.sZero_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function sScaleAddId_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sScaleAddId_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Cfloat)::Cvoid
end

function sScaleAdd_CompRowLoc_Matrix_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.sScaleAdd_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix}, arg3::Cfloat)::Cvoid
end

function sZeroLblocks(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.sZeroLblocks(arg1::Cint, arg2::Cint, arg3::Ptr{gridinfo_t}, arg4::Ptr{sLUstruct_t})::Cvoid
end

function sZeroUblocks(iam, n, arg3, arg4)
    @ccall libsuperlu_dist_Int32.sZeroUblocks(iam::Cint, n::Cint, arg3::Ptr{gridinfo_t}, arg4::Ptr{sLUstruct_t})::Cvoid
end

function sMaxAbsLij(iam, n, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sMaxAbsLij(iam::Cint, n::Cint, arg3::Ptr{Glu_persist_t}, arg4::Ptr{sLUstruct_t}, arg5::Ptr{gridinfo_t})::Cfloat
end

function sMaxAbsUij(iam, n, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sMaxAbsUij(iam::Cint, n::Cint, arg3::Ptr{Glu_persist_t}, arg4::Ptr{sLUstruct_t}, arg5::Ptr{gridinfo_t})::Cfloat
end

function sfill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.sfill_dist(arg1::Ptr{Cfloat}, arg2::int_t, arg3::Cfloat)::Cvoid
end

function sinf_norm_error_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sinf_norm_error_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cfloat}, arg4::int_t, arg5::Ptr{Cfloat}, arg6::int_t, arg7::Ptr{gridinfo_t})::Cvoid
end

function psinf_norm_error(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.psinf_norm_error(arg1::Cint, arg2::int_t, arg3::int_t, arg4::Ptr{Cfloat}, arg5::int_t, arg6::Ptr{Cfloat}, arg7::int_t, arg8::MPI_Comm)::Cvoid
end

function sreadhb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sreadhb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function sreadtriple_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sreadtriple_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function sreadtriple_noheader(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sreadtriple_noheader(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function sreadrb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sreadrb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function sreadMM_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sreadMM_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function sread_binary(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sread_binary(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cint
end

function swrite_binary_withname(n, nnz, values, rowind, colptr, newfile)
    @ccall libsuperlu_dist_Int32.swrite_binary_withname(n::int_t, nnz::int_t, values::Ptr{Cfloat}, rowind::Ptr{int_t}, colptr::Ptr{int_t}, newfile::Ptr{Cchar})::Cint
end

function validateInput_psgssvx3d(arg1, A, ldb, nrhs, arg5, info)
    @ccall libsuperlu_dist_Int32.validateInput_psgssvx3d(arg1::Ptr{superlu_dist_options_t}, A::Ptr{SuperMatrix}, ldb::Cint, nrhs::Cint, arg5::Ptr{gridinfo3d_t}, info::Ptr{Cint})::Cvoid
end

function sallocScalePermstruct_RC(arg1, m, n)
    @ccall libsuperlu_dist_Int32.sallocScalePermstruct_RC(arg1::Ptr{sScalePermstruct_t}, m::int_t, n::int_t)::Cvoid
end

function sscaleMatrixDiagonally(Fact, arg2, arg3, arg4, arg5, rowequ, colequ, iinfo)
    @ccall libsuperlu_dist_Int32.sscaleMatrixDiagonally(Fact::fact_t, arg2::Ptr{sScalePermstruct_t}, arg3::Ptr{SuperMatrix}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{gridinfo_t}, rowequ::Ptr{Cint}, colequ::Ptr{Cint}, iinfo::Ptr{Cint})::Cvoid
end

function sperform_row_permutation(arg1, Fact, arg3, LUstruct, m, n, arg7, A, GA, arg10, job, Equil, rowequ, colequ, iinfo)
    @ccall libsuperlu_dist_Int32.sperform_row_permutation(arg1::Ptr{superlu_dist_options_t}, Fact::fact_t, arg3::Ptr{sScalePermstruct_t}, LUstruct::Ptr{sLUstruct_t}, m::int_t, n::int_t, arg7::Ptr{gridinfo_t}, A::Ptr{SuperMatrix}, GA::Ptr{SuperMatrix}, arg10::Ptr{SuperLUStat_t}, job::Cint, Equil::Cint, rowequ::Ptr{Cint}, colequ::Ptr{Cint}, iinfo::Ptr{Cint})::Cvoid
end

function scomputeA_Norm(notran, arg2, arg3)
    @ccall libsuperlu_dist_Int32.scomputeA_Norm(notran::Cint, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t})::Cfloat
end

function sdist_psymbtonum(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sdist_psymbtonum(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{sScalePermstruct_t}, arg5::Ptr{Pslu_freeable_t}, arg6::Ptr{sLUstruct_t}, arg7::Ptr{gridinfo_t})::Cfloat
end

function psGetDiagU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.psGetDiagU(arg1::int_t, arg2::Ptr{sLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{Cfloat})::Cvoid
end

function s_c2cpp_GetHWPM(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.s_c2cpp_GetHWPM(arg1::Ptr{SuperMatrix}, arg2::Ptr{gridinfo_t}, arg3::Ptr{sScalePermstruct_t})::Cint
end

function sPrintLblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sPrintLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t})::Cvoid
end

function sPrintUblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sPrintUblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t})::Cvoid
end

function sPrint_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.sPrint_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function sPrint_CompCol_triplet(arg1)
    @ccall libsuperlu_dist_Int32.sPrint_CompCol_triplet(arg1::Ptr{SuperMatrix})::Cvoid
end

function file_sPrint_NCPformat_triplet(arg1, arg2)
    @ccall libsuperlu_dist_Int32.file_sPrint_NCPformat_triplet(arg1::Ptr{Libc.FILE}, arg2::Ptr{SuperMatrix})::Cvoid
end

function sPrint_Dense_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.sPrint_Dense_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function sPrint_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.sPrint_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix})::Cint
end

function file_sPrint_CompRowLoc_Matrix_dist(fp, A)
    @ccall libsuperlu_dist_Int32.file_sPrint_CompRowLoc_Matrix_dist(fp::Ptr{Libc.FILE}, A::Ptr{SuperMatrix})::Cint
end

function Printfloat5(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.Printfloat5(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cfloat})::Cvoid
end

function file_Printfloat5(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.file_Printfloat5(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{Cfloat})::Cint
end

function sGenCOOLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.sGenCOOLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{Cfloat}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function sGenCSCLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.sGenCSCLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function sGenCSRLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.sGenCSRLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function nv_init_wrapper(arg1)
    @ccall libsuperlu_dist_Int32.nv_init_wrapper(arg1::MPI_Comm)::Cvoid
end

function sprepare_multiGPU_buffers(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.sprepare_multiGPU_buffers(arg1::Cint, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Cint, arg6::Cint)::Cvoid
end

# no prototype is found for this function at superlu_sdefs.h:1175:13, please use with caution
function sdelete_multiGPU_buffers()
    @ccall libsuperlu_dist_Int32.sdelete_multiGPU_buffers()::Cvoid
end

function superlu_sgemm(transa, transb, m, n, k, alpha, a, lda, b, ldb, beta, c, ldc)
    @ccall libsuperlu_dist_Int32.superlu_sgemm(transa::Ptr{Cchar}, transb::Ptr{Cchar}, m::Cint, n::Cint, k::Cint, alpha::Cfloat, a::Ptr{Cfloat}, lda::Cint, b::Ptr{Cfloat}, ldb::Cint, beta::Cfloat, c::Ptr{Cfloat}, ldc::Cint)::Cint
end

function superlu_strsm(sideRL, uplo, transa, diag, m, n, alpha, a, lda, b, ldb)
    @ccall libsuperlu_dist_Int32.superlu_strsm(sideRL::Ptr{Cchar}, uplo::Ptr{Cchar}, transa::Ptr{Cchar}, diag::Ptr{Cchar}, m::Cint, n::Cint, alpha::Cfloat, a::Ptr{Cfloat}, lda::Cint, b::Ptr{Cfloat}, ldb::Cint)::Cint
end

function superlu_sger(m, n, alpha, x, incx, y, incy, a, lda)
    @ccall libsuperlu_dist_Int32.superlu_sger(m::Cint, n::Cint, alpha::Cfloat, x::Ptr{Cfloat}, incx::Cint, y::Ptr{Cfloat}, incy::Cint, a::Ptr{Cfloat}, lda::Cint)::Cint
end

function superlu_sscal(n, alpha, x, incx)
    @ccall libsuperlu_dist_Int32.superlu_sscal(n::Cint, alpha::Cfloat, x::Ptr{Cfloat}, incx::Cint)::Cint
end

function superlu_saxpy(n, alpha, x, incx, y, incy)
    @ccall libsuperlu_dist_Int32.superlu_saxpy(n::Cint, alpha::Cfloat, x::Ptr{Cfloat}, incx::Cint, y::Ptr{Cfloat}, incy::Cint)::Cint
end

function superlu_sgemv(trans, m, n, alpha, a, lda, x, incx, beta, y, incy)
    @ccall libsuperlu_dist_Int32.superlu_sgemv(trans::Ptr{Cchar}, m::Cint, n::Cint, alpha::Cfloat, a::Ptr{Cfloat}, lda::Cint, x::Ptr{Cfloat}, incx::Cint, beta::Cfloat, y::Ptr{Cfloat}, incy::Cint)::Cint
end

function superlu_strsv(uplo, trans, diag, n, a, lda, x, incx)
    @ccall libsuperlu_dist_Int32.superlu_strsv(uplo::Ptr{Cchar}, trans::Ptr{Cchar}, diag::Ptr{Cchar}, n::Cint, a::Ptr{Cfloat}, lda::Cint, x::Ptr{Cfloat}, incx::Cint)::Cint
end

function screate_matrix3d(A, nrhs, rhs, ldb, x, ldx, fp, grid3d)
    @ccall libsuperlu_dist_Int32.screate_matrix3d(A::Ptr{SuperMatrix}, nrhs::Cint, rhs::Ptr{Ptr{Cfloat}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cfloat}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function screate_matrix_postfix3d(A, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.screate_matrix_postfix3d(A::Ptr{SuperMatrix}, nrhs::Cint, rhs::Ptr{Ptr{Cfloat}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cfloat}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function screate_block_diag_3d(A, batchCount, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.screate_block_diag_3d(A::Ptr{SuperMatrix}, batchCount::Cint, nrhs::Cint, rhs::Ptr{Ptr{Cfloat}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cfloat}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function screate_batch_systems(SparseMatrix_handles, batchCount, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.screate_batch_systems(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, rhs::Ptr{Ptr{Cfloat}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cfloat}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function screate_batch_systems_multiple(SparseMatrix_handles, batchCount, nrhs, RHSptr, ldRHS, xtrue, ldX, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.screate_batch_systems_multiple(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, RHSptr::Ptr{Ptr{Cfloat}}, ldRHS::Ptr{Cint}, xtrue::Ptr{Ptr{Cfloat}}, ldX::Ptr{Cint}, fp::Ptr{Ptr{Libc.FILE}}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function screate_batch_systems_rhsfile(SparseMatrix_handles, batchCount, nrhs, RHSptr, ldRHS, xtrue, ldX, fpA, fpB, fpX, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.screate_batch_systems_rhsfile(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, RHSptr::Ptr{Ptr{Cfloat}}, ldRHS::Ptr{Cint}, xtrue::Ptr{Ptr{Cfloat}}, ldX::Ptr{Cint}, fpA::Ptr{Ptr{Libc.FILE}}, fpB::Ptr{Ptr{Libc.FILE}}, fpX::Ptr{Ptr{Libc.FILE}}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function sbatch_systems_free(SparseMatrix_handles, batchCount, RHSptr, xtrue)
    @ccall libsuperlu_dist_Int32.sbatch_systems_free(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, RHSptr::Ptr{Ptr{Cfloat}}, xtrue::Ptr{Ptr{Cfloat}})::Cvoid
end

function sGatherNRformat_loc3d(Fact, A, B, ldb, nrhs, grid3d, arg7)
    @ccall libsuperlu_dist_Int32.sGatherNRformat_loc3d(Fact::fact_t, A::Ptr{NRformat_loc}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, arg7::Ptr{Ptr{NRformat_loc3d}})::Cvoid
end

function sGatherNRformat_loc3d_allgrid(options, Fact, A, B, ldb, nrhs, grid3d, arg8)
    @ccall libsuperlu_dist_Int32.sGatherNRformat_loc3d_allgrid(options::Ptr{superlu_dist_options_t}, Fact::fact_t, A::Ptr{NRformat_loc}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, arg8::Ptr{Ptr{NRformat_loc3d}})::Cvoid
end

function sScatter_B3d(options, A3d, grid3d)
    @ccall libsuperlu_dist_Int32.sScatter_B3d(options::Ptr{superlu_dist_options_t}, A3d::Ptr{NRformat_loc3d}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function psgssvx3d(arg1, arg2, arg3, B, ldb, nrhs, arg7, arg8, arg9, berr, arg11, info)
    @ccall libsuperlu_dist_Int32.psgssvx3d(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{sScalePermstruct_t}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, arg7::Ptr{gridinfo3d_t}, arg8::Ptr{sLUstruct_t}, arg9::Ptr{sSOLVEstruct_t}, berr::Ptr{Cfloat}, arg11::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function psgstrf3d(arg1, m, n, anorm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.psgstrf3d(arg1::Ptr{superlu_dist_options_t}, m::Cint, n::Cint, anorm::Cfloat, arg5::Ptr{strf3Dpartition_t}, arg6::Ptr{SCT_t}, arg7::Ptr{sLUstruct_t}, arg8::Ptr{gridinfo3d_t}, arg9::Ptr{SuperLUStat_t}, arg10::Ptr{Cint})::int_t
end

function sInit_HyP(arg1, HyP, Llu, mcb, mrb)
    @ccall libsuperlu_dist_Int32.sInit_HyP(arg1::Ptr{superlu_dist_options_t}, HyP::Ptr{HyP_t}, Llu::Ptr{sLocalLU_t}, mcb::int_t, mrb::int_t)::Cvoid
end

function Free_HyP(HyP)
    @ccall libsuperlu_dist_Int32.Free_HyP(HyP::Ptr{HyP_t})::Cvoid
end

function updateDirtyBit(k0, HyP, grid)
    @ccall libsuperlu_dist_Int32.updateDirtyBit(k0::int_t, HyP::Ptr{HyP_t}, grid::Ptr{gridinfo_t})::Cint
end

function sblock_gemm_scatter(lb, j, Ublock_info, Remain_info, L_mat, ldl, U_mat, ldu, bigV, knsupc, klst, lsub, usub, ldt, thread_id, indirect, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, Ufstnz_br_ptr, Unzval_br_ptr, xsup, arg23, arg24)
    @ccall libsuperlu_dist_Int32.sblock_gemm_scatter(lb::int_t, j::int_t, Ublock_info::Ptr{Ublock_info_t}, Remain_info::Ptr{Remain_info_t}, L_mat::Ptr{Cfloat}, ldl::Cint, U_mat::Ptr{Cfloat}, ldu::Cint, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, thread_id::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{Cfloat}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{Cfloat}}, xsup::Ptr{int_t}, arg23::Ptr{gridinfo_t}, arg24::Ptr{SuperLUStat_t})::Cvoid
end

function sblock_gemm_scatterTopLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.sblock_gemm_scatterTopLeft(lb::int_t, j::int_t, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{sLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function sblock_gemm_scatterTopRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.sblock_gemm_scatterTopRight(lb::int_t, j::int_t, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{sLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function sblock_gemm_scatterBottomLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.sblock_gemm_scatterBottomLeft(lb::int_t, j::int_t, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{sLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function sblock_gemm_scatterBottomRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.sblock_gemm_scatterBottomRight(lb::int_t, j::int_t, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{sLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function sgather_u(num_u_blks, Ublock_info, usub, uval, bigU, ldu, xsup, klst)
    @ccall libsuperlu_dist_Int32.sgather_u(num_u_blks::int_t, Ublock_info::Ptr{Ublock_info_t}, usub::Ptr{int_t}, uval::Ptr{Cfloat}, bigU::Ptr{Cfloat}, ldu::int_t, xsup::Ptr{int_t}, klst::int_t)::Cvoid
end

function sgather_l(num_LBlk, knsupc, L_info, lval, LD_lval, L_buff)
    @ccall libsuperlu_dist_Int32.sgather_l(num_LBlk::int_t, knsupc::int_t, L_info::Ptr{Remain_info_t}, lval::Ptr{Cfloat}, LD_lval::int_t, L_buff::Ptr{Cfloat})::Cvoid
end

function sRgather_L(k, lsub, lusup, arg4, arg5, arg6, arg7, myIperm, iperm_c_supno)
    @ccall libsuperlu_dist_Int32.sRgather_L(k::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cfloat}, arg4::Ptr{gEtreeInfo_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t})::Cvoid
end

function sRgather_U(k, jj0, usub, uval, bigU, arg6, arg7, arg8, arg9, myIperm, iperm_c_supno, perm_u)
    @ccall libsuperlu_dist_Int32.sRgather_U(k::int_t, jj0::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, bigU::Ptr{Cfloat}, arg6::Ptr{gEtreeInfo_t}, arg7::Ptr{Glu_persist_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, perm_u::Ptr{int_t})::Cvoid
end

function sbcastPermutedSparseA(A, ScalePermstruct, Glu_freeable, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sbcastPermutedSparseA(A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{sScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function snewTrfPartitionInit(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.snewTrfPartitionInit(nsupers::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function sinitTrf3Dpartition(nsupers, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sinitTrf3Dpartition(nsupers::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{strf3Dpartition_t}
end

function sinitTrf3Dpartition_allgrid(n, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sinitTrf3Dpartition_allgrid(n::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{strf3Dpartition_t}
end

function sinitTrf3DpartitionLUstructgrid0(n, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sinitTrf3DpartitionLUstructgrid0(n::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{strf3Dpartition_t}
end

function sDestroy_trf3Dpartition(trf3Dpartition)
    @ccall libsuperlu_dist_Int32.sDestroy_trf3Dpartition(trf3Dpartition::Ptr{strf3Dpartition_t})::Cvoid
end

function s3D_printMemUse(trf3Dpartition, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.s3D_printMemUse(trf3Dpartition::Ptr{strf3Dpartition_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function sinit3DLUstructForest(myTreeIdxs, myZeroTrIdxs, sForests, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sinit3DLUstructForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t}}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function sgatherAllFactoredLUFr(myZeroTrIdxs, sForests, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.sgatherAllFactoredLUFr(myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function sLpanelUpdate(off0, nsupc, ublk_ptr, ld_ujrow, lusup, nsupr, arg7)
    @ccall libsuperlu_dist_Int32.sLpanelUpdate(off0::int_t, nsupc::int_t, ublk_ptr::Ptr{Cfloat}, ld_ujrow::int_t, lusup::Ptr{Cfloat}, nsupr::int_t, arg7::Ptr{SCT_t})::int_t
end

function sgstrf2(k, diagBlk, LDA, BlockUfactor, LDU, thresh, xsup, options, stat, info)
    @ccall libsuperlu_dist_Int32.sgstrf2(k::int_t, diagBlk::Ptr{Cfloat}, LDA::int_t, BlockUfactor::Ptr{Cfloat}, LDU::int_t, thresh::Cdouble, xsup::Ptr{int_t}, options::Ptr{superlu_dist_options_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function Local_Sgstrf2(options, k, thresh, BlockUFactor, arg5, arg6, arg7, arg8, info, arg10)
    @ccall libsuperlu_dist_Int32.Local_Sgstrf2(options::Ptr{superlu_dist_options_t}, k::int_t, thresh::Cdouble, BlockUFactor::Ptr{Cfloat}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{sLocalLU_t}, arg8::Ptr{SuperLUStat_t}, info::Ptr{Cint}, arg10::Ptr{SCT_t})::Cvoid
end

function sTrs2_GatherU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int32.sTrs2_GatherU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, tempv::Ptr{Cfloat})::int_t
end

function sTrs2_ScatterU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int32.sTrs2_ScatterU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, tempv::Ptr{Cfloat})::int_t
end

function sTrs2_GatherTrsmScatter(klst, iukp, rukp, usub, uval, tempv, knsupc, nsupr, lusup, Glu_persist)
    @ccall libsuperlu_dist_Int32.sTrs2_GatherTrsmScatter(klst::int_t, iukp::int_t, rukp::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, tempv::Ptr{Cfloat}, knsupc::int_t, nsupr::Cint, lusup::Ptr{Cfloat}, Glu_persist::Ptr{Glu_persist_t})::int_t
end

function psgstrs2(m, k0, k, Glu_persist, grid, Llu, stat)
    @ccall libsuperlu_dist_Int32.psgstrs2(m::int_t, k0::int_t, k::int_t, Glu_persist::Ptr{Glu_persist_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{sLocalLU_t}, stat::Ptr{SuperLUStat_t})::Cvoid
end

function psgstrf2(arg1, nsupers, k0, k, thresh, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.psgstrf2(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, k0::int_t, k::int_t, thresh::Cdouble, arg6::Ptr{Glu_persist_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{sLocalLU_t}, arg9::Ptr{MPI_Request}, arg10::Cint, arg11::Ptr{SuperLUStat_t}, arg12::Ptr{Cint})::Cvoid
end

function sAllocLlu_3d(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sAllocLlu_3d(nsupers::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function sp3dScatter(n, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.sp3dScatter(n::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function sscatter3dLPanels(nsupers, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.sscatter3dLPanels(nsupers::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function sscatter3dUPanels(nsupers, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.sscatter3dUPanels(nsupers::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function scollect3dLpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.scollect3dLpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function scollect3dUpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.scollect3dUpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function sp3dCollect(layer, n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sp3dCollect(layer::int_t, n::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function szeroSetLU(nnodes, nodeList, arg3, arg4)
    @ccall libsuperlu_dist_Int32.szeroSetLU(nnodes::int_t, nodeList::Ptr{int_t}, arg3::Ptr{sLUstruct_t}, arg4::Ptr{gridinfo3d_t})::int_t
end

function sAllocGlu_3d(n, nsupers, arg3)
    @ccall libsuperlu_dist_Int32.sAllocGlu_3d(n::int_t, nsupers::int_t, arg3::Ptr{sLUstruct_t})::Cint
end

function sDeAllocLlu_3d(n, arg2, arg3)
    @ccall libsuperlu_dist_Int32.sDeAllocLlu_3d(n::int_t, arg2::Ptr{sLUstruct_t}, arg3::Ptr{gridinfo3d_t})::Cint
end

function sDeAllocGlu_3d(arg1)
    @ccall libsuperlu_dist_Int32.sDeAllocGlu_3d(arg1::Ptr{sLUstruct_t})::Cint
end

function sreduceAncestors3d(sender, receiver, nnodes, nodeList, Lval_buf, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.sreduceAncestors3d(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, Uval_buf::Ptr{Cfloat}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function sreduceAllAncestors3d(ilvl, myNodeCount, treePerm, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.sreduceAllAncestors3d(ilvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}}, LUvsb::Ptr{sLUValSubBuf_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cint
end

function sgatherFactoredLU(sender, receiver, nnodes, nodeList, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.sgatherFactoredLU(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, LUvsb::Ptr{sLUValSubBuf_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function sgatherAllFactoredLU(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.sgatherAllFactoredLU(trf3Dpartition::Ptr{strf3Dpartition_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function sinit3DLUstruct(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sinit3DLUstruct(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function szSendLPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.szSendLPanel(k::int_t, receiver::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function szRecvLPanel(k, sender, alpha, beta, Lval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.szRecvLPanel(k::int_t, sender::int_t, alpha::Cfloat, beta::Cfloat, Lval_buf::Ptr{Cfloat}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function szSendUPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.szSendUPanel(k::int_t, receiver::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function szRecvUPanel(k, sender, alpha, beta, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.szRecvUPanel(k::int_t, sender::int_t, alpha::Cfloat, beta::Cfloat, Uval_buf::Ptr{Cfloat}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function sIBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, arg7, ToSendR, xsup, arg10)
    @ccall libsuperlu_dist_Int32.sIBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cfloat}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg10::Cint)::int_t
end

function sBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, ToSendR, xsup, arg9, arg10)
    @ccall libsuperlu_dist_Int32.sBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cfloat}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg9::Ptr{SCT_t}, arg10::Cint)::int_t
end

function sIBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, arg7, ToSendD, arg9)
    @ccall libsuperlu_dist_Int32.sIBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendD::Ptr{Cint}, arg9::Cint)::int_t
end

function sBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, ToSendD, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, ToSendD::Ptr{Cint}, arg8::Ptr{SCT_t}, arg9::Cint)::int_t
end

function sIrecv_LPanel(k, k0, Lsub_buf, Lval_buf, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sIrecv_LPanel(k::int_t, k0::int_t, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, arg5::Ptr{gridinfo_t}, arg6::Ptr{MPI_Request}, arg7::Ptr{sLocalLU_t}, arg8::Cint)::int_t
end

function sIrecv_UPanel(k, k0, Usub_buf, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sIrecv_UPanel(k::int_t, k0::int_t, Usub_buf::Ptr{int_t}, arg4::Ptr{Cfloat}, arg5::Ptr{sLocalLU_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{MPI_Request}, arg8::Cint)::int_t
end

function sWait_URecv(arg1, msgcnt, arg3)
    @ccall libsuperlu_dist_Int32.sWait_URecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, arg3::Ptr{SCT_t})::int_t
end

function sWait_LRecv(arg1, msgcnt, msgcntsU, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sWait_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, msgcntsU::Ptr{Cint}, arg4::Ptr{gridinfo_t}, arg5::Ptr{SCT_t})::int_t
end

function sISend_UDiagBlock(k0, ublk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.sISend_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Cint)::int_t
end

function sRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, src::int_t, arg5::Ptr{gridinfo_t}, arg6::Ptr{SCT_t}, arg7::Cint)::int_t
end

function sPackLBlock(k, Dest, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sPackLBlock(k::int_t, Dest::Ptr{Cfloat}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{sLocalLU_t})::int_t
end

function sISend_LDiagBlock(k0, lblk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.sISend_LDiagBlock(k0::int_t, lblk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Cint)::int_t
end

function sIRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sIRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function sIRecv_LDiagBlock(k0, L_blk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sIRecv_LDiagBlock(k0::int_t, L_blk_ptr::Ptr{Cfloat}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function sUDiagBlockRecvWait(k, IrecvPlcd_D, factored_L, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sUDiagBlockRecvWait(k::int_t, IrecvPlcd_D::Ptr{Cint}, factored_L::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Ptr{sLUstruct_t}, arg7::Ptr{SCT_t})::int_t
end

function sIBcast_UDiagBlock(k, ublk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sIBcast_UDiagBlock(k::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function sIBcast_LDiagBlock(k, lblk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sIBcast_LDiagBlock(k::int_t, lblk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function sDiagFactIBCast(k, k0, BlockUFactor, BlockLFactor, IrecvPlcd_D, arg6, arg7, arg8, arg9, arg10, arg11, thresh, LUstruct, arg14, info, arg16, tag_ub)
    @ccall libsuperlu_dist_Int32.sDiagFactIBCast(k::int_t, k0::int_t, BlockUFactor::Ptr{Cfloat}, BlockLFactor::Ptr{Cfloat}, IrecvPlcd_D::Ptr{Cint}, arg6::Ptr{MPI_Request}, arg7::Ptr{MPI_Request}, arg8::Ptr{MPI_Request}, arg9::Ptr{MPI_Request}, arg10::Ptr{gridinfo_t}, arg11::Ptr{superlu_dist_options_t}, thresh::Cdouble, LUstruct::Ptr{sLUstruct_t}, arg14::Ptr{SuperLUStat_t}, info::Ptr{Cint}, arg16::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function sUPanelTrSolve(k, BlockLFactor, bigV, ldt, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sUPanelTrSolve(k::int_t, BlockLFactor::Ptr{Cfloat}, bigV::Ptr{Cfloat}, ldt::int_t, arg5::Ptr{Ublock_info_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{sLUstruct_t}, arg8::Ptr{SuperLUStat_t}, arg9::Ptr{SCT_t})::int_t
end

function sLPanelUpdate(k, IrecvPlcd_D, factored_L, arg4, BlockUFactor, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sLPanelUpdate(k::int_t, IrecvPlcd_D::Ptr{Cint}, factored_L::Ptr{Cint}, arg4::Ptr{MPI_Request}, BlockUFactor::Ptr{Cfloat}, arg6::Ptr{gridinfo_t}, arg7::Ptr{sLUstruct_t}, arg8::Ptr{SCT_t})::int_t
end

function sUPanelUpdate(k, factored_U, arg3, BlockLFactor, bigV, ldt, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.sUPanelUpdate(k::int_t, factored_U::Ptr{Cint}, arg3::Ptr{MPI_Request}, BlockLFactor::Ptr{Cfloat}, bigV::Ptr{Cfloat}, ldt::int_t, arg7::Ptr{Ublock_info_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{sLUstruct_t}, arg10::Ptr{SuperLUStat_t}, arg11::Ptr{SCT_t})::int_t
end

function sIBcastRecvLPanel(k, k0, msgcnt, arg4, arg5, Lsub_buf, Lval_buf, factored, arg9, arg10, arg11, tag_ub)
    @ccall libsuperlu_dist_Int32.sIBcastRecvLPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, factored::Ptr{Cint}, arg9::Ptr{gridinfo_t}, arg10::Ptr{sLUstruct_t}, arg11::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function sIBcastRecvUPanel(k, k0, msgcnt, arg4, arg5, Usub_buf, Uval_buf, arg8, arg9, arg10, tag_ub)
    @ccall libsuperlu_dist_Int32.sIBcastRecvUPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{Cfloat}, arg8::Ptr{gridinfo_t}, arg9::Ptr{sLUstruct_t}, arg10::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function sWaitL(k, msgcnt, msgcntU, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sWaitL(k::int_t, msgcnt::Ptr{Cint}, msgcntU::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{sLUstruct_t}, arg8::Ptr{SCT_t})::int_t
end

function sWaitU(k, msgcnt, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sWaitU(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{MPI_Request}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Ptr{sLUstruct_t}, arg7::Ptr{SCT_t})::int_t
end

function sLPanelTrSolve(k, factored_L, BlockUFactor, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sLPanelTrSolve(k::int_t, factored_L::Ptr{Cint}, BlockUFactor::Ptr{Cfloat}, arg4::Ptr{gridinfo_t}, arg5::Ptr{sLUstruct_t})::int_t
end

function initPackLUInfo(nsupers, packLUInfo)
    @ccall libsuperlu_dist_Int32.initPackLUInfo(nsupers::int_t, packLUInfo::Ptr{packLUInfo_t})::int_t
end

function freePackLUInfo(packLUInfo)
    @ccall libsuperlu_dist_Int32.freePackLUInfo(packLUInfo::Ptr{packLUInfo_t})::Cint
end

function sSchurComplementSetup(k, msgcnt, arg3, arg4, arg5, arg6, arg7, arg8, arg9, bigU, Lsub_buf, Lval_buf, Usub_buf, Uval_buf, arg15, arg16)
    @ccall libsuperlu_dist_Int32.sSchurComplementSetup(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{Ublock_info_t}, arg4::Ptr{Remain_info_t}, arg5::Ptr{uPanelInfo_t}, arg6::Ptr{lPanelInfo_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, bigU::Ptr{Cfloat}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{Cfloat}, arg15::Ptr{gridinfo_t}, arg16::Ptr{sLUstruct_t})::int_t
end

function sSchurComplementSetupGPU(k, msgs, arg3, arg4, arg5, arg6, arg7, arg8, arg9, LUvsb, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.sSchurComplementSetupGPU(k::int_t, msgs::Ptr{msgs_t}, arg3::Ptr{packLUInfo_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{gEtreeInfo_t}, arg8::Ptr{factNodelists_t}, arg9::Ptr{sscuBufs_t}, LUvsb::Ptr{sLUValSubBuf_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{sLUstruct_t}, arg13::Ptr{HyP_t})::int_t
end

function sgetBigV(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sgetBigV(arg1::int_t, arg2::int_t)::Ptr{Cfloat}
end

function sgetBigU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.sgetBigU(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{sLUstruct_t})::Ptr{Cfloat}
end

function sLluBufInit(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sLluBufInit(arg1::Ptr{sLUValSubBuf_t}, arg2::Ptr{sLUstruct_t})::int_t
end

function sinitScuBufs(arg1, ldt, num_threads, nsupers, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sinitScuBufs(arg1::Ptr{superlu_dist_options_t}, ldt::int_t, num_threads::int_t, nsupers::int_t, arg5::Ptr{sscuBufs_t}, arg6::Ptr{sLUstruct_t}, arg7::Ptr{gridinfo_t})::int_t
end

function sfreeScuBufs(scuBufs)
    @ccall libsuperlu_dist_Int32.sfreeScuBufs(scuBufs::Ptr{sscuBufs_t})::Cint
end

function ssparseTreeFactor(nnodes, perm_c_supno, treeTopoInfo, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, info)
    @ccall libsuperlu_dist_Int32.ssparseTreeFactor(nnodes::int_t, perm_c_supno::Ptr{int_t}, treeTopoInfo::Ptr{treeTopoInfo_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{sscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgs::Ptr{msgs_t}, LUvsb::Ptr{sLUValSubBuf_t}, dFBuf::Ptr{sdiagFactBufs_t}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, info::Ptr{Cint})::int_t
end

function sdenseTreeFactor(nnnodes, perm_c_supno, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int32.sdenseTreeFactor(nnnodes::int_t, perm_c_supno::Ptr{int_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{sscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgs::Ptr{msgs_t}, LUvsb::Ptr{sLUValSubBuf_t}, dFBuf::Ptr{sdiagFactBufs_t}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function ssparseTreeFactor_ASYNC(sforest, comReqss, scuBufs, packLUInfo, msgss, LUvsbs, dFBufs, factStat, fNlists, gEtreeInfo, options, gIperm_c_supno, ldt, HyP, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int32.ssparseTreeFactor_ASYNC(sforest::Ptr{sForest_t}, comReqss::Ptr{Ptr{commRequests_t}}, scuBufs::Ptr{sscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgss::Ptr{Ptr{msgs_t}}, LUvsbs::Ptr{Ptr{sLUValSubBuf_t}}, dFBufs::Ptr{Ptr{sdiagFactBufs_t}}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, gEtreeInfo::Ptr{gEtreeInfo_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, HyP::Ptr{HyP_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function sLluBufInitArr(numLA, LUstruct)
    @ccall libsuperlu_dist_Int32.sLluBufInitArr(numLA::int_t, LUstruct::Ptr{sLUstruct_t})::Ptr{Ptr{sLUValSubBuf_t}}
end

function sLluBufFreeArr(numLA, LUvsbs)
    @ccall libsuperlu_dist_Int32.sLluBufFreeArr(numLA::int_t, LUvsbs::Ptr{Ptr{sLUValSubBuf_t}})::Cint
end

function sinitDiagFactBufsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_dist_Int32.sinitDiagFactBufsArr(mxLeafNode::Cint, ldt::Cint, grid::Ptr{gridinfo_t})::Ptr{Ptr{sdiagFactBufs_t}}
end

function sinitDiagFactBufsArrMod(mxLeafNode, ldts, grid)
    @ccall libsuperlu_dist_Int32.sinitDiagFactBufsArrMod(mxLeafNode::Cint, ldts::Ptr{Cint}, grid::Ptr{gridinfo_t})::Ptr{Ptr{sdiagFactBufs_t}}
end

function sfreeDiagFactBufsArr(mxLeafNode, dFBufs)
    @ccall libsuperlu_dist_Int32.sfreeDiagFactBufsArr(mxLeafNode::Cint, dFBufs::Ptr{Ptr{sdiagFactBufs_t}})::Cint
end

function sinitDiagFactBufs(ldt, dFBuf)
    @ccall libsuperlu_dist_Int32.sinitDiagFactBufs(ldt::Cint, dFBuf::Ptr{sdiagFactBufs_t})::Cint
end

function checkRecvUDiag(k, comReqs, grid, SCT)
    @ccall libsuperlu_dist_Int32.checkRecvUDiag(k::int_t, comReqs::Ptr{commRequests_t}, grid::Ptr{gridinfo_t}, SCT::Ptr{SCT_t})::int_t
end

function checkRecvLDiag(k, comReqs, arg3, arg4)
    @ccall libsuperlu_dist_Int32.checkRecvLDiag(k::int_t, comReqs::Ptr{commRequests_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SCT_t})::int_t
end

function psflatten_LDATA(options, n, LUstruct, grid)
    @ccall libsuperlu_dist_Int32.psflatten_LDATA(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{sLUstruct_t}, grid::Ptr{gridinfo_t})::Cint
end

function psconvert_flatten_skyline2UROWDATA(arg1, arg2, arg3, arg4, n)
    @ccall libsuperlu_dist_Int32.psconvert_flatten_skyline2UROWDATA(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{sLUstruct_t}, arg4::Ptr{SuperLUStat_t}, n::Cint)::Cvoid
end

function psconvertUROWDATA2skyline(arg1, arg2, arg3, arg4, n)
    @ccall libsuperlu_dist_Int32.psconvertUROWDATA2skyline(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{sLUstruct_t}, arg4::Ptr{SuperLUStat_t}, n::Cint)::Cvoid
end

function sReDistribute_A(A, ScalePermstruct, Glu_freeable, xsup, supno, grid, colptr, rowind, a)
    @ccall libsuperlu_dist_Int32.sReDistribute_A(A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{sScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, xsup::Ptr{int_t}, supno::Ptr{int_t}, grid::Ptr{gridinfo_t}, colptr::Ptr{Ptr{int_t}}, rowind::Ptr{Ptr{int_t}}, a::Ptr{Ptr{Cfloat}})::int_t
end

function psdistribute3d(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.psdistribute3d(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{sScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cfloat
end

function psgssvx3d_csc_batch(arg1, batchCount, m, n, nnz, nrhs, arg7, RHSptr, ldRHS, ReqPtr, CeqPtr, RpivPtr, CpivPtr, DiagScale, F, Xptr, ldX, Berrs, grid3d, stat, info)
    @ccall libsuperlu_dist_Int32.psgssvx3d_csc_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, nnz::Cint, nrhs::Cint, arg7::Ptr{handle_t}, RHSptr::Ptr{Ptr{Cfloat}}, ldRHS::Ptr{Cint}, ReqPtr::Ptr{Ptr{Cfloat}}, CeqPtr::Ptr{Ptr{Cfloat}}, RpivPtr::Ptr{Ptr{Cint}}, CpivPtr::Ptr{Ptr{Cint}}, DiagScale::Ptr{DiagScale_t}, F::Ptr{handle_t}, Xptr::Ptr{Ptr{Cfloat}}, ldX::Ptr{Cint}, Berrs::Ptr{Ptr{Cfloat}}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cint
end

function sequil_batch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8)
    @ccall libsuperlu_dist_Int32.sequil_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cfloat}}, CeqPtr::Ptr{Ptr{Cfloat}}, arg8::Ptr{DiagScale_t})::Cint
end

function spivot_batch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, RpivPtr)
    @ccall libsuperlu_dist_Int32.spivot_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cfloat}}, CeqPtr::Ptr{Ptr{Cfloat}}, arg8::Ptr{DiagScale_t}, RpivPtr::Ptr{Ptr{Cint}})::Cint
end

function psgssvx3d_csc_vbatch(arg1, batchCount, m, n, nnz, nrhs, arg7, RHSptr, ldRHS, ReqPtr, CeqPtr, RpivPtr, CpivPtr, DiagScale, F, Xptr, ldX, Berrs, grid3d, stat, info)
    @ccall libsuperlu_dist_Int32.psgssvx3d_csc_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, nnz::Ptr{Cint}, nrhs::Cint, arg7::Ptr{handle_t}, RHSptr::Ptr{Ptr{Cfloat}}, ldRHS::Ptr{Cint}, ReqPtr::Ptr{Ptr{Cfloat}}, CeqPtr::Ptr{Ptr{Cfloat}}, RpivPtr::Ptr{Ptr{Cint}}, CpivPtr::Ptr{Ptr{Cint}}, DiagScale::Ptr{DiagScale_t}, F::Ptr{handle_t}, Xptr::Ptr{Ptr{Cfloat}}, ldX::Ptr{Cint}, Berrs::Ptr{Ptr{Cfloat}}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cint
end

function svbatch_free(F)
    @ccall libsuperlu_dist_Int32.svbatch_free(F::Ptr{handle_t})::Cvoid
end

function sequil_vbatch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, info)
    @ccall libsuperlu_dist_Int32.sequil_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cfloat}}, CeqPtr::Ptr{Ptr{Cfloat}}, arg8::Ptr{DiagScale_t}, info::Ptr{Cint})::Cint
end

function spivot_vbatch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, RpivPtr, info)
    @ccall libsuperlu_dist_Int32.spivot_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cfloat}}, CeqPtr::Ptr{Ptr{Cfloat}}, arg8::Ptr{DiagScale_t}, RpivPtr::Ptr{Ptr{Cint}}, info::Ptr{Cint})::Cint
end

function swriteLUtoDisk(nsupers, xsup, LUstruct)
    @ccall libsuperlu_dist_Int32.swriteLUtoDisk(nsupers::Cint, xsup::Ptr{int_t}, LUstruct::Ptr{sLUstruct_t})::Cint
end

function scheckArr(A, B, n)
    @ccall libsuperlu_dist_Int32.scheckArr(A::Ptr{Cfloat}, B::Ptr{Cfloat}, n::Cint)::Cint
end

function scheckLUFromDisk(nsupers, xsup, LUstruct)
    @ccall libsuperlu_dist_Int32.scheckLUFromDisk(nsupers::Cint, xsup::Ptr{int_t}, LUstruct::Ptr{sLUstruct_t})::Cint
end

function sDumpLblocks3D(nsupers, grid3d, Glu_persist, Llu)
    @ccall libsuperlu_dist_Int32.sDumpLblocks3D(nsupers::int_t, grid3d::Ptr{gridinfo3d_t}, Glu_persist::Ptr{Glu_persist_t}, Llu::Ptr{sLocalLU_t})::Cvoid
end

function sDumpUblocks3D(nsupers, grid3d, Glu_persist, Llu)
    @ccall libsuperlu_dist_Int32.sDumpUblocks3D(nsupers::int_t, grid3d::Ptr{gridinfo3d_t}, Glu_persist::Ptr{Glu_persist_t}, Llu::Ptr{sLocalLU_t})::Cvoid
end

struct dScalePermstruct_t
    DiagScale::DiagScale_t
    R::Ptr{Cdouble}
    C::Ptr{Cdouble}
    perm_r::Ptr{Cint}
    perm_c::Ptr{Cint}
    d_perm_r::Ptr{Cint}
    d_perm_c::Ptr{Cint}
    d_R::Ptr{Cdouble}
    d_C::Ptr{Cdouble}
end

struct dLocalLU_t
    Lrowind_bc_ptr::Ptr{Ptr{int_t}}
    Lrowind_bc_dat::Ptr{int_t}
    Lrowind_bc_offset::Ptr{Clong}
    Lrowind_bc_cnt::Clong
    Lnzval_bc_ptr::Ptr{Ptr{Cdouble}}
    Lnzval_bc_dat::Ptr{Cdouble}
    Lnzval_bc_offset::Ptr{Clong}
    Lnzval_bc_cnt::Clong
    Linv_bc_ptr::Ptr{Ptr{Cdouble}}
    Linv_bc_dat::Ptr{Cdouble}
    Linv_bc_offset::Ptr{Clong}
    Linv_bc_cnt::Clong
    Lindval_loc_bc_ptr::Ptr{Ptr{int_t}}
    Lindval_loc_bc_dat::Ptr{int_t}
    Lindval_loc_bc_offset::Ptr{Clong}
    Lindval_loc_bc_cnt::Clong
    Ucolind_bc_ptr::Ptr{Ptr{int_t}}
    Ucolind_bc_dat::Ptr{int_t}
    Ucolind_bc_offset::Ptr{Int64}
    Ucolind_bc_cnt::Int64
    Unzval_bc_ptr::Ptr{Ptr{Cdouble}}
    Unzval_bc_dat::Ptr{Cdouble}
    Unzval_bc_offset::Ptr{Int64}
    Unzval_bc_cnt::Int64
    Uindval_loc_bc_ptr::Ptr{Ptr{int_t}}
    Uindval_loc_bc_dat::Ptr{int_t}
    Uindval_loc_bc_offset::Ptr{Int64}
    Uindval_loc_bc_cnt::Int64
    Uind_br_ptr::Ptr{Ptr{int_t}}
    Uind_br_dat::Ptr{int_t}
    Uind_br_offset::Ptr{Int64}
    Uind_br_cnt::Int64
    Ucolind_br_ptr::Ptr{Ptr{int_t}}
    Ucolind_br_dat::Ptr{int_t}
    Ucolind_br_offset::Ptr{Int64}
    Ucolind_br_cnt::Int64
    Unzval_br_new_ptr::Ptr{Ptr{Cdouble}}
    Unzval_br_new_dat::Ptr{Cdouble}
    Unzval_br_new_offset::Ptr{Int64}
    Unzval_br_new_cnt::Int64
    Unnz::Ptr{int_t}
    Lrowind_bc_2_lsum::Ptr{Ptr{int_t}}
    Uinv_bc_ptr::Ptr{Ptr{Cdouble}}
    Uinv_bc_dat::Ptr{Cdouble}
    Uinv_bc_offset::Ptr{Clong}
    Uinv_bc_cnt::Clong
    Ufstnz_br_ptr::Ptr{Ptr{int_t}}
    Ufstnz_br_dat::Ptr{int_t}
    Ufstnz_br_offset::Ptr{Clong}
    Ufstnz_br_cnt::Clong
    Unzval_br_ptr::Ptr{Ptr{Cdouble}}
    Unzval_br_dat::Ptr{Cdouble}
    Unzval_br_offset::Ptr{Clong}
    Unzval_br_cnt::Clong
    LBtree_ptr::Ptr{C_Tree}
    LRtree_ptr::Ptr{C_Tree}
    UBtree_ptr::Ptr{C_Tree}
    URtree_ptr::Ptr{C_Tree}
    Lsub_buf_2::NTuple{50, Ptr{int_t}}
    Lval_buf_2::NTuple{50, Ptr{Cdouble}}
    Usub_buf_2::NTuple{50, Ptr{int_t}}
    Uval_buf_2::NTuple{50, Ptr{Cdouble}}
    ujrow::Ptr{Cdouble}
    bufmax::NTuple{5, int_t}
    ToRecv::Ptr{Cint}
    ToSendD::Ptr{Cint}
    ToSendR::Ptr{Ptr{Cint}}
    fmod::Ptr{Cint}
    fsendx_plist::Ptr{Ptr{Cint}}
    frecv::Ptr{Cint}
    nfrecvx::Cint
    nfsendx::Cint
    bmod::Ptr{Cint}
    bsendx_plist::Ptr{Ptr{Cint}}
    brecv::Ptr{Cint}
    nbrecvx::Cint
    nbsendx::Cint
    mod_bit::Ptr{Cint}
    nleaf::Cint
    nroot::Cint
    ilsum::Ptr{int_t}
    ldalsum::int_t
    SolveMsgSent::int_t
    SolveMsgVol::int_t
    bcols_masked::Ptr{Cint}
    UT_SOLVE::int_t
    L_SOLVE::int_t
    FRECV::int_t
    ut_ldalsum::int_t
    ut_ilsum::Ptr{int_t}
    utmod::Ptr{int_t}
    ut_sendx_plist::Ptr{Ptr{int_t}}
    utrecv::Ptr{int_t}
    n_utsendx::int_t
    n_utrecvx::int_t
    n_utrecvmod::int_t
    ut_modbit::Ptr{int_t}
    Urbs::Ptr{int_t}
    Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}
    Ucb_inddat::Ptr{Ucb_indptr_t}
    Ucb_indoffset::Ptr{Clong}
    Ucb_indcnt::Clong
    Ucb_valptr::Ptr{Ptr{int_t}}
    Ucb_valdat::Ptr{int_t}
    Ucb_valoffset::Ptr{Clong}
    Ucb_valcnt::Clong
    n::int_t
    nfrecvmod::int_t
    inv::int_t
    nbcol_masked::Cint
    d_Lrowind_bc_dat::Ptr{int_t}
    d_Lrowind_bc_offset::Ptr{Clong}
    d_Lnzval_bc_dat::Ptr{Cdouble}
    d_Lnzval_bc_offset::Ptr{Clong}
    d_Ucolind_bc_dat::Ptr{int_t}
    d_Ucolind_bc_offset::Ptr{Int64}
    d_Uind_br_dat::Ptr{int_t}
    d_Uind_br_offset::Ptr{Int64}
    d_Unzval_bc_dat::Ptr{Cdouble}
    d_Unzval_bc_offset::Ptr{Clong}
    d_Ucolind_br_dat::Ptr{int_t}
    d_Ucolind_br_offset::Ptr{Int64}
    d_Unzval_br_new_dat::Ptr{Cdouble}
    d_Unzval_br_new_offset::Ptr{Int64}
    d_Linv_bc_dat::Ptr{Cdouble}
    d_Uinv_bc_dat::Ptr{Cdouble}
    d_Linv_bc_offset::Ptr{Clong}
    d_Uinv_bc_offset::Ptr{Clong}
    d_Lindval_loc_bc_dat::Ptr{int_t}
    d_Lindval_loc_bc_offset::Ptr{Int64}
    d_Uindval_loc_bc_dat::Ptr{int_t}
    d_Uindval_loc_bc_offset::Ptr{Int64}
    d_bcols_masked::Ptr{Cint}
    d_ilsum::Ptr{int_t}
    d_xsup::Ptr{int_t}
    d_supno::Ptr{int_t}
    d_LBtree_ptr::Ptr{C_Tree}
    d_LRtree_ptr::Ptr{C_Tree}
    d_UBtree_ptr::Ptr{C_Tree}
    d_URtree_ptr::Ptr{C_Tree}
    d_grid::Ptr{gridinfo_t}
end

struct dLUValSubBuf_t
    Lsub_buf::Ptr{int_t}
    Lval_buf::Ptr{Cdouble}
    Usub_buf::Ptr{int_t}
    Uval_buf::Ptr{Cdouble}
end

struct dtrf3Dpartition_t
    nsupers::int_t
    gEtreeInfo::gEtreeInfo_t
    iperm_c_supno::Ptr{int_t}
    myNodeCount::Ptr{int_t}
    myTreeIdxs::Ptr{int_t}
    myZeroTrIdxs::Ptr{int_t}
    treePerm::Ptr{Ptr{int_t}}
    sForests::Ptr{Ptr{sForest_t}}
    supernode2treeMap::Ptr{int_t}
    supernodeMask::Ptr{Cint}
    LUvsb::Ptr{dLUValSubBuf_t}
    superGridMap::Ptr{SupernodeToGridMap_t}
    d_superGridMap::Ptr{SupernodeToGridMap_t}
    maxLvl::Cint
    mxLeafNode::Cint
    diagDims::Ptr{Cint}
    gemmCsizes::Ptr{Cint}
end

struct dLUstruct_t
    etree::Ptr{int_t}
    Glu_persist::Ptr{Glu_persist_t}
    Llu::Ptr{dLocalLU_t}
    trf3Dpart::Ptr{dtrf3Dpartition_t}
    dt::Cchar
end

struct pdgsmv_comm_t
    extern_start::Ptr{int_t}
    ind_tosend::Ptr{int_t}
    ind_torecv::Ptr{int_t}
    ptr_ind_tosend::Ptr{int_t}
    ptr_ind_torecv::Ptr{int_t}
    SendCounts::Ptr{Cint}
    RecvCounts::Ptr{Cint}
    val_tosend::Ptr{Cvoid}
    val_torecv::Ptr{Cvoid}
    TotalIndSend::int_t
    TotalValSend::int_t
end

struct dSOLVEstruct_t
    row_to_proc::Ptr{int_t}
    inv_perm_c::Ptr{Cint}
    num_diag_procs::int_t
    diag_procs::Ptr{int_t}
    diag_len::Ptr{int_t}
    gsmv_comm::Ptr{pdgsmv_comm_t}
    gstrs_comm::Ptr{pxgstrs_comm_t}
    A_colind_gsmv::Ptr{int_t}
    xrow_to_proc::Ptr{int_t}
    A3d::Ptr{NRformat_loc3d}
    d_lsum::Ptr{Cdouble}
    d_lsum_save::Ptr{Cdouble}
    d_x::Ptr{Cdouble}
    d_fmod_save::Ptr{Cint}
    d_fmod::Ptr{Cint}
    d_bmod_save::Ptr{Cint}
    d_bmod::Ptr{Cint}
    d_ptr_to_idbuf_X2B::Ptr{Cint}
    d_ptr_to_idbuf_X2B_save::Ptr{Cint}
    d_ptr_to_idbuf_B2X::Ptr{Cint}
    d_ptr_to_idbuf_B2X_save::Ptr{Cint}
    d_inv_perm_c::Ptr{Cint}
    d_ptr_to_idbuf_PermuteC::Ptr{Cint}
    d_ptr_to_idbuf_PermuteC_save::Ptr{Cint}
    d_row_to_proc::Ptr{int_t}
    d_diag_procs::Ptr{int_t}
    d_send_idbuf_B2X::Ptr{Cdouble}
    d_send_idbuf_X2B::Ptr{Cdouble}
    d_send_idbuf_PermuteC::Ptr{Cdouble}
    d_recv_idbuf_B2X::Ptr{Cdouble}
    d_recv_idbuf_X2B::Ptr{Cdouble}
    d_recv_idbuf_PermuteC::Ptr{Cdouble}
end

"""
    dvbatch_ctx_t

\\brief Persistent state for repeated batch solves that share one sparsity
 pattern.  Callers hold it only as the opaque handle F[0], see
 pdgssvx3d_csc_vbatch().

Everything here is built on the Fact = DOFACT call and reused on every
subsequent SamePattern_SameRowPerm call: the internal 1x1x1 grid, the
stacked block-diagonal matrix A_big and its CSR arrays, and the
factorization metadata (etree, perm_c of the big system, symbolic
factorization, and the distributed L/U structure).
"""
struct dvbatch_ctx_t
    initialized::Cint
    batchCount::Cint
    nrhs::Cint
    m_big::Cint
    n_big::Cint
    nnz_big::Cint
    gridalloc::Cint
    grid::gridinfo3d_t
    options_big::superlu_dist_options_t
    ScalePermstruct::dScalePermstruct_t
    LUstruct::dLUstruct_t
    SOLVEstruct::dSOLVEstruct_t
    A_big::SuperMatrix
    a_big::Ptr{Cdouble}
    colind::Ptr{int_t}
    rowptr::Ptr{int_t}
    b::Ptr{Cdouble}
    berr::Ptr{Cdouble}
end

struct dscuBufs_t
    bigU::Ptr{Cdouble}
    bigV::Ptr{Cdouble}
end

struct ddiagFactBufs_t
    BlockLFactor::Ptr{Cdouble}
    BlockUFactor::Ptr{Cdouble}
end

struct dxT_struct
    xT::Ptr{Cdouble}
    ldaspaT::int_t
    ilsumT::Ptr{int_t}
end

struct dlsumBmod_buff_t
    tX::Ptr{Cdouble}
    tU::Ptr{Cdouble}
    indCols::Ptr{int_t}
end

function dCreate_CompCol_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.dCreate_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{Cdouble}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Stype_t, arg9::Dtype_t, arg10::Mtype_t)::Cvoid
end

function dCreate_CompRowLoc_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.dCreate_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{Cdouble}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Stype_t, arg11::Dtype_t, arg12::Mtype_t)::Cvoid
end

function dCompRow_to_CompCol_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.dCompRow_to_CompCol_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{Cdouble}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{Ptr{Cdouble}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{Ptr{int_t}})::Cvoid
end

function dCompCol_to_CompRow_dist(m, n, nnz, a, colptr, rowind, at, rowptr, colind)
    @ccall libsuperlu_dist_Int32.dCompCol_to_CompRow_dist(m::int_t, n::int_t, nnz::int_t, a::Ptr{Cdouble}, colptr::Ptr{int_t}, rowind::Ptr{int_t}, at::Ptr{Ptr{Cdouble}}, rowptr::Ptr{Ptr{int_t}}, colind::Ptr{Ptr{int_t}})::Cvoid
end

function pdCompRow_loc_to_CompCol_global(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.pdCompRow_loc_to_CompCol_global(arg1::int_t, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperMatrix})::Cint
end

function dCopy_CompCol_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dCopy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function dCreate_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dCreate_Dense_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::Ptr{Cdouble}, arg5::int_t, arg6::Stype_t, arg7::Dtype_t, arg8::Mtype_t)::Cvoid
end

function dCreate_SuperNode_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.dCreate_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{Cdouble}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Stype_t, arg12::Dtype_t, arg13::Mtype_t)::Cvoid
end

function dCopy_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.dCopy_Dense_Matrix_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cdouble}, arg4::int_t, arg5::Ptr{Cdouble}, arg6::int_t)::Cvoid
end

function dallocateA_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dallocateA_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Ptr{int_t}}, arg5::Ptr{Ptr{int_t}})::Cvoid
end

function dGenXtrue_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.dGenXtrue_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cdouble}, arg4::int_t)::Cvoid
end

function dFillRHS_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dFillRHS_dist(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cdouble}, arg4::int_t, arg5::Ptr{SuperMatrix}, arg6::Ptr{Cdouble}, arg7::int_t)::Cvoid
end

function dcreate_matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dcreate_matrix(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function dcreate_matrix_rb(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dcreate_matrix_rb(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function dcreate_matrix_dat(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dcreate_matrix_dat(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function dcreate_matrix_postfix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.dcreate_matrix_postfix(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{Cchar}, arg9::Ptr{gridinfo_t})::Cint
end

function dScalePermstructInit(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.dScalePermstructInit(arg1::int_t, arg2::int_t, arg3::Ptr{dScalePermstruct_t})::Cvoid
end

function dScalePermstructFree(arg1)
    @ccall libsuperlu_dist_Int32.dScalePermstructFree(arg1::Ptr{dScalePermstruct_t})::Cvoid
end

function dgsequ_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dgsequ_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{Cint})::Cvoid
end

function dlangs_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dlangs_dist(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix})::Cdouble
end

function dlaqgs_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dlaqgs_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pdgsequ(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pdgsequ(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{Cint}, arg8::Ptr{gridinfo_t})::Cvoid
end

function pdlangs(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.pdlangs(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t})::Cdouble
end

function pdlaqgs(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pdlaqgs(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pdPermute_Dense_Matrix(arg1, arg2, arg3, perm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.pdPermute_Dense_Matrix(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, perm::Ptr{Cint}, arg5::Ptr{Cdouble}, arg6::Cint, arg7::Ptr{Cdouble}, arg8::Cint, arg9::Cint, arg10::Ptr{gridinfo_t})::Cint
end

function pdPermute_Dense_Matrix_gpu_wrap(fst_row, m_loc, n, d_X, ldx, d_B, ldb, nrhs, grid, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.pdPermute_Dense_Matrix_gpu_wrap(fst_row::int_t, m_loc::int_t, n::int_t, d_X::Ptr{Cdouble}, ldx::int_t, d_B::Ptr{Cdouble}, ldb::int_t, nrhs::Cint, grid::Ptr{gridinfo_t}, SOLVEstruct::Ptr{dSOLVEstruct_t})::Cint
end

function dundo_equilibration_rhs_wrap(B, ldb, m_loc, nrhs, fst_row, notran, rowequ, colequ, ScalePermstruct)
    @ccall libsuperlu_dist_Int32.dundo_equilibration_rhs_wrap(B::Ptr{Cdouble}, ldb::int_t, m_loc::int_t, nrhs::Cint, fst_row::int_t, notran::Cint, rowequ::Cint, colequ::Cint, ScalePermstruct::Ptr{dScalePermstruct_t})::Cvoid
end

function dscale_and_copy_rhs_wrap(B, ldb, X, ldx, m_loc, nrhs, fst_row, notran, rowequ, colequ, ScalePermstruct)
    @ccall libsuperlu_dist_Int32.dscale_and_copy_rhs_wrap(B::Ptr{Cdouble}, ldb::int_t, X::Ptr{Cdouble}, ldx::int_t, m_loc::int_t, nrhs::Cint, fst_row::int_t, notran::Cint, rowequ::Cint, colequ::Cint, ScalePermstruct::Ptr{dScalePermstruct_t})::Cvoid
end

function ddevice_matcopy_wrap(m, nrhs, dst, lddst, src, ldsrc)
    @ccall libsuperlu_dist_Int32.ddevice_matcopy_wrap(m::int_t, nrhs::Cint, dst::Ptr{Cdouble}, lddst::int_t, src::Ptr{Cdouble}, ldsrc::int_t)::Cvoid
end

function ddevice_add_to_vec_wrap(dst, src, n)
    @ccall libsuperlu_dist_Int32.ddevice_add_to_vec_wrap(dst::Ptr{Cdouble}, src::Ptr{Cdouble}, n::int_t)::Cvoid
end

function dtrs_B_init3d_zero_inactive_gpu_wrap(x, nrhs, nsupers, nlb, ilsum, xsup, superGridMap, nprow, npcol, myrow, mycol)
    @ccall libsuperlu_dist_Int32.dtrs_B_init3d_zero_inactive_gpu_wrap(x::Ptr{Cdouble}, nrhs::Cint, nsupers::int_t, nlb::int_t, ilsum::Ptr{int_t}, xsup::Ptr{int_t}, superGridMap::Ptr{SupernodeToGridMap_t}, nprow::Cint, npcol::Cint, myrow::Cint, mycol::Cint)::Cvoid
end

function dtrs_X_gather3d_pack_gpu_wrap(packbuf, x, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.dtrs_X_gather3d_pack_gpu_wrap(packbuf::Ptr{Cdouble}, x::Ptr{Cdouble}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function dtrs_X_gather3d_unpack_gpu_wrap(x, packbuf, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.dtrs_X_gather3d_unpack_gpu_wrap(x::Ptr{Cdouble}, packbuf::Ptr{Cdouble}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function dtrs_X_gather3d_pack_zero_gpu_wrap(packbuf, x, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.dtrs_X_gather3d_pack_zero_gpu_wrap(packbuf::Ptr{Cdouble}, x::Ptr{Cdouble}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function dtrs_X_gather3d_unpack_add_gpu_wrap(x, packbuf, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.dtrs_X_gather3d_unpack_add_gpu_wrap(x::Ptr{Cdouble}, packbuf::Ptr{Cdouble}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function dSolveInit_nvshmem_gpures(options, fst_row, m_loc, nrhs, n, grid, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.dSolveInit_nvshmem_gpures(options::Ptr{superlu_dist_options_t}, fst_row::int_t, m_loc::int_t, nrhs::int_t, n::int_t, grid::Ptr{gridinfo_t}, SOLVEstruct::Ptr{dSOLVEstruct_t})::Cint
end

function dFree_nvshmem_gpures(options, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.dFree_nvshmem_gpures(options::Ptr{superlu_dist_options_t}, SOLVEstruct::Ptr{dSOLVEstruct_t})::Cvoid
end

function sp_dtrsv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sp_dtrsv_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cchar}, arg3::Ptr{Cchar}, arg4::Ptr{SuperMatrix}, arg5::Ptr{SuperMatrix}, arg6::Ptr{Cdouble}, arg7::Ptr{Cint})::Cint
end

function sp_dgemv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sp_dgemv_dist(arg1::Ptr{Cchar}, arg2::Cdouble, arg3::Ptr{SuperMatrix}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cdouble, arg7::Ptr{Cdouble}, arg8::Cint)::Cint
end

function sp_dgemm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sp_dgemm_dist(arg1::Ptr{Cchar}, arg2::Cint, arg3::Cdouble, arg4::Ptr{SuperMatrix}, arg5::Ptr{Cdouble}, arg6::Cint, arg7::Cdouble, arg8::Ptr{Cdouble}, arg9::Cint)::Cint
end

function ddistribute(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.ddistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{Glu_freeable_t}, arg5::Ptr{dLUstruct_t}, arg6::Ptr{gridinfo_t})::Cfloat
end

function pdgssvx_ABglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.pdgssvx_ABglobal(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{dScalePermstruct_t}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t}, arg8::Ptr{dLUstruct_t}, arg9::Ptr{Cdouble}, arg10::Ptr{SuperLUStat_t}, arg11::Ptr{Cint})::Cvoid
end

function pddistribute(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pddistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{dScalePermstruct_t}, arg5::Ptr{Glu_freeable_t}, arg6::Ptr{dLUstruct_t}, arg7::Ptr{gridinfo_t})::Cfloat
end

function pddistribute_allgrid(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid, supernodeMask)
    @ccall libsuperlu_dist_Int32.pddistribute_allgrid(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{dScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{dLUstruct_t}, grid::Ptr{gridinfo_t}, supernodeMask::Ptr{Cint})::Cfloat
end

function pddistribute_allgrid_index_only(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid, supernodeMask)
    @ccall libsuperlu_dist_Int32.pddistribute_allgrid_index_only(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{dScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{dLUstruct_t}, grid::Ptr{gridinfo_t}, supernodeMask::Ptr{Cint})::Cfloat
end

function pdgssvx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.pdgssvx(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{dScalePermstruct_t}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t}, arg8::Ptr{dLUstruct_t}, arg9::Ptr{dSOLVEstruct_t}, arg10::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t}, arg12::Ptr{Cint})::Cvoid
end

function pdCompute_Diag_Inv(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.pdCompute_Diag_Inv(arg1::int_t, arg2::Ptr{dLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{Cint})::Cvoid
end

function dSolveInit(arg1, arg2, perm_r, perm_c, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.dSolveInit(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, perm_r::Ptr{Cint}, perm_c::Ptr{Cint}, arg5::int_t, arg6::int_t, arg7::Ptr{dLUstruct_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{dSOLVEstruct_t}, arg10::Ptr{dScalePermstruct_t})::Cint
end

function dSolveFinalize(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dSolveFinalize(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{dSOLVEstruct_t})::Cvoid
end

function dDestroy_A3d_gathered_on_2d(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dDestroy_A3d_gathered_on_2d(arg1::Ptr{dSOLVEstruct_t}, arg2::Ptr{gridinfo3d_t})::Cvoid
end

function pdgstrs_init(arg1, arg2, arg3, arg4, perm_r, perm_c, grid, arg8, arg9)
    @ccall libsuperlu_dist_Int32.pdgstrs_init(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, perm_r::Ptr{Cint}, perm_c::Ptr{Cint}, grid::Ptr{gridinfo_t}, arg8::Ptr{Glu_persist_t}, arg9::Ptr{dSOLVEstruct_t})::int_t
end

function pdgstrs_init_device_lsum_x(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pdgstrs_init_device_lsum_x(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{gridinfo_t}, arg6::Ptr{dLUstruct_t}, arg7::Ptr{dSOLVEstruct_t}, arg8::Ptr{Cint})::int_t
end

function pdgstrs_delete_device_lsum_x(arg1)
    @ccall libsuperlu_dist_Int32.pdgstrs_delete_device_lsum_x(arg1::Ptr{dSOLVEstruct_t})::int_t
end

function dldperm_dist(arg1, arg2, arg3, arg4, arg5, arg6, perm, arg8, arg9)
    @ccall libsuperlu_dist_Int32.dldperm_dist(arg1::Cint, arg2::Cint, arg3::int_t, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Cdouble}, perm::Ptr{Cint}, arg8::Ptr{Cdouble}, arg9::Ptr{Cdouble})::Cint
end

function dstatic_schedule(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.dstatic_schedule(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{dLUstruct_t}, arg5::Ptr{gridinfo_t}, arg6::Ptr{SuperLUStat_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Cint})::Cint
end

function dLUstructInit(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dLUstructInit(arg1::int_t, arg2::Ptr{dLUstruct_t})::Cvoid
end

function dLUstructFree(arg1)
    @ccall libsuperlu_dist_Int32.dLUstructFree(arg1::Ptr{dLUstruct_t})::Cvoid
end

function dDestroy_LU(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.dDestroy_LU(arg1::int_t, arg2::Ptr{gridinfo_t}, arg3::Ptr{dLUstruct_t})::Cvoid
end

function dDestroy_Tree(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.dDestroy_Tree(arg1::int_t, arg2::Ptr{gridinfo_t}, arg3::Ptr{dLUstruct_t})::Cvoid
end

function dscatter_l(ib, ljb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, usub, lsub, tempv, indirect_thread, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, grid)
    @ccall libsuperlu_dist_Int32.dscatter_l(ib::Cint, ljb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, usub::Ptr{int_t}, lsub::Ptr{int_t}, tempv::Ptr{Cdouble}, indirect_thread::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{Cdouble}}, grid::Ptr{gridinfo_t})::Cvoid
end

function dscatter_u(ib, jb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, lsub, usub, tempv, Ufstnz_br_ptr, Unzval_br_ptr, grid)
    @ccall libsuperlu_dist_Int32.dscatter_u(ib::Cint, jb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, lsub::Ptr{int_t}, usub::Ptr{int_t}, tempv::Ptr{Cdouble}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{Cdouble}}, grid::Ptr{gridinfo_t})::Cvoid
end

function pdgstrf(arg1, arg2, arg3, anorm, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pdgstrf(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, anorm::Cdouble, arg5::Ptr{dLUstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SuperLUStat_t}, arg8::Ptr{Cint})::int_t
end

function pdgstrs_Bglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.pdgstrs_Bglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{dLUstruct_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{Cdouble}, arg6::int_t, arg7::Cint, arg8::Ptr{SuperLUStat_t}, arg9::Ptr{Cint})::Cvoid
end

function pdgstrs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.pdgstrs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{dLUstruct_t}, arg4::Ptr{dScalePermstruct_t}, arg5::Ptr{gridinfo_t}, arg6::Ptr{Cdouble}, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Cint, arg11::Ptr{dSOLVEstruct_t}, arg12::Ptr{SuperLUStat_t}, arg13::Ptr{Cint})::Cvoid
end

function pdgstrf2_trsm(options, k0, k, thresh, arg5, arg6, arg7, arg8, tag_ub, arg10, info)
    @ccall libsuperlu_dist_Int32.pdgstrf2_trsm(options::Ptr{superlu_dist_options_t}, k0::int_t, k::int_t, thresh::Cdouble, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{dLocalLU_t}, arg8::Ptr{MPI_Request}, tag_ub::Cint, arg10::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pdgstrs2_omp(k0, k, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pdgstrs2_omp(k0::int_t, k::int_t, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{dLocalLU_t}, arg6::Ptr{Ublock_info_t}, arg7::Ptr{SuperLUStat_t})::Cvoid
end

function pdReDistribute_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.pdReDistribute_B_to_X(B::Ptr{Cdouble}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{Cdouble}, arg8::Ptr{dScalePermstruct_t}, arg9::Ptr{Glu_persist_t}, arg10::Ptr{gridinfo_t}, arg11::Ptr{dSOLVEstruct_t})::int_t
end

function dlsum_fmod(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.dlsum_fmod(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::int_t, arg11::int_t, arg12::Ptr{int_t}, arg13::Ptr{gridinfo_t}, arg14::Ptr{dLocalLU_t}, arg15::Ptr{MPI_Request}, arg16::Ptr{SuperLUStat_t})::Cvoid
end

function dlsum_bmod(arg1, arg2, arg3, arg4, arg5, bmod, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int32.dlsum_bmod(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cint, arg5::int_t, bmod::Ptr{Cint}, arg7::Ptr{int_t}, arg8::Ptr{Ptr{Ucb_indptr_t}}, arg9::Ptr{Ptr{int_t}}, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{dLocalLU_t}, arg13::Ptr{MPI_Request}, arg14::Ptr{SuperLUStat_t})::Cvoid
end

function dlsum_fmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, fmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int32.dlsum_fmod_inv(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::int_t, fmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{gridinfo_t}, arg10::Ptr{dLocalLU_t}, arg11::Ptr{Ptr{SuperLUStat_t}}, arg12::Ptr{int_t}, arg13::Ptr{int_t}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function dlsum_fmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int32.dlsum_fmod_inv_master(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{dLocalLU_t}, arg13::Ptr{Ptr{SuperLUStat_t}}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function dlsum_bmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    @ccall libsuperlu_dist_Int32.dlsum_bmod_inv(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{dLocalLU_t}, arg14::Ptr{Ptr{SuperLUStat_t}}, arg15::Ptr{int_t}, arg16::Ptr{int_t}, arg17::int_t, arg18::int_t, arg19::Cint, arg20::Cint)::Cvoid
end

function dlsum_bmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    @ccall libsuperlu_dist_Int32.dlsum_bmod_inv_master(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{dLocalLU_t}, arg14::Ptr{Ptr{SuperLUStat_t}}, arg15::int_t, arg16::int_t, arg17::Cint, arg18::Cint)::Cvoid
end

function dComputeLevelsets(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.dComputeLevelsets(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t}, arg6::Ptr{int_t})::Cvoid
end

function pdconvertU(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.pdconvertU(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{dLUstruct_t}, arg4::Ptr{SuperLUStat_t}, arg5::Cint)::Cvoid
end

function dlsum_fmod_inv_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, fmod, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48)
    @ccall libsuperlu_dist_Int32.dlsum_fmod_inv_gpu_wrap(arg1::Cint, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Cint, arg8::Cint, arg9::int_t, fmod::Ptr{Cint}, arg11::Ptr{C_Tree}, arg12::Ptr{C_Tree}, arg13::Ptr{int_t}, arg14::Ptr{int_t}, arg15::Ptr{Int64}, arg16::Ptr{Cdouble}, arg17::Ptr{Int64}, arg18::Ptr{Cdouble}, arg19::Ptr{Int64}, arg20::Ptr{int_t}, arg21::Ptr{Int64}, arg22::Ptr{int_t}, arg23::Ptr{Cint}, arg24::Ptr{gridinfo_t}, arg25::int_t, arg26::Ptr{UInt64}, arg27::Ptr{UInt64}, arg28::Ptr{Cdouble}, arg29::Ptr{Cdouble}, arg30::Ptr{Cint}, arg31::Ptr{Cint}, arg32::Ptr{Cint}, arg33::Ptr{Cint}, arg34::Ptr{Cint}, arg35::Ptr{Cint}, arg36::Ptr{Cint}, arg37::Ptr{Cint}, arg38::Ptr{Cint}, arg39::Ptr{Cint}, arg40::Ptr{Cint}, arg41::Ptr{Cint}, arg42::Ptr{Cint}, arg43::Ptr{Cint}, arg44::Ptr{Cint}, arg45::Ptr{Cint}, arg46::Ptr{Cint}, arg47::Ptr{Cint}, arg48::Cint)::Cvoid
end

function dlsum_bmod_inv_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50, arg51, arg52, arg53, arg54)
    @ccall libsuperlu_dist_Int32.dlsum_bmod_inv_gpu_wrap(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Cint, arg6::Ptr{Cdouble}, arg7::Ptr{Cdouble}, arg8::Cint, arg9::Cint, arg10::int_t, arg11::Ptr{Cint}, arg12::Ptr{C_Tree}, arg13::Ptr{C_Tree}, arg14::Ptr{int_t}, arg15::Ptr{int_t}, arg16::Ptr{Int64}, arg17::Ptr{int_t}, arg18::Ptr{Int64}, arg19::Ptr{int_t}, arg20::Ptr{Int64}, arg21::Ptr{Cdouble}, arg22::Ptr{Int64}, arg23::Ptr{Cdouble}, arg24::Ptr{Int64}, arg25::Ptr{Cdouble}, arg26::Ptr{Int64}, arg27::Ptr{int_t}, arg28::Ptr{Int64}, arg29::Ptr{int_t}, arg30::Ptr{gridinfo_t}, arg31::int_t, arg32::Ptr{UInt64}, arg33::Ptr{UInt64}, arg34::Ptr{Cdouble}, arg35::Ptr{Cdouble}, arg36::Ptr{Cint}, arg37::Ptr{Cint}, arg38::Ptr{Cint}, arg39::Ptr{Cint}, arg40::Ptr{Cint}, arg41::Ptr{Cint}, arg42::Ptr{Cint}, arg43::Ptr{Cint}, arg44::Ptr{Cint}, arg45::Ptr{Cint}, arg46::Ptr{Cint}, arg47::Ptr{Cint}, arg48::Ptr{Cint}, arg49::Ptr{Cint}, arg50::Ptr{Cint}, arg51::Ptr{Cint}, arg52::Ptr{Cint}, arg53::Ptr{Cint}, arg54::Cint)::Cvoid
end

function pdReDistribute_B_to_X_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    @ccall libsuperlu_dist_Int32.pdReDistribute_B_to_X_gpu_wrap(arg1::Ptr{Cdouble}, arg2::int_t, arg3::int_t, arg4::Cint, arg5::int_t, arg6::int_t, arg7::Ptr{Cdouble}, arg8::Ptr{dScalePermstruct_t}, arg9::Ptr{dSOLVEstruct_t}, arg10::Ptr{Glu_persist_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{int_t}, arg14::Ptr{int_t}, arg15::Ptr{int_t})::Cvoid
end

function pdReDistribute_X_to_B_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.pdReDistribute_X_to_B_gpu_wrap(arg1::Ptr{Cdouble}, arg2::int_t, arg3::int_t, arg4::Cint, arg5::int_t, arg6::int_t, arg7::int_t, arg8::Ptr{Cdouble}, arg9::Ptr{dScalePermstruct_t}, arg10::Ptr{dSOLVEstruct_t}, arg11::Ptr{Glu_persist_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{gridinfo_t}, arg14::Ptr{int_t}, arg15::Ptr{int_t}, arg16::Ptr{int_t})::Cvoid
end

function pdgsrfs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.pdgsrfs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cdouble, arg5::Ptr{dLUstruct_t}, arg6::Ptr{dScalePermstruct_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{Cdouble}, arg9::int_t, arg10::Ptr{Cdouble}, arg11::int_t, arg12::Cint, arg13::Ptr{dSOLVEstruct_t}, arg14::Ptr{Cdouble}, arg15::Ptr{SuperLUStat_t}, arg16::Ptr{Cint})::Cvoid
end

function pdgsrfs3d(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
    @ccall libsuperlu_dist_Int32.pdgsrfs3d(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cdouble, arg5::Ptr{dLUstruct_t}, arg6::Ptr{dScalePermstruct_t}, arg7::Ptr{gridinfo3d_t}, arg8::Ptr{dtrf3Dpartition_t}, arg9::Ptr{Cdouble}, arg10::int_t, arg11::Ptr{Cdouble}, arg12::int_t, arg13::Cint, arg14::Ptr{dSOLVEstruct_t}, arg15::Ptr{Cdouble}, arg16::Ptr{SuperLUStat_t}, arg17::Ptr{Cint})::Cvoid
end

function pdgmres(arg1, arg2, arg3, arg4, arg5, arg6, arg7, X, m_loc, fst_row, restart, maxit, rtol, atol, gs, arg16, totit, arg18, arg19)
    @ccall libsuperlu_dist_Int32.pdgmres(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{dLUstruct_t}, arg5::Ptr{dScalePermstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{pdgsmv_comm_t}, X::Ptr{Cdouble}, m_loc::int_t, fst_row::int_t, restart::Cint, maxit::Cint, rtol::Cdouble, atol::Cdouble, gs::Cint, arg16::Ptr{dSOLVEstruct_t}, totit::Ptr{Cint}, arg18::Ptr{SuperLUStat_t}, arg19::Ptr{Cint})::Cvoid
end

function pdgmres3d(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, X, m_loc, fst_row, restart, maxit, rtol, atol, gs, arg17, totit, arg19, arg20)
    @ccall libsuperlu_dist_Int32.pdgmres3d(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{dLUstruct_t}, arg5::Ptr{dScalePermstruct_t}, arg6::Ptr{gridinfo3d_t}, arg7::Ptr{dtrf3Dpartition_t}, arg8::Ptr{pdgsmv_comm_t}, X::Ptr{Cdouble}, m_loc::int_t, fst_row::int_t, restart::Cint, maxit::Cint, rtol::Cdouble, atol::Cdouble, gs::Cint, arg17::Ptr{dSOLVEstruct_t}, totit::Ptr{Cint}, arg19::Ptr{SuperLUStat_t}, arg20::Ptr{Cint})::Cvoid
end

function pdgsrfs_ABXglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int32.pdgsrfs_ABXglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cdouble, arg5::Ptr{dLUstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{Cdouble}, arg8::int_t, arg9::Ptr{Cdouble}, arg10::int_t, arg11::Cint, arg12::Ptr{Cdouble}, arg13::Ptr{SuperLUStat_t}, arg14::Ptr{Cint})::Cvoid
end

function pdgsmv_AXglobal_setup(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pdgsmv_AXglobal_setup(arg1::Ptr{SuperMatrix}, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{int_t})::Cint
end

function pdgsmv_AXglobal(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.pdgsmv_AXglobal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Cdouble}, arg4::Ptr{int_t}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble})::Cint
end

function pdgsmv_AXglobal_abs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.pdgsmv_AXglobal_abs(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Cdouble}, arg4::Ptr{int_t}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble})::Cint
end

function pdgsmv_init(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.pdgsmv_init(arg1::Ptr{SuperMatrix}, arg2::Ptr{int_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{pdgsmv_comm_t})::Cvoid
end

function pdgsmv(arg1, arg2, arg3, arg4, x, ax)
    @ccall libsuperlu_dist_Int32.pdgsmv(arg1::int_t, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t}, arg4::Ptr{pdgsmv_comm_t}, x::Ptr{Cdouble}, ax::Ptr{Cdouble})::Cvoid
end

function pdgsmv_finalize(arg1)
    @ccall libsuperlu_dist_Int32.pdgsmv_finalize(arg1::Ptr{pdgsmv_comm_t})::Cvoid
end

function dinitLsumBmod_buff(ns, nrhs, lbmod_buf)
    @ccall libsuperlu_dist_Int32.dinitLsumBmod_buff(ns::int_t, nrhs::Cint, lbmod_buf::Ptr{dlsumBmod_buff_t})::int_t
end

function dleafForestBackSolve3d(options, treeId, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, recvbuf, send_req, nrhs, lbmod_buf, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dleafForestBackSolve3d(options::Ptr{superlu_dist_options_t}, treeId::int_t, n::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{Cdouble}, lsum::Ptr{Cdouble}, recvbuf::Ptr{Cdouble}, send_req::Ptr{MPI_Request}, nrhs::Cint, lbmod_buf::Ptr{dlsumBmod_buff_t}, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dnonLeafForestBackSolve3d(treeId, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, xT_s, recvbuf, send_req, nrhs, lbmod_buf, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dnonLeafForestBackSolve3d(treeId::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{Cdouble}, lsum::Ptr{Cdouble}, xT_s::Ptr{dxT_struct}, recvbuf::Ptr{Cdouble}, send_req::Ptr{MPI_Request}, nrhs::Cint, lbmod_buf::Ptr{dlsumBmod_buff_t}, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dlasum_bmod_Tree(pTree, cTree, lsum, x, xT_s, nrhs, lbmod_buf, LUstruct, trf3Dpartition, grid3d, stat)
    @ccall libsuperlu_dist_Int32.dlasum_bmod_Tree(pTree::int_t, cTree::int_t, lsum::Ptr{Cdouble}, x::Ptr{Cdouble}, xT_s::Ptr{dxT_struct}, nrhs::Cint, lbmod_buf::Ptr{dlsumBmod_buff_t}, LUstruct::Ptr{dLUstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function dlsumForestBsolve(k, treeId, lsum, x, xT_s, nrhs, lbmod_buf, LUstruct, trf3Dpartition, grid3d, stat)
    @ccall libsuperlu_dist_Int32.dlsumForestBsolve(k::int_t, treeId::int_t, lsum::Ptr{Cdouble}, x::Ptr{Cdouble}, xT_s::Ptr{dxT_struct}, nrhs::Cint, lbmod_buf::Ptr{dlsumBmod_buff_t}, LUstruct::Ptr{dLUstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function dbCastXk2Pck(k, xT_s, nrhs, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dbCastXk2Pck(k::int_t, xT_s::Ptr{dxT_struct}, nrhs::Cint, LUstruct::Ptr{dLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dlsumReducePrK(k, x, lsum, recvbuf, nrhs, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dlsumReducePrK(k::int_t, x::Ptr{Cdouble}, lsum::Ptr{Cdouble}, recvbuf::Ptr{Cdouble}, nrhs::Cint, LUstruct::Ptr{dLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dnonLeafForestForwardSolve3d(treeId, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, xT_s, recvbuf, rtemp, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dnonLeafForestForwardSolve3d(treeId::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{Cdouble}, lsum::Ptr{Cdouble}, xT_s::Ptr{dxT_struct}, recvbuf::Ptr{Cdouble}, rtemp::Ptr{Cdouble}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dleafForestForwardSolve3d(options, treeId, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, recvbuf, rtemp, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dleafForestForwardSolve3d(options::Ptr{superlu_dist_options_t}, treeId::int_t, n::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{Cdouble}, lsum::Ptr{Cdouble}, recvbuf::Ptr{Cdouble}, rtemp::Ptr{Cdouble}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dtrs_compute_communication_structure(options, n, LUstruct, supernodeMask, grid)
    @ccall libsuperlu_dist_Int32.dtrs_compute_communication_structure(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{dLUstruct_t}, supernodeMask::Ptr{Cint}, grid::Ptr{gridinfo_t})::Cint
end

function dreduceSolvedX_newsolve(options, treeId, sender, receiver, x, nrhs, trf3Dpartition, LUstruct, grid3d, recvbuf, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dreduceSolvedX_newsolve(options::Ptr{superlu_dist_options_t}, treeId::int_t, sender::int_t, receiver::int_t, x::Ptr{Cdouble}, nrhs::Cint, trf3Dpartition::Ptr{dtrf3Dpartition_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, recvbuf::Ptr{Cdouble}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dlsum_fmod_leaf(treeId, trf3Dpartition, lsum, x, xk, rtemp, nrhs, knsupc, k, fmod, nlb, lptr, luptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dlsum_fmod_leaf(treeId::int_t, trf3Dpartition::Ptr{dtrf3Dpartition_t}, lsum::Ptr{Cdouble}, x::Ptr{Cdouble}, xk::Ptr{Cdouble}, rtemp::Ptr{Cdouble}, nrhs::Cint, knsupc::Cint, k::int_t, fmod::Ptr{Cint}, nlb::int_t, lptr::int_t, luptr::int_t, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{dLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function dlsum_fmod_leaf_newsolve(trf3Dpartition, lsum, x, xk, rtemp, nrhs, knsupc, k, fmod, nlb, lptr, luptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dlsum_fmod_leaf_newsolve(trf3Dpartition::Ptr{dtrf3Dpartition_t}, lsum::Ptr{Cdouble}, x::Ptr{Cdouble}, xk::Ptr{Cdouble}, rtemp::Ptr{Cdouble}, nrhs::Cint, knsupc::Cint, k::int_t, fmod::Ptr{Cint}, nlb::int_t, lptr::int_t, luptr::int_t, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{dLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function dlsum_bmod_GG(lsum, x, xk, nrhs, lbmod_buf, k, bmod, Urbs, Ucb_indptr, Ucb_valptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dlsum_bmod_GG(lsum::Ptr{Cdouble}, x::Ptr{Cdouble}, xk::Ptr{Cdouble}, nrhs::Cint, lbmod_buf::Ptr{dlsumBmod_buff_t}, k::int_t, bmod::Ptr{Cint}, Urbs::Ptr{int_t}, Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}, Ucb_valptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{dLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function dlsum_bmod_GG_newsolve(trf3Dpartition, lsum, x, xk, nrhs, lbmod_buf, k, bmod, Urbs, Ucb_indptr, Ucb_valptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dlsum_bmod_GG_newsolve(trf3Dpartition::Ptr{dtrf3Dpartition_t}, lsum::Ptr{Cdouble}, x::Ptr{Cdouble}, xk::Ptr{Cdouble}, nrhs::Cint, lbmod_buf::Ptr{dlsumBmod_buff_t}, k::int_t, bmod::Ptr{Cint}, Urbs::Ptr{int_t}, Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}, Ucb_valptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{dLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function pdReDistribute3d_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, ScalePermstruct, Glu_persist, grid3d, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.pdReDistribute3d_B_to_X(B::Ptr{Cdouble}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{Cdouble}, ScalePermstruct::Ptr{dScalePermstruct_t}, Glu_persist::Ptr{Glu_persist_t}, grid3d::Ptr{gridinfo3d_t}, SOLVEstruct::Ptr{dSOLVEstruct_t})::int_t
end

function pdReDistribute3d_X_to_B(n, B, m_loc, ldb, fst_row, nrhs, x, ilsum, ScalePermstruct, Glu_persist, grid3d, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.pdReDistribute3d_X_to_B(n::int_t, B::Ptr{Cdouble}, m_loc::int_t, ldb::int_t, fst_row::int_t, nrhs::Cint, x::Ptr{Cdouble}, ilsum::Ptr{int_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, Glu_persist::Ptr{Glu_persist_t}, grid3d::Ptr{gridinfo3d_t}, SOLVEstruct::Ptr{dSOLVEstruct_t})::int_t
end

function pdgstrs3d(arg1, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, B, m_loc, fst_row, ldb, nrhs, SOLVEstruct, stat, info)
    @ccall libsuperlu_dist_Int32.pdgstrs3d(arg1::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, B::Ptr{Cdouble}, m_loc::int_t, fst_row::int_t, ldb::int_t, nrhs::Cint, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pdgstrs3d_newsolve(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, B, m_loc, fst_row, ldb, nrhs, SOLVEstruct, stat, info)
    @ccall libsuperlu_dist_Int32.pdgstrs3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, B::Ptr{Cdouble}, m_loc::int_t, fst_row::int_t, ldb::int_t, nrhs::Cint, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pdgsTrBackSolve3d(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, xT_s, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.pdgsTrBackSolve3d(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{Cdouble}, lsum3d::Ptr{Cdouble}, xT_s::Ptr{dxT_struct}, recvbuf::Ptr{Cdouble}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function pdgsTrForwardSolve3d(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, xT_s, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.pdgsTrForwardSolve3d(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{Cdouble}, lsum3d::Ptr{Cdouble}, xT_s::Ptr{dxT_struct}, recvbuf::Ptr{Cdouble}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function pdgsTrForwardSolve3d_newsolve(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.pdgsTrForwardSolve3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{dLUstruct_t}, ScalePermstruct::Ptr{dScalePermstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{Cdouble}, lsum3d::Ptr{Cdouble}, recvbuf::Ptr{Cdouble}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function pdgsTrBackSolve3d_newsolve(options, n, LUstruct, trf3Dpartition, grid3d, x3d, lsum3d, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.pdgsTrBackSolve3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{dLUstruct_t}, trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{Cdouble}, lsum3d::Ptr{Cdouble}, recvbuf::Ptr{Cdouble}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{dSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dbroadcastAncestor3d(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dbroadcastAncestor3d(trf3Dpartition::Ptr{dtrf3Dpartition_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dlocalSolveXkYk(trtype, k, x, nrhs, LUstruct, grid, stat)
    @ccall libsuperlu_dist_Int32.dlocalSolveXkYk(trtype::trtype_t, k::int_t, x::Ptr{Cdouble}, nrhs::Cint, LUstruct::Ptr{dLUstruct_t}, grid::Ptr{gridinfo_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function diBcastXk2Pck(k, x, nrhs, sendList, send_req, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.diBcastXk2Pck(k::int_t, x::Ptr{Cdouble}, nrhs::Cint, sendList::Ptr{Ptr{Cint}}, send_req::Ptr{MPI_Request}, LUstruct::Ptr{dLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dtrs_B_init3d(nsupers, x, nrhs, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dtrs_B_init3d(nsupers::int_t, x::Ptr{Cdouble}, nrhs::Cint, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function dtrs_X_gather3d(options, x, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dtrs_X_gather3d(options::Ptr{superlu_dist_options_t}, x::Ptr{Cdouble}, nrhs::Cint, trf3Dpartition::Ptr{dtrf3Dpartition_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dfsolveReduceLsum3d(treeId, sender, receiver, lsum, recvbuf, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dfsolveReduceLsum3d(treeId::int_t, sender::int_t, receiver::int_t, lsum::Ptr{Cdouble}, recvbuf::Ptr{Cdouble}, nrhs::Cint, trf3Dpartition::Ptr{dtrf3Dpartition_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dbsolve_Xt_bcast(ilvl, xT_s, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dbsolve_Xt_bcast(ilvl::int_t, xT_s::Ptr{dxT_struct}, nrhs::Cint, trf3Dpartition::Ptr{dtrf3Dpartition_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function dp2pSolvedX3d(treeId, sender, receiver, x, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.dp2pSolvedX3d(treeId::int_t, sender::int_t, receiver::int_t, x::Ptr{Cdouble}, nrhs::Cint, trf3Dpartition::Ptr{dtrf3Dpartition_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function doubleMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.doubleMalloc_dist(arg1::int_t)::Ptr{Cdouble}
end

function doubleCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.doubleCalloc_dist(arg1::int_t)::Ptr{Cdouble}
end

function duser_malloc_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.duser_malloc_dist(arg1::int_t, arg2::int_t)::Ptr{Cvoid}
end

function duser_free_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.duser_free_dist(arg1::int_t, arg2::int_t)::Cvoid
end

function dQuerySpace_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dQuerySpace_dist(arg1::int_t, arg2::Ptr{dLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{superlu_dist_mem_usage_t})::int_t
end

function dClone_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dClone_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function dCopy_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dCopy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function dZero_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.dZero_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function dScaleAddId_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dScaleAddId_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Cdouble)::Cvoid
end

function dScaleAdd_CompRowLoc_Matrix_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.dScaleAdd_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix}, arg3::Cdouble)::Cvoid
end

function dZeroLblocks(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.dZeroLblocks(arg1::Cint, arg2::Cint, arg3::Ptr{gridinfo_t}, arg4::Ptr{dLUstruct_t})::Cvoid
end

function dZeroUblocks(iam, n, arg3, arg4)
    @ccall libsuperlu_dist_Int32.dZeroUblocks(iam::Cint, n::Cint, arg3::Ptr{gridinfo_t}, arg4::Ptr{dLUstruct_t})::Cvoid
end

function dMaxAbsLij(iam, n, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dMaxAbsLij(iam::Cint, n::Cint, arg3::Ptr{Glu_persist_t}, arg4::Ptr{dLUstruct_t}, arg5::Ptr{gridinfo_t})::Cdouble
end

function dMaxAbsUij(iam, n, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dMaxAbsUij(iam::Cint, n::Cint, arg3::Ptr{Glu_persist_t}, arg4::Ptr{dLUstruct_t}, arg5::Ptr{gridinfo_t})::Cdouble
end

function dfill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.dfill_dist(arg1::Ptr{Cdouble}, arg2::int_t, arg3::Cdouble)::Cvoid
end

function dinf_norm_error_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dinf_norm_error_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cdouble}, arg4::int_t, arg5::Ptr{Cdouble}, arg6::int_t, arg7::Ptr{gridinfo_t})::Cvoid
end

function pdinf_norm_error(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pdinf_norm_error(arg1::Cint, arg2::int_t, arg3::int_t, arg4::Ptr{Cdouble}, arg5::int_t, arg6::Ptr{Cdouble}, arg7::int_t, arg8::MPI_Comm)::Cvoid
end

function dreadhb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dreadhb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function dreadtriple_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dreadtriple_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function dreadtriple_noheader(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dreadtriple_noheader(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function dreadrb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dreadrb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function dreadMM_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dreadMM_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function dread_binary(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dread_binary(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cint
end

function dwrite_binary_withname(n, nnz, values, rowind, colptr, newfile)
    @ccall libsuperlu_dist_Int32.dwrite_binary_withname(n::int_t, nnz::int_t, values::Ptr{Cdouble}, rowind::Ptr{int_t}, colptr::Ptr{int_t}, newfile::Ptr{Cchar})::Cint
end

function validateInput_pdgssvx3d(arg1, A, ldb, nrhs, arg5, info)
    @ccall libsuperlu_dist_Int32.validateInput_pdgssvx3d(arg1::Ptr{superlu_dist_options_t}, A::Ptr{SuperMatrix}, ldb::Cint, nrhs::Cint, arg5::Ptr{gridinfo3d_t}, info::Ptr{Cint})::Cvoid
end

function dallocScalePermstruct_RC(arg1, m, n)
    @ccall libsuperlu_dist_Int32.dallocScalePermstruct_RC(arg1::Ptr{dScalePermstruct_t}, m::int_t, n::int_t)::Cvoid
end

function dscaleMatrixDiagonally(Fact, arg2, arg3, arg4, arg5, rowequ, colequ, iinfo)
    @ccall libsuperlu_dist_Int32.dscaleMatrixDiagonally(Fact::fact_t, arg2::Ptr{dScalePermstruct_t}, arg3::Ptr{SuperMatrix}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{gridinfo_t}, rowequ::Ptr{Cint}, colequ::Ptr{Cint}, iinfo::Ptr{Cint})::Cvoid
end

function dperform_row_permutation(arg1, Fact, arg3, LUstruct, m, n, arg7, A, GA, arg10, job, Equil, rowequ, colequ, iinfo)
    @ccall libsuperlu_dist_Int32.dperform_row_permutation(arg1::Ptr{superlu_dist_options_t}, Fact::fact_t, arg3::Ptr{dScalePermstruct_t}, LUstruct::Ptr{dLUstruct_t}, m::int_t, n::int_t, arg7::Ptr{gridinfo_t}, A::Ptr{SuperMatrix}, GA::Ptr{SuperMatrix}, arg10::Ptr{SuperLUStat_t}, job::Cint, Equil::Cint, rowequ::Ptr{Cint}, colequ::Ptr{Cint}, iinfo::Ptr{Cint})::Cvoid
end

function dcomputeA_Norm(notran, arg2, arg3)
    @ccall libsuperlu_dist_Int32.dcomputeA_Norm(notran::Cint, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t})::Cdouble
end

function ddist_psymbtonum(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.ddist_psymbtonum(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{dScalePermstruct_t}, arg5::Ptr{Pslu_freeable_t}, arg6::Ptr{dLUstruct_t}, arg7::Ptr{gridinfo_t})::Cfloat
end

function pdGetDiagU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.pdGetDiagU(arg1::int_t, arg2::Ptr{dLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{Cdouble})::Cvoid
end

function d_c2cpp_GetHWPM(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.d_c2cpp_GetHWPM(arg1::Ptr{SuperMatrix}, arg2::Ptr{gridinfo_t}, arg3::Ptr{dScalePermstruct_t})::Cint
end

function dPrintLblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dPrintLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t})::Cvoid
end

function dPrintUblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dPrintUblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t})::Cvoid
end

function dPrint_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.dPrint_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function dPrint_CompCol_triplet(arg1)
    @ccall libsuperlu_dist_Int32.dPrint_CompCol_triplet(arg1::Ptr{SuperMatrix})::Cvoid
end

function file_dPrint_NCPformat_triplet(arg1, arg2)
    @ccall libsuperlu_dist_Int32.file_dPrint_NCPformat_triplet(arg1::Ptr{Libc.FILE}, arg2::Ptr{SuperMatrix})::Cvoid
end

function dPrint_Dense_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.dPrint_Dense_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function dPrint_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.dPrint_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix})::Cint
end

function file_dPrint_CompRowLoc_Matrix_dist(fp, A)
    @ccall libsuperlu_dist_Int32.file_dPrint_CompRowLoc_Matrix_dist(fp::Ptr{Libc.FILE}, A::Ptr{SuperMatrix})::Cint
end

function Printdouble5(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.Printdouble5(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cdouble})::Cvoid
end

function file_Printdouble5(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.file_Printdouble5(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{Cdouble})::Cint
end

function dGenCOOLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.dGenCOOLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{Cdouble}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function dGenCSCLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.dGenCSCLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function dGenCSRLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.dGenCSRLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function dprepare_multiGPU_buffers(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.dprepare_multiGPU_buffers(arg1::Cint, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Cint, arg6::Cint)::Cvoid
end

# no prototype is found for this function at superlu_ddefs.h:1152:13, please use with caution
function ddelete_multiGPU_buffers()
    @ccall libsuperlu_dist_Int32.ddelete_multiGPU_buffers()::Cvoid
end

function superlu_dgemm(transa, transb, m, n, k, alpha, a, lda, b, ldb, beta, c, ldc)
    @ccall libsuperlu_dist_Int32.superlu_dgemm(transa::Ptr{Cchar}, transb::Ptr{Cchar}, m::Cint, n::Cint, k::Cint, alpha::Cdouble, a::Ptr{Cdouble}, lda::Cint, b::Ptr{Cdouble}, ldb::Cint, beta::Cdouble, c::Ptr{Cdouble}, ldc::Cint)::Cint
end

function superlu_dtrsm(sideRL, uplo, transa, diag, m, n, alpha, a, lda, b, ldb)
    @ccall libsuperlu_dist_Int32.superlu_dtrsm(sideRL::Ptr{Cchar}, uplo::Ptr{Cchar}, transa::Ptr{Cchar}, diag::Ptr{Cchar}, m::Cint, n::Cint, alpha::Cdouble, a::Ptr{Cdouble}, lda::Cint, b::Ptr{Cdouble}, ldb::Cint)::Cint
end

function superlu_dger(m, n, alpha, x, incx, y, incy, a, lda)
    @ccall libsuperlu_dist_Int32.superlu_dger(m::Cint, n::Cint, alpha::Cdouble, x::Ptr{Cdouble}, incx::Cint, y::Ptr{Cdouble}, incy::Cint, a::Ptr{Cdouble}, lda::Cint)::Cint
end

function superlu_dscal(n, alpha, x, incx)
    @ccall libsuperlu_dist_Int32.superlu_dscal(n::Cint, alpha::Cdouble, x::Ptr{Cdouble}, incx::Cint)::Cint
end

function superlu_daxpy(n, alpha, x, incx, y, incy)
    @ccall libsuperlu_dist_Int32.superlu_daxpy(n::Cint, alpha::Cdouble, x::Ptr{Cdouble}, incx::Cint, y::Ptr{Cdouble}, incy::Cint)::Cint
end

function superlu_dgemv(trans, m, n, alpha, a, lda, x, incx, beta, y, incy)
    @ccall libsuperlu_dist_Int32.superlu_dgemv(trans::Ptr{Cchar}, m::Cint, n::Cint, alpha::Cdouble, a::Ptr{Cdouble}, lda::Cint, x::Ptr{Cdouble}, incx::Cint, beta::Cdouble, y::Ptr{Cdouble}, incy::Cint)::Cint
end

function superlu_dtrsv(uplo, trans, diag, n, a, lda, x, incx)
    @ccall libsuperlu_dist_Int32.superlu_dtrsv(uplo::Ptr{Cchar}, trans::Ptr{Cchar}, diag::Ptr{Cchar}, n::Cint, a::Ptr{Cdouble}, lda::Cint, x::Ptr{Cdouble}, incx::Cint)::Cint
end

function dcreate_matrix3d(A, nrhs, rhs, ldb, x, ldx, fp, grid3d)
    @ccall libsuperlu_dist_Int32.dcreate_matrix3d(A::Ptr{SuperMatrix}, nrhs::Cint, rhs::Ptr{Ptr{Cdouble}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cdouble}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function dcreate_matrix_postfix3d(A, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.dcreate_matrix_postfix3d(A::Ptr{SuperMatrix}, nrhs::Cint, rhs::Ptr{Ptr{Cdouble}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cdouble}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function dcreate_block_diag_3d(A, batchCount, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.dcreate_block_diag_3d(A::Ptr{SuperMatrix}, batchCount::Cint, nrhs::Cint, rhs::Ptr{Ptr{Cdouble}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cdouble}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function dcreate_batch_systems(SparseMatrix_handles, batchCount, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.dcreate_batch_systems(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, rhs::Ptr{Ptr{Cdouble}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cdouble}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function dcreate_batch_systems_multiple(SparseMatrix_handles, batchCount, nrhs, RHSptr, ldRHS, xtrue, ldX, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.dcreate_batch_systems_multiple(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, RHSptr::Ptr{Ptr{Cdouble}}, ldRHS::Ptr{Cint}, xtrue::Ptr{Ptr{Cdouble}}, ldX::Ptr{Cint}, fp::Ptr{Ptr{Libc.FILE}}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function dcreate_batch_systems_rhsfile(SparseMatrix_handles, batchCount, nrhs, RHSptr, ldRHS, xtrue, ldX, fpA, fpB, fpX, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.dcreate_batch_systems_rhsfile(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, RHSptr::Ptr{Ptr{Cdouble}}, ldRHS::Ptr{Cint}, xtrue::Ptr{Ptr{Cdouble}}, ldX::Ptr{Cint}, fpA::Ptr{Ptr{Libc.FILE}}, fpB::Ptr{Ptr{Libc.FILE}}, fpX::Ptr{Ptr{Libc.FILE}}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function dbatch_systems_free(SparseMatrix_handles, batchCount, RHSptr, xtrue)
    @ccall libsuperlu_dist_Int32.dbatch_systems_free(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, RHSptr::Ptr{Ptr{Cdouble}}, xtrue::Ptr{Ptr{Cdouble}})::Cvoid
end

function dGatherNRformat_loc3d(Fact, A, B, ldb, nrhs, grid3d, arg7)
    @ccall libsuperlu_dist_Int32.dGatherNRformat_loc3d(Fact::fact_t, A::Ptr{NRformat_loc}, B::Ptr{Cdouble}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, arg7::Ptr{Ptr{NRformat_loc3d}})::Cvoid
end

function dGatherNRformat_loc3d_allgrid(options, Fact, A, B, ldb, nrhs, grid3d, arg8)
    @ccall libsuperlu_dist_Int32.dGatherNRformat_loc3d_allgrid(options::Ptr{superlu_dist_options_t}, Fact::fact_t, A::Ptr{NRformat_loc}, B::Ptr{Cdouble}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, arg8::Ptr{Ptr{NRformat_loc3d}})::Cvoid
end

function dScatter_B3d(options, A3d, grid3d)
    @ccall libsuperlu_dist_Int32.dScatter_B3d(options::Ptr{superlu_dist_options_t}, A3d::Ptr{NRformat_loc3d}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function pdgssvx3d(arg1, arg2, arg3, B, ldb, nrhs, arg7, arg8, arg9, berr, arg11, info)
    @ccall libsuperlu_dist_Int32.pdgssvx3d(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{dScalePermstruct_t}, B::Ptr{Cdouble}, ldb::Cint, nrhs::Cint, arg7::Ptr{gridinfo3d_t}, arg8::Ptr{dLUstruct_t}, arg9::Ptr{dSOLVEstruct_t}, berr::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pdgstrf3d(arg1, m, n, anorm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.pdgstrf3d(arg1::Ptr{superlu_dist_options_t}, m::Cint, n::Cint, anorm::Cdouble, arg5::Ptr{dtrf3Dpartition_t}, arg6::Ptr{SCT_t}, arg7::Ptr{dLUstruct_t}, arg8::Ptr{gridinfo3d_t}, arg9::Ptr{SuperLUStat_t}, arg10::Ptr{Cint})::int_t
end

function dInit_HyP(arg1, HyP, Llu, mcb, mrb)
    @ccall libsuperlu_dist_Int32.dInit_HyP(arg1::Ptr{superlu_dist_options_t}, HyP::Ptr{HyP_t}, Llu::Ptr{dLocalLU_t}, mcb::int_t, mrb::int_t)::Cvoid
end

function dblock_gemm_scatter(lb, j, Ublock_info, Remain_info, L_mat, ldl, U_mat, ldu, bigV, knsupc, klst, lsub, usub, ldt, thread_id, indirect, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, Ufstnz_br_ptr, Unzval_br_ptr, xsup, arg23, arg24)
    @ccall libsuperlu_dist_Int32.dblock_gemm_scatter(lb::int_t, j::int_t, Ublock_info::Ptr{Ublock_info_t}, Remain_info::Ptr{Remain_info_t}, L_mat::Ptr{Cdouble}, ldl::Cint, U_mat::Ptr{Cdouble}, ldu::Cint, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, thread_id::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{Cdouble}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{Cdouble}}, xsup::Ptr{int_t}, arg23::Ptr{gridinfo_t}, arg24::Ptr{SuperLUStat_t})::Cvoid
end

function dblock_gemm_scatterTopLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.dblock_gemm_scatterTopLeft(lb::int_t, j::int_t, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{dLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function dblock_gemm_scatterTopRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.dblock_gemm_scatterTopRight(lb::int_t, j::int_t, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{dLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function dblock_gemm_scatterBottomLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.dblock_gemm_scatterBottomLeft(lb::int_t, j::int_t, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{dLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function dblock_gemm_scatterBottomRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.dblock_gemm_scatterBottomRight(lb::int_t, j::int_t, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{dLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function dgather_u(num_u_blks, Ublock_info, usub, uval, bigU, ldu, xsup, klst)
    @ccall libsuperlu_dist_Int32.dgather_u(num_u_blks::int_t, Ublock_info::Ptr{Ublock_info_t}, usub::Ptr{int_t}, uval::Ptr{Cdouble}, bigU::Ptr{Cdouble}, ldu::int_t, xsup::Ptr{int_t}, klst::int_t)::Cvoid
end

function dgather_l(num_LBlk, knsupc, L_info, lval, LD_lval, L_buff)
    @ccall libsuperlu_dist_Int32.dgather_l(num_LBlk::int_t, knsupc::int_t, L_info::Ptr{Remain_info_t}, lval::Ptr{Cdouble}, LD_lval::int_t, L_buff::Ptr{Cdouble})::Cvoid
end

function dRgather_L(k, lsub, lusup, arg4, arg5, arg6, arg7, myIperm, iperm_c_supno)
    @ccall libsuperlu_dist_Int32.dRgather_L(k::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cdouble}, arg4::Ptr{gEtreeInfo_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t})::Cvoid
end

function dRgather_U(k, jj0, usub, uval, bigU, arg6, arg7, arg8, arg9, myIperm, iperm_c_supno, perm_u)
    @ccall libsuperlu_dist_Int32.dRgather_U(k::int_t, jj0::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, bigU::Ptr{Cdouble}, arg6::Ptr{gEtreeInfo_t}, arg7::Ptr{Glu_persist_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, perm_u::Ptr{int_t})::Cvoid
end

function dbcastPermutedSparseA(A, ScalePermstruct, Glu_freeable, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dbcastPermutedSparseA(A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{dScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function dnewTrfPartitionInit(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dnewTrfPartitionInit(nsupers::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function dinitTrf3Dpartition(nsupers, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dinitTrf3Dpartition(nsupers::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{dtrf3Dpartition_t}
end

function dinitTrf3Dpartition_allgrid(n, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dinitTrf3Dpartition_allgrid(n::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{dtrf3Dpartition_t}
end

function dinitTrf3DpartitionLUstructgrid0(n, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dinitTrf3DpartitionLUstructgrid0(n::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{dtrf3Dpartition_t}
end

function dDestroy_trf3Dpartition(trf3Dpartition)
    @ccall libsuperlu_dist_Int32.dDestroy_trf3Dpartition(trf3Dpartition::Ptr{dtrf3Dpartition_t})::Cvoid
end

function d3D_printMemUse(trf3Dpartition, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.d3D_printMemUse(trf3Dpartition::Ptr{dtrf3Dpartition_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function dinit3DLUstructForest(myTreeIdxs, myZeroTrIdxs, sForests, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dinit3DLUstructForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t}}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function dgatherAllFactoredLUFr(myZeroTrIdxs, sForests, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dgatherAllFactoredLUFr(myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dLpanelUpdate(off0, nsupc, ublk_ptr, ld_ujrow, lusup, nsupr, arg7)
    @ccall libsuperlu_dist_Int32.dLpanelUpdate(off0::int_t, nsupc::int_t, ublk_ptr::Ptr{Cdouble}, ld_ujrow::int_t, lusup::Ptr{Cdouble}, nsupr::int_t, arg7::Ptr{SCT_t})::int_t
end

function dgstrf2(k, diagBlk, LDA, BlockUfactor, LDU, thresh, xsup, options, stat, info)
    @ccall libsuperlu_dist_Int32.dgstrf2(k::int_t, diagBlk::Ptr{Cdouble}, LDA::int_t, BlockUfactor::Ptr{Cdouble}, LDU::int_t, thresh::Cdouble, xsup::Ptr{int_t}, options::Ptr{superlu_dist_options_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function Local_Dgstrf2(options, k, thresh, BlockUFactor, arg5, arg6, arg7, arg8, info, arg10)
    @ccall libsuperlu_dist_Int32.Local_Dgstrf2(options::Ptr{superlu_dist_options_t}, k::int_t, thresh::Cdouble, BlockUFactor::Ptr{Cdouble}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{dLocalLU_t}, arg8::Ptr{SuperLUStat_t}, info::Ptr{Cint}, arg10::Ptr{SCT_t})::Cvoid
end

function dTrs2_GatherU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int32.dTrs2_GatherU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, tempv::Ptr{Cdouble})::int_t
end

function dTrs2_ScatterU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int32.dTrs2_ScatterU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, tempv::Ptr{Cdouble})::int_t
end

function dTrs2_GatherTrsmScatter(klst, iukp, rukp, usub, uval, tempv, knsupc, nsupr, lusup, Glu_persist)
    @ccall libsuperlu_dist_Int32.dTrs2_GatherTrsmScatter(klst::int_t, iukp::int_t, rukp::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, tempv::Ptr{Cdouble}, knsupc::int_t, nsupr::Cint, lusup::Ptr{Cdouble}, Glu_persist::Ptr{Glu_persist_t})::int_t
end

function pdgstrs2(m, k0, k, Glu_persist, grid, Llu, stat)
    @ccall libsuperlu_dist_Int32.pdgstrs2(m::int_t, k0::int_t, k::int_t, Glu_persist::Ptr{Glu_persist_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{dLocalLU_t}, stat::Ptr{SuperLUStat_t})::Cvoid
end

function pdgstrf2(arg1, nsupers, k0, k, thresh, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.pdgstrf2(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, k0::int_t, k::int_t, thresh::Cdouble, arg6::Ptr{Glu_persist_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{dLocalLU_t}, arg9::Ptr{MPI_Request}, arg10::Cint, arg11::Ptr{SuperLUStat_t}, arg12::Ptr{Cint})::Cvoid
end

function dAllocLlu_3d(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dAllocLlu_3d(nsupers::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function dp3dScatter(n, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.dp3dScatter(n::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function dscatter3dLPanels(nsupers, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.dscatter3dLPanels(nsupers::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function dscatter3dUPanels(nsupers, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.dscatter3dUPanels(nsupers::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function dcollect3dLpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dcollect3dLpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function dcollect3dUpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dcollect3dUpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function dp3dCollect(layer, n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dp3dCollect(layer::int_t, n::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function dzeroSetLU(nnodes, nodeList, arg3, arg4)
    @ccall libsuperlu_dist_Int32.dzeroSetLU(nnodes::int_t, nodeList::Ptr{int_t}, arg3::Ptr{dLUstruct_t}, arg4::Ptr{gridinfo3d_t})::int_t
end

function dAllocGlu_3d(n, nsupers, arg3)
    @ccall libsuperlu_dist_Int32.dAllocGlu_3d(n::int_t, nsupers::int_t, arg3::Ptr{dLUstruct_t})::Cint
end

function dDeAllocLlu_3d(n, arg2, arg3)
    @ccall libsuperlu_dist_Int32.dDeAllocLlu_3d(n::int_t, arg2::Ptr{dLUstruct_t}, arg3::Ptr{gridinfo3d_t})::Cint
end

function dDeAllocGlu_3d(arg1)
    @ccall libsuperlu_dist_Int32.dDeAllocGlu_3d(arg1::Ptr{dLUstruct_t})::Cint
end

function dreduceAncestors3d(sender, receiver, nnodes, nodeList, Lval_buf, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dreduceAncestors3d(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, Uval_buf::Ptr{Cdouble}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dreduceAllAncestors3d(ilvl, myNodeCount, treePerm, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dreduceAllAncestors3d(ilvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}}, LUvsb::Ptr{dLUValSubBuf_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cint
end

function dgatherFactoredLU(sender, receiver, nnodes, nodeList, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dgatherFactoredLU(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, LUvsb::Ptr{dLUValSubBuf_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dgatherAllFactoredLU(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dgatherAllFactoredLU(trf3Dpartition::Ptr{dtrf3Dpartition_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dinit3DLUstruct(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dinit3DLUstruct(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function dzSendLPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dzSendLPanel(k::int_t, receiver::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dzRecvLPanel(k, sender, alpha, beta, Lval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dzRecvLPanel(k::int_t, sender::int_t, alpha::Cdouble, beta::Cdouble, Lval_buf::Ptr{Cdouble}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dzSendUPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dzSendUPanel(k::int_t, receiver::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dzRecvUPanel(k, sender, alpha, beta, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.dzRecvUPanel(k::int_t, sender::int_t, alpha::Cdouble, beta::Cdouble, Uval_buf::Ptr{Cdouble}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function dIBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, arg7, ToSendR, xsup, arg10)
    @ccall libsuperlu_dist_Int32.dIBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cdouble}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg10::Cint)::int_t
end

function dBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, ToSendR, xsup, arg9, arg10)
    @ccall libsuperlu_dist_Int32.dBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cdouble}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg9::Ptr{SCT_t}, arg10::Cint)::int_t
end

function dIBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, arg7, ToSendD, arg9)
    @ccall libsuperlu_dist_Int32.dIBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendD::Ptr{Cint}, arg9::Cint)::int_t
end

function dBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, ToSendD, arg8, arg9)
    @ccall libsuperlu_dist_Int32.dBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, ToSendD::Ptr{Cint}, arg8::Ptr{SCT_t}, arg9::Cint)::int_t
end

function dIrecv_LPanel(k, k0, Lsub_buf, Lval_buf, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dIrecv_LPanel(k::int_t, k0::int_t, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, arg5::Ptr{gridinfo_t}, arg6::Ptr{MPI_Request}, arg7::Ptr{dLocalLU_t}, arg8::Cint)::int_t
end

function dIrecv_UPanel(k, k0, Usub_buf, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dIrecv_UPanel(k::int_t, k0::int_t, Usub_buf::Ptr{int_t}, arg4::Ptr{Cdouble}, arg5::Ptr{dLocalLU_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{MPI_Request}, arg8::Cint)::int_t
end

function dWait_URecv(arg1, msgcnt, arg3)
    @ccall libsuperlu_dist_Int32.dWait_URecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, arg3::Ptr{SCT_t})::int_t
end

function dWait_LRecv(arg1, msgcnt, msgcntsU, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dWait_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, msgcntsU::Ptr{Cint}, arg4::Ptr{gridinfo_t}, arg5::Ptr{SCT_t})::int_t
end

function dISend_UDiagBlock(k0, ublk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.dISend_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Cint)::int_t
end

function dRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, src::int_t, arg5::Ptr{gridinfo_t}, arg6::Ptr{SCT_t}, arg7::Cint)::int_t
end

function dPackLBlock(k, Dest, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dPackLBlock(k::int_t, Dest::Ptr{Cdouble}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{dLocalLU_t})::int_t
end

function dISend_LDiagBlock(k0, lblk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.dISend_LDiagBlock(k0::int_t, lblk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Cint)::int_t
end

function dIRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dIRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function dIRecv_LDiagBlock(k0, L_blk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dIRecv_LDiagBlock(k0::int_t, L_blk_ptr::Ptr{Cdouble}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function dUDiagBlockRecvWait(k, IrecvPlcd_D, factored_L, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dUDiagBlockRecvWait(k::int_t, IrecvPlcd_D::Ptr{Cint}, factored_L::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Ptr{dLUstruct_t}, arg7::Ptr{SCT_t})::int_t
end

function dIBcast_UDiagBlock(k, ublk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dIBcast_UDiagBlock(k::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function dIBcast_LDiagBlock(k, lblk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dIBcast_LDiagBlock(k::int_t, lblk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function dDiagFactIBCast(k, k0, BlockUFactor, BlockLFactor, IrecvPlcd_D, arg6, arg7, arg8, arg9, arg10, arg11, thresh, LUstruct, arg14, info, arg16, tag_ub)
    @ccall libsuperlu_dist_Int32.dDiagFactIBCast(k::int_t, k0::int_t, BlockUFactor::Ptr{Cdouble}, BlockLFactor::Ptr{Cdouble}, IrecvPlcd_D::Ptr{Cint}, arg6::Ptr{MPI_Request}, arg7::Ptr{MPI_Request}, arg8::Ptr{MPI_Request}, arg9::Ptr{MPI_Request}, arg10::Ptr{gridinfo_t}, arg11::Ptr{superlu_dist_options_t}, thresh::Cdouble, LUstruct::Ptr{dLUstruct_t}, arg14::Ptr{SuperLUStat_t}, info::Ptr{Cint}, arg16::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function dUPanelTrSolve(k, BlockLFactor, bigV, ldt, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.dUPanelTrSolve(k::int_t, BlockLFactor::Ptr{Cdouble}, bigV::Ptr{Cdouble}, ldt::int_t, arg5::Ptr{Ublock_info_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{dLUstruct_t}, arg8::Ptr{SuperLUStat_t}, arg9::Ptr{SCT_t})::int_t
end

function dLPanelUpdate(k, IrecvPlcd_D, factored_L, arg4, BlockUFactor, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dLPanelUpdate(k::int_t, IrecvPlcd_D::Ptr{Cint}, factored_L::Ptr{Cint}, arg4::Ptr{MPI_Request}, BlockUFactor::Ptr{Cdouble}, arg6::Ptr{gridinfo_t}, arg7::Ptr{dLUstruct_t}, arg8::Ptr{SCT_t})::int_t
end

function dUPanelUpdate(k, factored_U, arg3, BlockLFactor, bigV, ldt, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.dUPanelUpdate(k::int_t, factored_U::Ptr{Cint}, arg3::Ptr{MPI_Request}, BlockLFactor::Ptr{Cdouble}, bigV::Ptr{Cdouble}, ldt::int_t, arg7::Ptr{Ublock_info_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{dLUstruct_t}, arg10::Ptr{SuperLUStat_t}, arg11::Ptr{SCT_t})::int_t
end

function dIBcastRecvLPanel(k, k0, msgcnt, arg4, arg5, Lsub_buf, Lval_buf, factored, arg9, arg10, arg11, tag_ub)
    @ccall libsuperlu_dist_Int32.dIBcastRecvLPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, factored::Ptr{Cint}, arg9::Ptr{gridinfo_t}, arg10::Ptr{dLUstruct_t}, arg11::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function dIBcastRecvUPanel(k, k0, msgcnt, arg4, arg5, Usub_buf, Uval_buf, arg8, arg9, arg10, tag_ub)
    @ccall libsuperlu_dist_Int32.dIBcastRecvUPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{Cdouble}, arg8::Ptr{gridinfo_t}, arg9::Ptr{dLUstruct_t}, arg10::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function dWaitL(k, msgcnt, msgcntU, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dWaitL(k::int_t, msgcnt::Ptr{Cint}, msgcntU::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{dLUstruct_t}, arg8::Ptr{SCT_t})::int_t
end

function dWaitU(k, msgcnt, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dWaitU(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{MPI_Request}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Ptr{dLUstruct_t}, arg7::Ptr{SCT_t})::int_t
end

function dLPanelTrSolve(k, factored_L, BlockUFactor, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dLPanelTrSolve(k::int_t, factored_L::Ptr{Cint}, BlockUFactor::Ptr{Cdouble}, arg4::Ptr{gridinfo_t}, arg5::Ptr{dLUstruct_t})::int_t
end

function dSchurComplementSetup(k, msgcnt, arg3, arg4, arg5, arg6, arg7, arg8, arg9, bigU, Lsub_buf, Lval_buf, Usub_buf, Uval_buf, arg15, arg16)
    @ccall libsuperlu_dist_Int32.dSchurComplementSetup(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{Ublock_info_t}, arg4::Ptr{Remain_info_t}, arg5::Ptr{uPanelInfo_t}, arg6::Ptr{lPanelInfo_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, bigU::Ptr{Cdouble}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{Cdouble}, arg15::Ptr{gridinfo_t}, arg16::Ptr{dLUstruct_t})::int_t
end

function dSchurComplementSetupGPU(k, msgs, arg3, arg4, arg5, arg6, arg7, arg8, arg9, LUvsb, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.dSchurComplementSetupGPU(k::int_t, msgs::Ptr{msgs_t}, arg3::Ptr{packLUInfo_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{gEtreeInfo_t}, arg8::Ptr{factNodelists_t}, arg9::Ptr{dscuBufs_t}, LUvsb::Ptr{dLUValSubBuf_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{dLUstruct_t}, arg13::Ptr{HyP_t})::int_t
end

function dgetBigV(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dgetBigV(arg1::int_t, arg2::int_t)::Ptr{Cdouble}
end

function dgetBigU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.dgetBigU(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{dLUstruct_t})::Ptr{Cdouble}
end

function dLluBufInit(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dLluBufInit(arg1::Ptr{dLUValSubBuf_t}, arg2::Ptr{dLUstruct_t})::int_t
end

function dinitScuBufs(arg1, ldt, num_threads, nsupers, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dinitScuBufs(arg1::Ptr{superlu_dist_options_t}, ldt::int_t, num_threads::int_t, nsupers::int_t, arg5::Ptr{dscuBufs_t}, arg6::Ptr{dLUstruct_t}, arg7::Ptr{gridinfo_t})::int_t
end

function dfreeScuBufs(scuBufs)
    @ccall libsuperlu_dist_Int32.dfreeScuBufs(scuBufs::Ptr{dscuBufs_t})::Cint
end

function dsparseTreeFactor(nnodes, perm_c_supno, treeTopoInfo, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, info)
    @ccall libsuperlu_dist_Int32.dsparseTreeFactor(nnodes::int_t, perm_c_supno::Ptr{int_t}, treeTopoInfo::Ptr{treeTopoInfo_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{dscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgs::Ptr{msgs_t}, LUvsb::Ptr{dLUValSubBuf_t}, dFBuf::Ptr{ddiagFactBufs_t}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, info::Ptr{Cint})::int_t
end

function ddenseTreeFactor(nnnodes, perm_c_supno, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int32.ddenseTreeFactor(nnnodes::int_t, perm_c_supno::Ptr{int_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{dscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgs::Ptr{msgs_t}, LUvsb::Ptr{dLUValSubBuf_t}, dFBuf::Ptr{ddiagFactBufs_t}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function dsparseTreeFactor_ASYNC(sforest, comReqss, scuBufs, packLUInfo, msgss, LUvsbs, dFBufs, factStat, fNlists, gEtreeInfo, options, gIperm_c_supno, ldt, HyP, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int32.dsparseTreeFactor_ASYNC(sforest::Ptr{sForest_t}, comReqss::Ptr{Ptr{commRequests_t}}, scuBufs::Ptr{dscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgss::Ptr{Ptr{msgs_t}}, LUvsbs::Ptr{Ptr{dLUValSubBuf_t}}, dFBufs::Ptr{Ptr{ddiagFactBufs_t}}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, gEtreeInfo::Ptr{gEtreeInfo_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, HyP::Ptr{HyP_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function dLluBufInitArr(numLA, LUstruct)
    @ccall libsuperlu_dist_Int32.dLluBufInitArr(numLA::int_t, LUstruct::Ptr{dLUstruct_t})::Ptr{Ptr{dLUValSubBuf_t}}
end

function dLluBufFreeArr(numLA, LUvsbs)
    @ccall libsuperlu_dist_Int32.dLluBufFreeArr(numLA::int_t, LUvsbs::Ptr{Ptr{dLUValSubBuf_t}})::Cint
end

function dinitDiagFactBufsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_dist_Int32.dinitDiagFactBufsArr(mxLeafNode::Cint, ldt::Cint, grid::Ptr{gridinfo_t})::Ptr{Ptr{ddiagFactBufs_t}}
end

function dinitDiagFactBufsArrMod(mxLeafNode, ldts, grid)
    @ccall libsuperlu_dist_Int32.dinitDiagFactBufsArrMod(mxLeafNode::Cint, ldts::Ptr{Cint}, grid::Ptr{gridinfo_t})::Ptr{Ptr{ddiagFactBufs_t}}
end

function dfreeDiagFactBufsArr(mxLeafNode, dFBufs)
    @ccall libsuperlu_dist_Int32.dfreeDiagFactBufsArr(mxLeafNode::Cint, dFBufs::Ptr{Ptr{ddiagFactBufs_t}})::Cint
end

function dinitDiagFactBufs(ldt, dFBuf)
    @ccall libsuperlu_dist_Int32.dinitDiagFactBufs(ldt::Cint, dFBuf::Ptr{ddiagFactBufs_t})::Cint
end

function pdflatten_LDATA(options, n, LUstruct, grid)
    @ccall libsuperlu_dist_Int32.pdflatten_LDATA(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{dLUstruct_t}, grid::Ptr{gridinfo_t})::Cint
end

function pdconvert_flatten_skyline2UROWDATA(arg1, arg2, arg3, arg4, n)
    @ccall libsuperlu_dist_Int32.pdconvert_flatten_skyline2UROWDATA(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{dLUstruct_t}, arg4::Ptr{SuperLUStat_t}, n::Cint)::Cvoid
end

function pdconvertUROWDATA2skyline(arg1, arg2, arg3, arg4, n)
    @ccall libsuperlu_dist_Int32.pdconvertUROWDATA2skyline(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{dLUstruct_t}, arg4::Ptr{SuperLUStat_t}, n::Cint)::Cvoid
end

function dReDistribute_A(A, ScalePermstruct, Glu_freeable, xsup, supno, grid, colptr, rowind, a)
    @ccall libsuperlu_dist_Int32.dReDistribute_A(A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{dScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, xsup::Ptr{int_t}, supno::Ptr{int_t}, grid::Ptr{gridinfo_t}, colptr::Ptr{Ptr{int_t}}, rowind::Ptr{Ptr{int_t}}, a::Ptr{Ptr{Cdouble}})::int_t
end

function pddistribute3d(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.pddistribute3d(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{dScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cfloat
end

function pdgssvx3d_csc_batch(arg1, batchCount, m, n, nnz, nrhs, arg7, RHSptr, ldRHS, ReqPtr, CeqPtr, RpivPtr, CpivPtr, DiagScale, F, Xptr, ldX, Berrs, grid3d, stat, info)
    @ccall libsuperlu_dist_Int32.pdgssvx3d_csc_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, nnz::Cint, nrhs::Cint, arg7::Ptr{handle_t}, RHSptr::Ptr{Ptr{Cdouble}}, ldRHS::Ptr{Cint}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, RpivPtr::Ptr{Ptr{Cint}}, CpivPtr::Ptr{Ptr{Cint}}, DiagScale::Ptr{DiagScale_t}, F::Ptr{handle_t}, Xptr::Ptr{Ptr{Cdouble}}, ldX::Ptr{Cint}, Berrs::Ptr{Ptr{Cdouble}}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cint
end

function dequil_batch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8)
    @ccall libsuperlu_dist_Int32.dequil_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, arg8::Ptr{DiagScale_t})::Cint
end

function dpivot_batch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, RpivPtr)
    @ccall libsuperlu_dist_Int32.dpivot_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, arg8::Ptr{DiagScale_t}, RpivPtr::Ptr{Ptr{Cint}})::Cint
end

function pdgssvx3d_csc_vbatch(arg1, batchCount, m, n, nnz, nrhs, arg7, RHSptr, ldRHS, ReqPtr, CeqPtr, RpivPtr, CpivPtr, DiagScale, F, Xptr, ldX, Berrs, grid3d, stat, info)
    @ccall libsuperlu_dist_Int32.pdgssvx3d_csc_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, nnz::Ptr{Cint}, nrhs::Cint, arg7::Ptr{handle_t}, RHSptr::Ptr{Ptr{Cdouble}}, ldRHS::Ptr{Cint}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, RpivPtr::Ptr{Ptr{Cint}}, CpivPtr::Ptr{Ptr{Cint}}, DiagScale::Ptr{DiagScale_t}, F::Ptr{handle_t}, Xptr::Ptr{Ptr{Cdouble}}, ldX::Ptr{Cint}, Berrs::Ptr{Ptr{Cdouble}}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cint
end

function dvbatch_free(F)
    @ccall libsuperlu_dist_Int32.dvbatch_free(F::Ptr{handle_t})::Cvoid
end

function dequil_vbatch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, info)
    @ccall libsuperlu_dist_Int32.dequil_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, arg8::Ptr{DiagScale_t}, info::Ptr{Cint})::Cint
end

function dpivot_vbatch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, RpivPtr, info)
    @ccall libsuperlu_dist_Int32.dpivot_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, arg8::Ptr{DiagScale_t}, RpivPtr::Ptr{Ptr{Cint}}, info::Ptr{Cint})::Cint
end

function dwriteLUtoDisk(nsupers, xsup, LUstruct)
    @ccall libsuperlu_dist_Int32.dwriteLUtoDisk(nsupers::Cint, xsup::Ptr{int_t}, LUstruct::Ptr{dLUstruct_t})::Cint
end

function dcheckArr(A, B, n)
    @ccall libsuperlu_dist_Int32.dcheckArr(A::Ptr{Cdouble}, B::Ptr{Cdouble}, n::Cint)::Cint
end

function dcheckLUFromDisk(nsupers, xsup, LUstruct)
    @ccall libsuperlu_dist_Int32.dcheckLUFromDisk(nsupers::Cint, xsup::Ptr{int_t}, LUstruct::Ptr{dLUstruct_t})::Cint
end

function dDumpLblocks3D(nsupers, grid3d, Glu_persist, Llu)
    @ccall libsuperlu_dist_Int32.dDumpLblocks3D(nsupers::int_t, grid3d::Ptr{gridinfo3d_t}, Glu_persist::Ptr{Glu_persist_t}, Llu::Ptr{dLocalLU_t})::Cvoid
end

function dDumpUblocks3D(nsupers, grid3d, Glu_persist, Llu)
    @ccall libsuperlu_dist_Int32.dDumpUblocks3D(nsupers::int_t, grid3d::Ptr{gridinfo3d_t}, Glu_persist::Ptr{Glu_persist_t}, Llu::Ptr{dLocalLU_t})::Cvoid
end

struct doublecomplex
    r::Cdouble
    i::Cdouble
end

function slud_z_div(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.slud_z_div(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex})::Cvoid
end

function slud_z_abs(arg1)
    @ccall libsuperlu_dist_Int32.slud_z_abs(arg1::Ptr{doublecomplex})::Cdouble
end

function slud_z_abs1(arg1)
    @ccall libsuperlu_dist_Int32.slud_z_abs1(arg1::Ptr{doublecomplex})::Cdouble
end

struct zScalePermstruct_t
    DiagScale::DiagScale_t
    R::Ptr{Cdouble}
    C::Ptr{Cdouble}
    perm_r::Ptr{Cint}
    perm_c::Ptr{Cint}
    d_perm_r::Ptr{Cint}
    d_perm_c::Ptr{Cint}
    d_R::Ptr{Cdouble}
    d_C::Ptr{Cdouble}
end

struct zLocalLU_t
    Lrowind_bc_ptr::Ptr{Ptr{int_t}}
    Lrowind_bc_dat::Ptr{int_t}
    Lrowind_bc_offset::Ptr{Clong}
    Lrowind_bc_cnt::Clong
    Lnzval_bc_ptr::Ptr{Ptr{doublecomplex}}
    Lnzval_bc_dat::Ptr{doublecomplex}
    Lnzval_bc_offset::Ptr{Clong}
    Lnzval_bc_cnt::Clong
    Linv_bc_ptr::Ptr{Ptr{doublecomplex}}
    Linv_bc_dat::Ptr{doublecomplex}
    Linv_bc_offset::Ptr{Clong}
    Linv_bc_cnt::Clong
    Lindval_loc_bc_ptr::Ptr{Ptr{int_t}}
    Lindval_loc_bc_dat::Ptr{int_t}
    Lindval_loc_bc_offset::Ptr{Clong}
    Lindval_loc_bc_cnt::Clong
    Ucolind_bc_ptr::Ptr{Ptr{int_t}}
    Ucolind_bc_dat::Ptr{int_t}
    Ucolind_bc_offset::Ptr{Int64}
    Ucolind_bc_cnt::Int64
    Unzval_bc_ptr::Ptr{Ptr{doublecomplex}}
    Unzval_bc_dat::Ptr{doublecomplex}
    Unzval_bc_offset::Ptr{Int64}
    Unzval_bc_cnt::Int64
    Uindval_loc_bc_ptr::Ptr{Ptr{int_t}}
    Uindval_loc_bc_dat::Ptr{int_t}
    Uindval_loc_bc_offset::Ptr{Int64}
    Uindval_loc_bc_cnt::Int64
    Uind_br_ptr::Ptr{Ptr{int_t}}
    Uind_br_dat::Ptr{int_t}
    Uind_br_offset::Ptr{Int64}
    Uind_br_cnt::Int64
    Ucolind_br_ptr::Ptr{Ptr{int_t}}
    Ucolind_br_dat::Ptr{int_t}
    Ucolind_br_offset::Ptr{Int64}
    Ucolind_br_cnt::Int64
    Unzval_br_new_ptr::Ptr{Ptr{doublecomplex}}
    Unzval_br_new_dat::Ptr{doublecomplex}
    Unzval_br_new_offset::Ptr{Int64}
    Unzval_br_new_cnt::Int64
    Unnz::Ptr{int_t}
    Lrowind_bc_2_lsum::Ptr{Ptr{int_t}}
    Uinv_bc_ptr::Ptr{Ptr{doublecomplex}}
    Uinv_bc_dat::Ptr{doublecomplex}
    Uinv_bc_offset::Ptr{Clong}
    Uinv_bc_cnt::Clong
    Ufstnz_br_ptr::Ptr{Ptr{int_t}}
    Ufstnz_br_dat::Ptr{int_t}
    Ufstnz_br_offset::Ptr{Clong}
    Ufstnz_br_cnt::Clong
    Unzval_br_ptr::Ptr{Ptr{doublecomplex}}
    Unzval_br_dat::Ptr{doublecomplex}
    Unzval_br_offset::Ptr{Clong}
    Unzval_br_cnt::Clong
    LBtree_ptr::Ptr{C_Tree}
    LRtree_ptr::Ptr{C_Tree}
    UBtree_ptr::Ptr{C_Tree}
    URtree_ptr::Ptr{C_Tree}
    Lsub_buf_2::NTuple{50, Ptr{int_t}}
    Lval_buf_2::NTuple{50, Ptr{doublecomplex}}
    Usub_buf_2::NTuple{50, Ptr{int_t}}
    Uval_buf_2::NTuple{50, Ptr{doublecomplex}}
    ujrow::Ptr{doublecomplex}
    bufmax::NTuple{5, int_t}
    ToRecv::Ptr{Cint}
    ToSendD::Ptr{Cint}
    ToSendR::Ptr{Ptr{Cint}}
    fmod::Ptr{Cint}
    fsendx_plist::Ptr{Ptr{Cint}}
    frecv::Ptr{Cint}
    nfrecvx::Cint
    nfsendx::Cint
    bmod::Ptr{Cint}
    bsendx_plist::Ptr{Ptr{Cint}}
    brecv::Ptr{Cint}
    nbrecvx::Cint
    nbsendx::Cint
    mod_bit::Ptr{Cint}
    nleaf::Cint
    nroot::Cint
    ilsum::Ptr{int_t}
    ldalsum::int_t
    SolveMsgSent::int_t
    SolveMsgVol::int_t
    bcols_masked::Ptr{Cint}
    UT_SOLVE::int_t
    L_SOLVE::int_t
    FRECV::int_t
    ut_ldalsum::int_t
    ut_ilsum::Ptr{int_t}
    utmod::Ptr{int_t}
    ut_sendx_plist::Ptr{Ptr{int_t}}
    utrecv::Ptr{int_t}
    n_utsendx::int_t
    n_utrecvx::int_t
    n_utrecvmod::int_t
    ut_modbit::Ptr{int_t}
    Urbs::Ptr{int_t}
    Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}
    Ucb_inddat::Ptr{Ucb_indptr_t}
    Ucb_indoffset::Ptr{Clong}
    Ucb_indcnt::Clong
    Ucb_valptr::Ptr{Ptr{int_t}}
    Ucb_valdat::Ptr{int_t}
    Ucb_valoffset::Ptr{Clong}
    Ucb_valcnt::Clong
    n::int_t
    nfrecvmod::int_t
    inv::int_t
    nbcol_masked::Cint
    d_Lrowind_bc_dat::Ptr{int_t}
    d_Lrowind_bc_offset::Ptr{Clong}
    d_Lnzval_bc_dat::Ptr{doublecomplex}
    d_Lnzval_bc_offset::Ptr{Clong}
    d_Ucolind_bc_dat::Ptr{int_t}
    d_Ucolind_bc_offset::Ptr{Int64}
    d_Uind_br_dat::Ptr{int_t}
    d_Uind_br_offset::Ptr{Int64}
    d_Unzval_bc_dat::Ptr{doublecomplex}
    d_Unzval_bc_offset::Ptr{Clong}
    d_Ucolind_br_dat::Ptr{int_t}
    d_Ucolind_br_offset::Ptr{Int64}
    d_Unzval_br_new_dat::Ptr{doublecomplex}
    d_Unzval_br_new_offset::Ptr{Int64}
    d_Linv_bc_dat::Ptr{doublecomplex}
    d_Uinv_bc_dat::Ptr{doublecomplex}
    d_Linv_bc_offset::Ptr{Clong}
    d_Uinv_bc_offset::Ptr{Clong}
    d_Lindval_loc_bc_dat::Ptr{int_t}
    d_Lindval_loc_bc_offset::Ptr{Int64}
    d_Uindval_loc_bc_dat::Ptr{int_t}
    d_Uindval_loc_bc_offset::Ptr{Int64}
    d_bcols_masked::Ptr{Cint}
    d_ilsum::Ptr{int_t}
    d_xsup::Ptr{int_t}
    d_supno::Ptr{int_t}
    d_LBtree_ptr::Ptr{C_Tree}
    d_LRtree_ptr::Ptr{C_Tree}
    d_UBtree_ptr::Ptr{C_Tree}
    d_URtree_ptr::Ptr{C_Tree}
    d_grid::Ptr{gridinfo_t}
end

struct zLUValSubBuf_t
    Lsub_buf::Ptr{int_t}
    Lval_buf::Ptr{doublecomplex}
    Usub_buf::Ptr{int_t}
    Uval_buf::Ptr{doublecomplex}
end

struct ztrf3Dpartition_t
    nsupers::int_t
    gEtreeInfo::gEtreeInfo_t
    iperm_c_supno::Ptr{int_t}
    myNodeCount::Ptr{int_t}
    myTreeIdxs::Ptr{int_t}
    myZeroTrIdxs::Ptr{int_t}
    treePerm::Ptr{Ptr{int_t}}
    sForests::Ptr{Ptr{sForest_t}}
    supernode2treeMap::Ptr{int_t}
    supernodeMask::Ptr{Cint}
    LUvsb::Ptr{zLUValSubBuf_t}
    superGridMap::Ptr{SupernodeToGridMap_t}
    d_superGridMap::Ptr{SupernodeToGridMap_t}
    maxLvl::Cint
    mxLeafNode::Cint
    diagDims::Ptr{Cint}
    gemmCsizes::Ptr{Cint}
end

struct zLUstruct_t
    etree::Ptr{int_t}
    Glu_persist::Ptr{Glu_persist_t}
    Llu::Ptr{zLocalLU_t}
    trf3Dpart::Ptr{ztrf3Dpartition_t}
    dt::Cchar
end

struct pzgsmv_comm_t
    extern_start::Ptr{int_t}
    ind_tosend::Ptr{int_t}
    ind_torecv::Ptr{int_t}
    ptr_ind_tosend::Ptr{int_t}
    ptr_ind_torecv::Ptr{int_t}
    SendCounts::Ptr{Cint}
    RecvCounts::Ptr{Cint}
    val_tosend::Ptr{Cvoid}
    val_torecv::Ptr{Cvoid}
    TotalIndSend::int_t
    TotalValSend::int_t
end

struct zSOLVEstruct_t
    row_to_proc::Ptr{int_t}
    inv_perm_c::Ptr{Cint}
    num_diag_procs::int_t
    diag_procs::Ptr{int_t}
    diag_len::Ptr{int_t}
    gsmv_comm::Ptr{pzgsmv_comm_t}
    gstrs_comm::Ptr{pxgstrs_comm_t}
    A_colind_gsmv::Ptr{int_t}
    xrow_to_proc::Ptr{int_t}
    A3d::Ptr{NRformat_loc3d}
    d_lsum::Ptr{doublecomplex}
    d_lsum_save::Ptr{doublecomplex}
    d_x::Ptr{doublecomplex}
    d_fmod_save::Ptr{Cint}
    d_fmod::Ptr{Cint}
    d_bmod_save::Ptr{Cint}
    d_bmod::Ptr{Cint}
    d_ptr_to_idbuf_X2B::Ptr{Cint}
    d_ptr_to_idbuf_X2B_save::Ptr{Cint}
    d_ptr_to_idbuf_B2X::Ptr{Cint}
    d_ptr_to_idbuf_B2X_save::Ptr{Cint}
    d_inv_perm_c::Ptr{Cint}
    d_ptr_to_idbuf_PermuteC::Ptr{Cint}
    d_ptr_to_idbuf_PermuteC_save::Ptr{Cint}
    d_row_to_proc::Ptr{int_t}
    d_diag_procs::Ptr{int_t}
    d_send_idbuf_B2X::Ptr{doublecomplex}
    d_send_idbuf_X2B::Ptr{doublecomplex}
    d_send_idbuf_PermuteC::Ptr{doublecomplex}
    d_recv_idbuf_B2X::Ptr{doublecomplex}
    d_recv_idbuf_X2B::Ptr{doublecomplex}
    d_recv_idbuf_PermuteC::Ptr{doublecomplex}
end

"""
    zvbatch_ctx_t

\\brief Persistent state for repeated batch solves that share one sparsity
 pattern.  Callers hold it only as the opaque handle F[0], see
 pzgssvx3d_csc_vbatch().

Everything here is built on the Fact = DOFACT call and reused on every
subsequent SamePattern_SameRowPerm call: the internal 1x1x1 grid, the
stacked block-diagonal matrix A_big and its CSR arrays, and the
factorization metadata (etree, perm_c of the big system, symbolic
factorization, and the distributed L/U structure).
"""
struct zvbatch_ctx_t
    initialized::Cint
    batchCount::Cint
    nrhs::Cint
    m_big::Cint
    n_big::Cint
    nnz_big::Cint
    gridalloc::Cint
    grid::gridinfo3d_t
    options_big::superlu_dist_options_t
    ScalePermstruct::zScalePermstruct_t
    LUstruct::zLUstruct_t
    SOLVEstruct::zSOLVEstruct_t
    A_big::SuperMatrix
    a_big::Ptr{doublecomplex}
    colind::Ptr{int_t}
    rowptr::Ptr{int_t}
    b::Ptr{doublecomplex}
    berr::Ptr{Cdouble}
end

struct zscuBufs_t
    bigU::Ptr{doublecomplex}
    bigV::Ptr{doublecomplex}
end

struct zdiagFactBufs_t
    BlockLFactor::Ptr{doublecomplex}
    BlockUFactor::Ptr{doublecomplex}
end

struct zxT_struct
    xT::Ptr{doublecomplex}
    ldaspaT::int_t
    ilsumT::Ptr{int_t}
end

struct zlsumBmod_buff_t
    tX::Ptr{doublecomplex}
    tU::Ptr{doublecomplex}
    indCols::Ptr{int_t}
end

function zCreate_CompCol_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.zCreate_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{doublecomplex}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Stype_t, arg9::Dtype_t, arg10::Mtype_t)::Cvoid
end

function zCreate_CompRowLoc_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.zCreate_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{doublecomplex}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Stype_t, arg11::Dtype_t, arg12::Mtype_t)::Cvoid
end

function zCompRow_to_CompCol_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.zCompRow_to_CompCol_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{doublecomplex}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{Ptr{doublecomplex}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{Ptr{int_t}})::Cvoid
end

function zCompCol_to_CompRow_dist(m, n, nnz, a, colptr, rowind, at, rowptr, colind)
    @ccall libsuperlu_dist_Int32.zCompCol_to_CompRow_dist(m::int_t, n::int_t, nnz::int_t, a::Ptr{doublecomplex}, colptr::Ptr{int_t}, rowind::Ptr{int_t}, at::Ptr{Ptr{doublecomplex}}, rowptr::Ptr{Ptr{int_t}}, colind::Ptr{Ptr{int_t}})::Cvoid
end

function pzCompRow_loc_to_CompCol_global(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.pzCompRow_loc_to_CompCol_global(arg1::int_t, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperMatrix})::Cint
end

function zCopy_CompCol_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zCopy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function zCreate_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zCreate_Dense_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::Ptr{doublecomplex}, arg5::int_t, arg6::Stype_t, arg7::Dtype_t, arg8::Mtype_t)::Cvoid
end

function zCreate_SuperNode_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.zCreate_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{doublecomplex}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Stype_t, arg12::Dtype_t, arg13::Mtype_t)::Cvoid
end

function zCopy_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.zCopy_Dense_Matrix_dist(arg1::int_t, arg2::int_t, arg3::Ptr{doublecomplex}, arg4::int_t, arg5::Ptr{doublecomplex}, arg6::int_t)::Cvoid
end

function zallocateA_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zallocateA_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Ptr{int_t}}, arg5::Ptr{Ptr{int_t}})::Cvoid
end

function zGenXtrue_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.zGenXtrue_dist(arg1::int_t, arg2::int_t, arg3::Ptr{doublecomplex}, arg4::int_t)::Cvoid
end

function zFillRHS_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zFillRHS_dist(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{doublecomplex}, arg4::int_t, arg5::Ptr{SuperMatrix}, arg6::Ptr{doublecomplex}, arg7::int_t)::Cvoid
end

function zcreate_matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zcreate_matrix(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function zcreate_matrix_rb(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zcreate_matrix_rb(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function zcreate_matrix_dat(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zcreate_matrix_dat(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t})::Cint
end

function zcreate_matrix_postfix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.zcreate_matrix_postfix(arg1::Ptr{SuperMatrix}, arg2::Cint, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{Cchar}, arg9::Ptr{gridinfo_t})::Cint
end

function zScalePermstructInit(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.zScalePermstructInit(arg1::int_t, arg2::int_t, arg3::Ptr{zScalePermstruct_t})::Cvoid
end

function zScalePermstructFree(arg1)
    @ccall libsuperlu_dist_Int32.zScalePermstructFree(arg1::Ptr{zScalePermstruct_t})::Cvoid
end

function zgsequ_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zgsequ_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{Cint})::Cvoid
end

function zlangs_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zlangs_dist(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix})::Cdouble
end

function zlaqgs_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zlaqgs_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pzgsequ(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pzgsequ(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{Cint}, arg8::Ptr{gridinfo_t})::Cvoid
end

function pzlangs(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.pzlangs(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t})::Cdouble
end

function pzlaqgs(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pzlaqgs(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pzPermute_Dense_Matrix(arg1, arg2, arg3, perm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.pzPermute_Dense_Matrix(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, perm::Ptr{Cint}, arg5::Ptr{doublecomplex}, arg6::Cint, arg7::Ptr{doublecomplex}, arg8::Cint, arg9::Cint, arg10::Ptr{gridinfo_t})::Cint
end

function pzPermute_Dense_Matrix_gpu_wrap(fst_row, m_loc, n, d_X, ldx, d_B, ldb, nrhs, grid, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.pzPermute_Dense_Matrix_gpu_wrap(fst_row::int_t, m_loc::int_t, n::int_t, d_X::Ptr{doublecomplex}, ldx::int_t, d_B::Ptr{doublecomplex}, ldb::int_t, nrhs::Cint, grid::Ptr{gridinfo_t}, SOLVEstruct::Ptr{zSOLVEstruct_t})::Cint
end

function zundo_equilibration_rhs_wrap(B, ldb, m_loc, nrhs, fst_row, notran, rowequ, colequ, ScalePermstruct)
    @ccall libsuperlu_dist_Int32.zundo_equilibration_rhs_wrap(B::Ptr{doublecomplex}, ldb::int_t, m_loc::int_t, nrhs::Cint, fst_row::int_t, notran::Cint, rowequ::Cint, colequ::Cint, ScalePermstruct::Ptr{zScalePermstruct_t})::Cvoid
end

function zscale_and_copy_rhs_wrap(B, ldb, X, ldx, m_loc, nrhs, fst_row, notran, rowequ, colequ, ScalePermstruct)
    @ccall libsuperlu_dist_Int32.zscale_and_copy_rhs_wrap(B::Ptr{doublecomplex}, ldb::int_t, X::Ptr{doublecomplex}, ldx::int_t, m_loc::int_t, nrhs::Cint, fst_row::int_t, notran::Cint, rowequ::Cint, colequ::Cint, ScalePermstruct::Ptr{zScalePermstruct_t})::Cvoid
end

function zdevice_matcopy_wrap(m, nrhs, dst, lddst, src, ldsrc)
    @ccall libsuperlu_dist_Int32.zdevice_matcopy_wrap(m::int_t, nrhs::Cint, dst::Ptr{doublecomplex}, lddst::int_t, src::Ptr{doublecomplex}, ldsrc::int_t)::Cvoid
end

function zdevice_add_to_vec_wrap(dst, src, n)
    @ccall libsuperlu_dist_Int32.zdevice_add_to_vec_wrap(dst::Ptr{doublecomplex}, src::Ptr{doublecomplex}, n::int_t)::Cvoid
end

function ztrs_B_init3d_zero_inactive_gpu_wrap(x, nrhs, nsupers, nlb, ilsum, xsup, superGridMap, nprow, npcol, myrow, mycol)
    @ccall libsuperlu_dist_Int32.ztrs_B_init3d_zero_inactive_gpu_wrap(x::Ptr{doublecomplex}, nrhs::Cint, nsupers::int_t, nlb::int_t, ilsum::Ptr{int_t}, xsup::Ptr{int_t}, superGridMap::Ptr{SupernodeToGridMap_t}, nprow::Cint, npcol::Cint, myrow::Cint, mycol::Cint)::Cvoid
end

function ztrs_X_gather3d_pack_gpu_wrap(packbuf, x, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.ztrs_X_gather3d_pack_gpu_wrap(packbuf::Ptr{doublecomplex}, x::Ptr{doublecomplex}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function ztrs_X_gather3d_unpack_gpu_wrap(x, packbuf, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.ztrs_X_gather3d_unpack_gpu_wrap(x::Ptr{doublecomplex}, packbuf::Ptr{doublecomplex}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function ztrs_X_gather3d_pack_zero_gpu_wrap(packbuf, x, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.ztrs_X_gather3d_pack_zero_gpu_wrap(packbuf::Ptr{doublecomplex}, x::Ptr{doublecomplex}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function ztrs_X_gather3d_unpack_add_gpu_wrap(x, packbuf, offsets, lengths, pack_offsets, nblocks)
    @ccall libsuperlu_dist_Int32.ztrs_X_gather3d_unpack_add_gpu_wrap(x::Ptr{doublecomplex}, packbuf::Ptr{doublecomplex}, offsets::Ptr{int_t}, lengths::Ptr{int_t}, pack_offsets::Ptr{int_t}, nblocks::int_t)::Cvoid
end

function zSolveInit_nvshmem_gpures(options, fst_row, m_loc, nrhs, n, grid, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.zSolveInit_nvshmem_gpures(options::Ptr{superlu_dist_options_t}, fst_row::int_t, m_loc::int_t, nrhs::int_t, n::int_t, grid::Ptr{gridinfo_t}, SOLVEstruct::Ptr{zSOLVEstruct_t})::Cint
end

function zFree_nvshmem_gpures(options, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.zFree_nvshmem_gpures(options::Ptr{superlu_dist_options_t}, SOLVEstruct::Ptr{zSOLVEstruct_t})::Cvoid
end

function sp_ztrsv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.sp_ztrsv_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cchar}, arg3::Ptr{Cchar}, arg4::Ptr{SuperMatrix}, arg5::Ptr{SuperMatrix}, arg6::Ptr{doublecomplex}, arg7::Ptr{Cint})::Cint
end

function sp_zgemv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sp_zgemv_dist(arg1::Ptr{Cchar}, arg2::doublecomplex, arg3::Ptr{SuperMatrix}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::doublecomplex, arg7::Ptr{doublecomplex}, arg8::Cint)::Cint
end

function sp_zgemm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sp_zgemm_dist(arg1::Ptr{Cchar}, arg2::Cint, arg3::doublecomplex, arg4::Ptr{SuperMatrix}, arg5::Ptr{doublecomplex}, arg6::Cint, arg7::doublecomplex, arg8::Ptr{doublecomplex}, arg9::Cint)::Cint
end

function zdistribute(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.zdistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{Glu_freeable_t}, arg5::Ptr{zLUstruct_t}, arg6::Ptr{gridinfo_t})::Cfloat
end

function pzgssvx_ABglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.pzgssvx_ABglobal(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{zScalePermstruct_t}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t}, arg8::Ptr{zLUstruct_t}, arg9::Ptr{Cdouble}, arg10::Ptr{SuperLUStat_t}, arg11::Ptr{Cint})::Cvoid
end

function pzdistribute(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pzdistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{zScalePermstruct_t}, arg5::Ptr{Glu_freeable_t}, arg6::Ptr{zLUstruct_t}, arg7::Ptr{gridinfo_t})::Cfloat
end

function pzdistribute_allgrid(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid, supernodeMask)
    @ccall libsuperlu_dist_Int32.pzdistribute_allgrid(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{zScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{zLUstruct_t}, grid::Ptr{gridinfo_t}, supernodeMask::Ptr{Cint})::Cfloat
end

function pzdistribute_allgrid_index_only(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid, supernodeMask)
    @ccall libsuperlu_dist_Int32.pzdistribute_allgrid_index_only(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{zScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{zLUstruct_t}, grid::Ptr{gridinfo_t}, supernodeMask::Ptr{Cint})::Cfloat
end

function pzgssvx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.pzgssvx(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{zScalePermstruct_t}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t}, arg8::Ptr{zLUstruct_t}, arg9::Ptr{zSOLVEstruct_t}, arg10::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t}, arg12::Ptr{Cint})::Cvoid
end

function pzCompute_Diag_Inv(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.pzCompute_Diag_Inv(arg1::int_t, arg2::Ptr{zLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{Cint})::Cvoid
end

function zSolveInit(arg1, arg2, perm_r, perm_c, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.zSolveInit(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, perm_r::Ptr{Cint}, perm_c::Ptr{Cint}, arg5::int_t, arg6::int_t, arg7::Ptr{zLUstruct_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{zSOLVEstruct_t}, arg10::Ptr{zScalePermstruct_t})::Cint
end

function zSolveFinalize(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zSolveFinalize(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{zSOLVEstruct_t})::Cvoid
end

function zDestroy_A3d_gathered_on_2d(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zDestroy_A3d_gathered_on_2d(arg1::Ptr{zSOLVEstruct_t}, arg2::Ptr{gridinfo3d_t})::Cvoid
end

function pzgstrs_init(arg1, arg2, arg3, arg4, perm_r, perm_c, grid, arg8, arg9)
    @ccall libsuperlu_dist_Int32.pzgstrs_init(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, perm_r::Ptr{Cint}, perm_c::Ptr{Cint}, grid::Ptr{gridinfo_t}, arg8::Ptr{Glu_persist_t}, arg9::Ptr{zSOLVEstruct_t})::int_t
end

function pzgstrs_init_device_lsum_x(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pzgstrs_init_device_lsum_x(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{gridinfo_t}, arg6::Ptr{zLUstruct_t}, arg7::Ptr{zSOLVEstruct_t}, arg8::Ptr{Cint})::int_t
end

function pzgstrs_delete_device_lsum_x(arg1)
    @ccall libsuperlu_dist_Int32.pzgstrs_delete_device_lsum_x(arg1::Ptr{zSOLVEstruct_t})::int_t
end

function zldperm_dist(arg1, arg2, arg3, arg4, arg5, arg6, perm, arg8, arg9)
    @ccall libsuperlu_dist_Int32.zldperm_dist(arg1::Cint, arg2::Cint, arg3::int_t, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{doublecomplex}, perm::Ptr{Cint}, arg8::Ptr{Cdouble}, arg9::Ptr{Cdouble})::Cint
end

function zstatic_schedule(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.zstatic_schedule(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{zLUstruct_t}, arg5::Ptr{gridinfo_t}, arg6::Ptr{SuperLUStat_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Cint})::Cint
end

function zLUstructInit(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zLUstructInit(arg1::int_t, arg2::Ptr{zLUstruct_t})::Cvoid
end

function zLUstructFree(arg1)
    @ccall libsuperlu_dist_Int32.zLUstructFree(arg1::Ptr{zLUstruct_t})::Cvoid
end

function zDestroy_LU(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.zDestroy_LU(arg1::int_t, arg2::Ptr{gridinfo_t}, arg3::Ptr{zLUstruct_t})::Cvoid
end

function zDestroy_Tree(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.zDestroy_Tree(arg1::int_t, arg2::Ptr{gridinfo_t}, arg3::Ptr{zLUstruct_t})::Cvoid
end

function zscatter_l(ib, ljb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, usub, lsub, tempv, indirect_thread, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, grid)
    @ccall libsuperlu_dist_Int32.zscatter_l(ib::Cint, ljb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, usub::Ptr{int_t}, lsub::Ptr{int_t}, tempv::Ptr{doublecomplex}, indirect_thread::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{doublecomplex}}, grid::Ptr{gridinfo_t})::Cvoid
end

function zscatter_u(ib, jb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, lsub, usub, tempv, Ufstnz_br_ptr, Unzval_br_ptr, grid)
    @ccall libsuperlu_dist_Int32.zscatter_u(ib::Cint, jb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, lsub::Ptr{int_t}, usub::Ptr{int_t}, tempv::Ptr{doublecomplex}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{doublecomplex}}, grid::Ptr{gridinfo_t})::Cvoid
end

function pzgstrf(arg1, arg2, arg3, anorm, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pzgstrf(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, anorm::Cdouble, arg5::Ptr{zLUstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SuperLUStat_t}, arg8::Ptr{Cint})::int_t
end

function pzgstrs_Bglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.pzgstrs_Bglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{zLUstruct_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{doublecomplex}, arg6::int_t, arg7::Cint, arg8::Ptr{SuperLUStat_t}, arg9::Ptr{Cint})::Cvoid
end

function pzgstrs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.pzgstrs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{zLUstruct_t}, arg4::Ptr{zScalePermstruct_t}, arg5::Ptr{gridinfo_t}, arg6::Ptr{doublecomplex}, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Cint, arg11::Ptr{zSOLVEstruct_t}, arg12::Ptr{SuperLUStat_t}, arg13::Ptr{Cint})::Cvoid
end

function pzgstrf2_trsm(options, k0, k, thresh, arg5, arg6, arg7, arg8, tag_ub, arg10, info)
    @ccall libsuperlu_dist_Int32.pzgstrf2_trsm(options::Ptr{superlu_dist_options_t}, k0::int_t, k::int_t, thresh::Cdouble, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{zLocalLU_t}, arg8::Ptr{MPI_Request}, tag_ub::Cint, arg10::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pzgstrs2_omp(k0, k, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pzgstrs2_omp(k0::int_t, k::int_t, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{zLocalLU_t}, arg6::Ptr{Ublock_info_t}, arg7::Ptr{SuperLUStat_t})::Cvoid
end

function pzReDistribute_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.pzReDistribute_B_to_X(B::Ptr{doublecomplex}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{doublecomplex}, arg8::Ptr{zScalePermstruct_t}, arg9::Ptr{Glu_persist_t}, arg10::Ptr{gridinfo_t}, arg11::Ptr{zSOLVEstruct_t})::int_t
end

function zlsum_fmod(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.zlsum_fmod(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::int_t, arg11::int_t, arg12::Ptr{int_t}, arg13::Ptr{gridinfo_t}, arg14::Ptr{zLocalLU_t}, arg15::Ptr{MPI_Request}, arg16::Ptr{SuperLUStat_t})::Cvoid
end

function zlsum_bmod(arg1, arg2, arg3, arg4, arg5, bmod, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int32.zlsum_bmod(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Cint, arg5::int_t, bmod::Ptr{Cint}, arg7::Ptr{int_t}, arg8::Ptr{Ptr{Ucb_indptr_t}}, arg9::Ptr{Ptr{int_t}}, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{zLocalLU_t}, arg13::Ptr{MPI_Request}, arg14::Ptr{SuperLUStat_t})::Cvoid
end

function zlsum_fmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, fmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int32.zlsum_fmod_inv(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::int_t, fmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{gridinfo_t}, arg10::Ptr{zLocalLU_t}, arg11::Ptr{Ptr{SuperLUStat_t}}, arg12::Ptr{int_t}, arg13::Ptr{int_t}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function zlsum_fmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int32.zlsum_fmod_inv_master(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{zLocalLU_t}, arg13::Ptr{Ptr{SuperLUStat_t}}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function zlsum_bmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    @ccall libsuperlu_dist_Int32.zlsum_bmod_inv(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{zLocalLU_t}, arg14::Ptr{Ptr{SuperLUStat_t}}, arg15::Ptr{int_t}, arg16::Ptr{int_t}, arg17::int_t, arg18::int_t, arg19::Cint, arg20::Cint)::Cvoid
end

function zlsum_bmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    @ccall libsuperlu_dist_Int32.zlsum_bmod_inv_master(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{zLocalLU_t}, arg14::Ptr{Ptr{SuperLUStat_t}}, arg15::int_t, arg16::int_t, arg17::Cint, arg18::Cint)::Cvoid
end

function zComputeLevelsets(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.zComputeLevelsets(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t}, arg6::Ptr{int_t})::Cvoid
end

function pzconvertU(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.pzconvertU(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{zLUstruct_t}, arg4::Ptr{SuperLUStat_t}, arg5::Cint)::Cvoid
end

function zlsum_fmod_inv_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, fmod, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48)
    @ccall libsuperlu_dist_Int32.zlsum_fmod_inv_gpu_wrap(arg1::Cint, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Ptr{doublecomplex}, arg6::Ptr{doublecomplex}, arg7::Cint, arg8::Cint, arg9::int_t, fmod::Ptr{Cint}, arg11::Ptr{C_Tree}, arg12::Ptr{C_Tree}, arg13::Ptr{int_t}, arg14::Ptr{int_t}, arg15::Ptr{Int64}, arg16::Ptr{doublecomplex}, arg17::Ptr{Int64}, arg18::Ptr{doublecomplex}, arg19::Ptr{Int64}, arg20::Ptr{int_t}, arg21::Ptr{Int64}, arg22::Ptr{int_t}, arg23::Ptr{Cint}, arg24::Ptr{gridinfo_t}, arg25::int_t, arg26::Ptr{UInt64}, arg27::Ptr{UInt64}, arg28::Ptr{doublecomplex}, arg29::Ptr{doublecomplex}, arg30::Ptr{Cint}, arg31::Ptr{Cint}, arg32::Ptr{Cint}, arg33::Ptr{Cint}, arg34::Ptr{Cint}, arg35::Ptr{Cint}, arg36::Ptr{Cint}, arg37::Ptr{Cint}, arg38::Ptr{Cint}, arg39::Ptr{Cint}, arg40::Ptr{Cint}, arg41::Ptr{Cint}, arg42::Ptr{Cint}, arg43::Ptr{Cint}, arg44::Ptr{Cint}, arg45::Ptr{Cint}, arg46::Ptr{Cint}, arg47::Ptr{Cint}, arg48::Cint)::Cvoid
end

function zlsum_bmod_inv_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50, arg51, arg52, arg53, arg54)
    @ccall libsuperlu_dist_Int32.zlsum_bmod_inv_gpu_wrap(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Cint, arg6::Ptr{doublecomplex}, arg7::Ptr{doublecomplex}, arg8::Cint, arg9::Cint, arg10::int_t, arg11::Ptr{Cint}, arg12::Ptr{C_Tree}, arg13::Ptr{C_Tree}, arg14::Ptr{int_t}, arg15::Ptr{int_t}, arg16::Ptr{Int64}, arg17::Ptr{int_t}, arg18::Ptr{Int64}, arg19::Ptr{int_t}, arg20::Ptr{Int64}, arg21::Ptr{doublecomplex}, arg22::Ptr{Int64}, arg23::Ptr{doublecomplex}, arg24::Ptr{Int64}, arg25::Ptr{doublecomplex}, arg26::Ptr{Int64}, arg27::Ptr{int_t}, arg28::Ptr{Int64}, arg29::Ptr{int_t}, arg30::Ptr{gridinfo_t}, arg31::int_t, arg32::Ptr{UInt64}, arg33::Ptr{UInt64}, arg34::Ptr{doublecomplex}, arg35::Ptr{doublecomplex}, arg36::Ptr{Cint}, arg37::Ptr{Cint}, arg38::Ptr{Cint}, arg39::Ptr{Cint}, arg40::Ptr{Cint}, arg41::Ptr{Cint}, arg42::Ptr{Cint}, arg43::Ptr{Cint}, arg44::Ptr{Cint}, arg45::Ptr{Cint}, arg46::Ptr{Cint}, arg47::Ptr{Cint}, arg48::Ptr{Cint}, arg49::Ptr{Cint}, arg50::Ptr{Cint}, arg51::Ptr{Cint}, arg52::Ptr{Cint}, arg53::Ptr{Cint}, arg54::Cint)::Cvoid
end

function pzReDistribute_B_to_X_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    @ccall libsuperlu_dist_Int32.pzReDistribute_B_to_X_gpu_wrap(arg1::Ptr{doublecomplex}, arg2::int_t, arg3::int_t, arg4::Cint, arg5::int_t, arg6::int_t, arg7::Ptr{doublecomplex}, arg8::Ptr{zScalePermstruct_t}, arg9::Ptr{zSOLVEstruct_t}, arg10::Ptr{Glu_persist_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{int_t}, arg14::Ptr{int_t}, arg15::Ptr{int_t})::Cvoid
end

function pzReDistribute_X_to_B_gpu_wrap(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.pzReDistribute_X_to_B_gpu_wrap(arg1::Ptr{doublecomplex}, arg2::int_t, arg3::int_t, arg4::Cint, arg5::int_t, arg6::int_t, arg7::int_t, arg8::Ptr{doublecomplex}, arg9::Ptr{zScalePermstruct_t}, arg10::Ptr{zSOLVEstruct_t}, arg11::Ptr{Glu_persist_t}, arg12::Ptr{gridinfo_t}, arg13::Ptr{gridinfo_t}, arg14::Ptr{int_t}, arg15::Ptr{int_t}, arg16::Ptr{int_t})::Cvoid
end

function pzgsrfs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.pzgsrfs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cdouble, arg5::Ptr{zLUstruct_t}, arg6::Ptr{zScalePermstruct_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{doublecomplex}, arg9::int_t, arg10::Ptr{doublecomplex}, arg11::int_t, arg12::Cint, arg13::Ptr{zSOLVEstruct_t}, arg14::Ptr{Cdouble}, arg15::Ptr{SuperLUStat_t}, arg16::Ptr{Cint})::Cvoid
end

function pzgsrfs3d(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
    @ccall libsuperlu_dist_Int32.pzgsrfs3d(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cdouble, arg5::Ptr{zLUstruct_t}, arg6::Ptr{zScalePermstruct_t}, arg7::Ptr{gridinfo3d_t}, arg8::Ptr{ztrf3Dpartition_t}, arg9::Ptr{doublecomplex}, arg10::int_t, arg11::Ptr{doublecomplex}, arg12::int_t, arg13::Cint, arg14::Ptr{zSOLVEstruct_t}, arg15::Ptr{Cdouble}, arg16::Ptr{SuperLUStat_t}, arg17::Ptr{Cint})::Cvoid
end

function pzgmres(arg1, arg2, arg3, arg4, arg5, arg6, arg7, X, m_loc, fst_row, restart, maxit, rtol, atol, gs, arg16, totit, arg18, arg19)
    @ccall libsuperlu_dist_Int32.pzgmres(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{zLUstruct_t}, arg5::Ptr{zScalePermstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{pzgsmv_comm_t}, X::Ptr{doublecomplex}, m_loc::int_t, fst_row::int_t, restart::Cint, maxit::Cint, rtol::Cdouble, atol::Cdouble, gs::Cint, arg16::Ptr{zSOLVEstruct_t}, totit::Ptr{Cint}, arg18::Ptr{SuperLUStat_t}, arg19::Ptr{Cint})::Cvoid
end

function pzgmres3d(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, X, m_loc, fst_row, restart, maxit, rtol, atol, gs, arg17, totit, arg19, arg20)
    @ccall libsuperlu_dist_Int32.pzgmres3d(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{zLUstruct_t}, arg5::Ptr{zScalePermstruct_t}, arg6::Ptr{gridinfo3d_t}, arg7::Ptr{ztrf3Dpartition_t}, arg8::Ptr{pzgsmv_comm_t}, X::Ptr{doublecomplex}, m_loc::int_t, fst_row::int_t, restart::Cint, maxit::Cint, rtol::Cdouble, atol::Cdouble, gs::Cint, arg17::Ptr{zSOLVEstruct_t}, totit::Ptr{Cint}, arg19::Ptr{SuperLUStat_t}, arg20::Ptr{Cint})::Cvoid
end

function pzgsrfs_ABXglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int32.pzgsrfs_ABXglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cdouble, arg5::Ptr{zLUstruct_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{doublecomplex}, arg8::int_t, arg9::Ptr{doublecomplex}, arg10::int_t, arg11::Cint, arg12::Ptr{Cdouble}, arg13::Ptr{SuperLUStat_t}, arg14::Ptr{Cint})::Cvoid
end

function pzgsmv_AXglobal_setup(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pzgsmv_AXglobal_setup(arg1::Ptr{SuperMatrix}, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{int_t})::Cint
end

function pzgsmv_AXglobal(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.pzgsmv_AXglobal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{doublecomplex}, arg4::Ptr{int_t}, arg5::Ptr{doublecomplex}, arg6::Ptr{doublecomplex})::Cint
end

function pzgsmv_AXglobal_abs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.pzgsmv_AXglobal_abs(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{doublecomplex}, arg4::Ptr{int_t}, arg5::Ptr{doublecomplex}, arg6::Ptr{Cdouble})::Cint
end

function pzgsmv_init(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.pzgsmv_init(arg1::Ptr{SuperMatrix}, arg2::Ptr{int_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{pzgsmv_comm_t})::Cvoid
end

function pzgsmv(arg1, arg2, arg3, arg4, x, ax)
    @ccall libsuperlu_dist_Int32.pzgsmv(arg1::int_t, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t}, arg4::Ptr{pzgsmv_comm_t}, x::Ptr{doublecomplex}, ax::Ptr{doublecomplex})::Cvoid
end

function pzgsmv_finalize(arg1)
    @ccall libsuperlu_dist_Int32.pzgsmv_finalize(arg1::Ptr{pzgsmv_comm_t})::Cvoid
end

function zinitLsumBmod_buff(ns, nrhs, lbmod_buf)
    @ccall libsuperlu_dist_Int32.zinitLsumBmod_buff(ns::int_t, nrhs::Cint, lbmod_buf::Ptr{zlsumBmod_buff_t})::int_t
end

function zleafForestBackSolve3d(options, treeId, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, recvbuf, send_req, nrhs, lbmod_buf, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zleafForestBackSolve3d(options::Ptr{superlu_dist_options_t}, treeId::int_t, n::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{doublecomplex}, lsum::Ptr{doublecomplex}, recvbuf::Ptr{doublecomplex}, send_req::Ptr{MPI_Request}, nrhs::Cint, lbmod_buf::Ptr{zlsumBmod_buff_t}, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function znonLeafForestBackSolve3d(treeId, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, xT_s, recvbuf, send_req, nrhs, lbmod_buf, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.znonLeafForestBackSolve3d(treeId::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{doublecomplex}, lsum::Ptr{doublecomplex}, xT_s::Ptr{zxT_struct}, recvbuf::Ptr{doublecomplex}, send_req::Ptr{MPI_Request}, nrhs::Cint, lbmod_buf::Ptr{zlsumBmod_buff_t}, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function zlasum_bmod_Tree(pTree, cTree, lsum, x, xT_s, nrhs, lbmod_buf, LUstruct, trf3Dpartition, grid3d, stat)
    @ccall libsuperlu_dist_Int32.zlasum_bmod_Tree(pTree::int_t, cTree::int_t, lsum::Ptr{doublecomplex}, x::Ptr{doublecomplex}, xT_s::Ptr{zxT_struct}, nrhs::Cint, lbmod_buf::Ptr{zlsumBmod_buff_t}, LUstruct::Ptr{zLUstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function zlsumForestBsolve(k, treeId, lsum, x, xT_s, nrhs, lbmod_buf, LUstruct, trf3Dpartition, grid3d, stat)
    @ccall libsuperlu_dist_Int32.zlsumForestBsolve(k::int_t, treeId::int_t, lsum::Ptr{doublecomplex}, x::Ptr{doublecomplex}, xT_s::Ptr{zxT_struct}, nrhs::Cint, lbmod_buf::Ptr{zlsumBmod_buff_t}, LUstruct::Ptr{zLUstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function zbCastXk2Pck(k, xT_s, nrhs, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zbCastXk2Pck(k::int_t, xT_s::Ptr{zxT_struct}, nrhs::Cint, LUstruct::Ptr{zLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function zlsumReducePrK(k, x, lsum, recvbuf, nrhs, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zlsumReducePrK(k::int_t, x::Ptr{doublecomplex}, lsum::Ptr{doublecomplex}, recvbuf::Ptr{doublecomplex}, nrhs::Cint, LUstruct::Ptr{zLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function znonLeafForestForwardSolve3d(treeId, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, xT_s, recvbuf, rtemp, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.znonLeafForestForwardSolve3d(treeId::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{doublecomplex}, lsum::Ptr{doublecomplex}, xT_s::Ptr{zxT_struct}, recvbuf::Ptr{doublecomplex}, rtemp::Ptr{doublecomplex}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function zleafForestForwardSolve3d(options, treeId, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x, lsum, recvbuf, rtemp, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zleafForestForwardSolve3d(options::Ptr{superlu_dist_options_t}, treeId::int_t, n::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x::Ptr{doublecomplex}, lsum::Ptr{doublecomplex}, recvbuf::Ptr{doublecomplex}, rtemp::Ptr{doublecomplex}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function ztrs_compute_communication_structure(options, n, LUstruct, supernodeMask, grid)
    @ccall libsuperlu_dist_Int32.ztrs_compute_communication_structure(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{zLUstruct_t}, supernodeMask::Ptr{Cint}, grid::Ptr{gridinfo_t})::Cint
end

function zreduceSolvedX_newsolve(options, treeId, sender, receiver, x, nrhs, trf3Dpartition, LUstruct, grid3d, recvbuf, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zreduceSolvedX_newsolve(options::Ptr{superlu_dist_options_t}, treeId::int_t, sender::int_t, receiver::int_t, x::Ptr{doublecomplex}, nrhs::Cint, trf3Dpartition::Ptr{ztrf3Dpartition_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, recvbuf::Ptr{doublecomplex}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function zlsum_fmod_leaf(treeId, trf3Dpartition, lsum, x, xk, rtemp, nrhs, knsupc, k, fmod, nlb, lptr, luptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zlsum_fmod_leaf(treeId::int_t, trf3Dpartition::Ptr{ztrf3Dpartition_t}, lsum::Ptr{doublecomplex}, x::Ptr{doublecomplex}, xk::Ptr{doublecomplex}, rtemp::Ptr{doublecomplex}, nrhs::Cint, knsupc::Cint, k::int_t, fmod::Ptr{Cint}, nlb::int_t, lptr::int_t, luptr::int_t, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{zLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function zlsum_fmod_leaf_newsolve(trf3Dpartition, lsum, x, xk, rtemp, nrhs, knsupc, k, fmod, nlb, lptr, luptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zlsum_fmod_leaf_newsolve(trf3Dpartition::Ptr{ztrf3Dpartition_t}, lsum::Ptr{doublecomplex}, x::Ptr{doublecomplex}, xk::Ptr{doublecomplex}, rtemp::Ptr{doublecomplex}, nrhs::Cint, knsupc::Cint, k::int_t, fmod::Ptr{Cint}, nlb::int_t, lptr::int_t, luptr::int_t, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{zLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function zlsum_bmod_GG(lsum, x, xk, nrhs, lbmod_buf, k, bmod, Urbs, Ucb_indptr, Ucb_valptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zlsum_bmod_GG(lsum::Ptr{doublecomplex}, x::Ptr{doublecomplex}, xk::Ptr{doublecomplex}, nrhs::Cint, lbmod_buf::Ptr{zlsumBmod_buff_t}, k::int_t, bmod::Ptr{Cint}, Urbs::Ptr{int_t}, Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}, Ucb_valptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{zLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function zlsum_bmod_GG_newsolve(trf3Dpartition, lsum, x, xk, nrhs, lbmod_buf, k, bmod, Urbs, Ucb_indptr, Ucb_valptr, xsup, grid, Llu, send_req, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zlsum_bmod_GG_newsolve(trf3Dpartition::Ptr{ztrf3Dpartition_t}, lsum::Ptr{doublecomplex}, x::Ptr{doublecomplex}, xk::Ptr{doublecomplex}, nrhs::Cint, lbmod_buf::Ptr{zlsumBmod_buff_t}, k::int_t, bmod::Ptr{Cint}, Urbs::Ptr{int_t}, Ucb_indptr::Ptr{Ptr{Ucb_indptr_t}}, Ucb_valptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{zLocalLU_t}, send_req::Ptr{MPI_Request}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::Cvoid
end

function pzReDistribute3d_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, ScalePermstruct, Glu_persist, grid3d, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.pzReDistribute3d_B_to_X(B::Ptr{doublecomplex}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{doublecomplex}, ScalePermstruct::Ptr{zScalePermstruct_t}, Glu_persist::Ptr{Glu_persist_t}, grid3d::Ptr{gridinfo3d_t}, SOLVEstruct::Ptr{zSOLVEstruct_t})::int_t
end

function pzReDistribute3d_X_to_B(n, B, m_loc, ldb, fst_row, nrhs, x, ilsum, ScalePermstruct, Glu_persist, grid3d, SOLVEstruct)
    @ccall libsuperlu_dist_Int32.pzReDistribute3d_X_to_B(n::int_t, B::Ptr{doublecomplex}, m_loc::int_t, ldb::int_t, fst_row::int_t, nrhs::Cint, x::Ptr{doublecomplex}, ilsum::Ptr{int_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, Glu_persist::Ptr{Glu_persist_t}, grid3d::Ptr{gridinfo3d_t}, SOLVEstruct::Ptr{zSOLVEstruct_t})::int_t
end

function pzgstrs3d(arg1, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, B, m_loc, fst_row, ldb, nrhs, SOLVEstruct, stat, info)
    @ccall libsuperlu_dist_Int32.pzgstrs3d(arg1::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, B::Ptr{doublecomplex}, m_loc::int_t, fst_row::int_t, ldb::int_t, nrhs::Cint, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pzgstrs3d_newsolve(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, B, m_loc, fst_row, ldb, nrhs, SOLVEstruct, stat, info)
    @ccall libsuperlu_dist_Int32.pzgstrs3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, B::Ptr{doublecomplex}, m_loc::int_t, fst_row::int_t, ldb::int_t, nrhs::Cint, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pzgsTrBackSolve3d(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, xT_s, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.pzgsTrBackSolve3d(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{doublecomplex}, lsum3d::Ptr{doublecomplex}, xT_s::Ptr{zxT_struct}, recvbuf::Ptr{doublecomplex}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function pzgsTrForwardSolve3d(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, xT_s, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.pzgsTrForwardSolve3d(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{doublecomplex}, lsum3d::Ptr{doublecomplex}, xT_s::Ptr{zxT_struct}, recvbuf::Ptr{doublecomplex}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function pzgsTrForwardSolve3d_newsolve(options, n, LUstruct, ScalePermstruct, trf3Dpartition, grid3d, x3d, lsum3d, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.pzgsTrForwardSolve3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{zLUstruct_t}, ScalePermstruct::Ptr{zScalePermstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{doublecomplex}, lsum3d::Ptr{doublecomplex}, recvbuf::Ptr{doublecomplex}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function pzgsTrBackSolve3d_newsolve(options, n, LUstruct, trf3Dpartition, grid3d, x3d, lsum3d, recvbuf, send_req, nrhs, SOLVEstruct, stat, xtrsTimer)
    @ccall libsuperlu_dist_Int32.pzgsTrBackSolve3d_newsolve(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{zLUstruct_t}, trf3Dpartition::Ptr{ztrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t}, x3d::Ptr{doublecomplex}, lsum3d::Ptr{doublecomplex}, recvbuf::Ptr{doublecomplex}, send_req::Ptr{MPI_Request}, nrhs::Cint, SOLVEstruct::Ptr{zSOLVEstruct_t}, stat::Ptr{SuperLUStat_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function zbroadcastAncestor3d(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zbroadcastAncestor3d(trf3Dpartition::Ptr{ztrf3Dpartition_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zlocalSolveXkYk(trtype, k, x, nrhs, LUstruct, grid, stat)
    @ccall libsuperlu_dist_Int32.zlocalSolveXkYk(trtype::trtype_t, k::int_t, x::Ptr{doublecomplex}, nrhs::Cint, LUstruct::Ptr{zLUstruct_t}, grid::Ptr{gridinfo_t}, stat::Ptr{SuperLUStat_t})::int_t
end

function ziBcastXk2Pck(k, x, nrhs, sendList, send_req, LUstruct, grid, xtrsTimer)
    @ccall libsuperlu_dist_Int32.ziBcastXk2Pck(k::int_t, x::Ptr{doublecomplex}, nrhs::Cint, sendList::Ptr{Ptr{Cint}}, send_req::Ptr{MPI_Request}, LUstruct::Ptr{zLUstruct_t}, grid::Ptr{gridinfo_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function ztrs_B_init3d(nsupers, x, nrhs, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.ztrs_B_init3d(nsupers::int_t, x::Ptr{doublecomplex}, nrhs::Cint, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function ztrs_X_gather3d(options, x, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.ztrs_X_gather3d(options::Ptr{superlu_dist_options_t}, x::Ptr{doublecomplex}, nrhs::Cint, trf3Dpartition::Ptr{ztrf3Dpartition_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function zfsolveReduceLsum3d(treeId, sender, receiver, lsum, recvbuf, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zfsolveReduceLsum3d(treeId::int_t, sender::int_t, receiver::int_t, lsum::Ptr{doublecomplex}, recvbuf::Ptr{doublecomplex}, nrhs::Cint, trf3Dpartition::Ptr{ztrf3Dpartition_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function zbsolve_Xt_bcast(ilvl, xT_s, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zbsolve_Xt_bcast(ilvl::int_t, xT_s::Ptr{zxT_struct}, nrhs::Cint, trf3Dpartition::Ptr{ztrf3Dpartition_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function zp2pSolvedX3d(treeId, sender, receiver, x, nrhs, trf3Dpartition, LUstruct, grid3d, xtrsTimer)
    @ccall libsuperlu_dist_Int32.zp2pSolvedX3d(treeId::int_t, sender::int_t, receiver::int_t, x::Ptr{doublecomplex}, nrhs::Cint, trf3Dpartition::Ptr{ztrf3Dpartition_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, xtrsTimer::Ptr{xtrsTimer_t})::int_t
end

function doublecomplexMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.doublecomplexMalloc_dist(arg1::int_t)::Ptr{doublecomplex}
end

function doublecomplexCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.doublecomplexCalloc_dist(arg1::int_t)::Ptr{doublecomplex}
end

function zuser_malloc_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zuser_malloc_dist(arg1::int_t, arg2::int_t)::Ptr{Cvoid}
end

function zuser_free_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zuser_free_dist(arg1::int_t, arg2::int_t)::Cvoid
end

function zQuerySpace_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zQuerySpace_dist(arg1::int_t, arg2::Ptr{zLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{superlu_dist_mem_usage_t})::int_t
end

function zClone_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zClone_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function zCopy_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zCopy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix})::Cvoid
end

function zZero_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.zZero_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function zScaleAddId_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zScaleAddId_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::doublecomplex)::Cvoid
end

function zScaleAdd_CompRowLoc_Matrix_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.zScaleAdd_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{SuperMatrix}, arg3::doublecomplex)::Cvoid
end

function zZeroLblocks(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.zZeroLblocks(arg1::Cint, arg2::Cint, arg3::Ptr{gridinfo_t}, arg4::Ptr{zLUstruct_t})::Cvoid
end

function zZeroUblocks(iam, n, arg3, arg4)
    @ccall libsuperlu_dist_Int32.zZeroUblocks(iam::Cint, n::Cint, arg3::Ptr{gridinfo_t}, arg4::Ptr{zLUstruct_t})::Cvoid
end

function zMaxAbsLij(iam, n, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zMaxAbsLij(iam::Cint, n::Cint, arg3::Ptr{Glu_persist_t}, arg4::Ptr{zLUstruct_t}, arg5::Ptr{gridinfo_t})::Cdouble
end

function zMaxAbsUij(iam, n, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zMaxAbsUij(iam::Cint, n::Cint, arg3::Ptr{Glu_persist_t}, arg4::Ptr{zLUstruct_t}, arg5::Ptr{gridinfo_t})::Cdouble
end

function zfill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.zfill_dist(arg1::Ptr{doublecomplex}, arg2::int_t, arg3::doublecomplex)::Cvoid
end

function zinf_norm_error_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zinf_norm_error_dist(arg1::int_t, arg2::int_t, arg3::Ptr{doublecomplex}, arg4::int_t, arg5::Ptr{doublecomplex}, arg6::int_t, arg7::Ptr{gridinfo_t})::Cvoid
end

function pzinf_norm_error(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pzinf_norm_error(arg1::Cint, arg2::int_t, arg3::int_t, arg4::Ptr{doublecomplex}, arg5::int_t, arg6::Ptr{doublecomplex}, arg7::int_t, arg8::MPI_Comm)::Cvoid
end

function zreadhb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zreadhb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function zreadtriple_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zreadtriple_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function zreadtriple_noheader(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zreadtriple_noheader(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function zreadrb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zreadrb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function zreadMM_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zreadMM_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function zread_binary(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zread_binary(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cint
end

function zwrite_binary_withname(n, nnz, values, rowind, colptr, newfile)
    @ccall libsuperlu_dist_Int32.zwrite_binary_withname(n::int_t, nnz::int_t, values::Ptr{doublecomplex}, rowind::Ptr{int_t}, colptr::Ptr{int_t}, newfile::Ptr{Cchar})::Cint
end

function validateInput_pzgssvx3d(arg1, A, ldb, nrhs, arg5, info)
    @ccall libsuperlu_dist_Int32.validateInput_pzgssvx3d(arg1::Ptr{superlu_dist_options_t}, A::Ptr{SuperMatrix}, ldb::Cint, nrhs::Cint, arg5::Ptr{gridinfo3d_t}, info::Ptr{Cint})::Cvoid
end

function zallocScalePermstruct_RC(arg1, m, n)
    @ccall libsuperlu_dist_Int32.zallocScalePermstruct_RC(arg1::Ptr{zScalePermstruct_t}, m::int_t, n::int_t)::Cvoid
end

function zscaleMatrixDiagonally(Fact, arg2, arg3, arg4, arg5, rowequ, colequ, iinfo)
    @ccall libsuperlu_dist_Int32.zscaleMatrixDiagonally(Fact::fact_t, arg2::Ptr{zScalePermstruct_t}, arg3::Ptr{SuperMatrix}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{gridinfo_t}, rowequ::Ptr{Cint}, colequ::Ptr{Cint}, iinfo::Ptr{Cint})::Cvoid
end

function zperform_row_permutation(arg1, Fact, arg3, LUstruct, m, n, arg7, A, GA, arg10, job, Equil, rowequ, colequ, iinfo)
    @ccall libsuperlu_dist_Int32.zperform_row_permutation(arg1::Ptr{superlu_dist_options_t}, Fact::fact_t, arg3::Ptr{zScalePermstruct_t}, LUstruct::Ptr{zLUstruct_t}, m::int_t, n::int_t, arg7::Ptr{gridinfo_t}, A::Ptr{SuperMatrix}, GA::Ptr{SuperMatrix}, arg10::Ptr{SuperLUStat_t}, job::Cint, Equil::Cint, rowequ::Ptr{Cint}, colequ::Ptr{Cint}, iinfo::Ptr{Cint})::Cvoid
end

function zcomputeA_Norm(notran, arg2, arg3)
    @ccall libsuperlu_dist_Int32.zcomputeA_Norm(notran::Cint, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t})::Cdouble
end

function zdist_psymbtonum(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zdist_psymbtonum(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{zScalePermstruct_t}, arg5::Ptr{Pslu_freeable_t}, arg6::Ptr{zLUstruct_t}, arg7::Ptr{gridinfo_t})::Cfloat
end

function pzGetDiagU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.pzGetDiagU(arg1::int_t, arg2::Ptr{zLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{doublecomplex})::Cvoid
end

function z_c2cpp_GetHWPM(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.z_c2cpp_GetHWPM(arg1::Ptr{SuperMatrix}, arg2::Ptr{gridinfo_t}, arg3::Ptr{zScalePermstruct_t})::Cint
end

function zPrintLblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zPrintLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t})::Cvoid
end

function zPrintUblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zPrintUblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t})::Cvoid
end

function zPrint_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.zPrint_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function zPrint_CompCol_triplet(arg1)
    @ccall libsuperlu_dist_Int32.zPrint_CompCol_triplet(arg1::Ptr{SuperMatrix})::Cvoid
end

function file_zPrint_NCPformat_triplet(arg1, arg2)
    @ccall libsuperlu_dist_Int32.file_zPrint_NCPformat_triplet(arg1::Ptr{Libc.FILE}, arg2::Ptr{SuperMatrix})::Cvoid
end

function zPrint_Dense_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.zPrint_Dense_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function zPrint_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int32.zPrint_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix})::Cint
end

function file_zPrint_CompRowLoc_Matrix_dist(fp, A)
    @ccall libsuperlu_dist_Int32.file_zPrint_CompRowLoc_Matrix_dist(fp::Ptr{Libc.FILE}, A::Ptr{SuperMatrix})::Cint
end

function PrintDoublecomplex(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.PrintDoublecomplex(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{doublecomplex})::Cvoid
end

function file_PrintDoublecomplex(fp, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.file_PrintDoublecomplex(fp::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{doublecomplex})::Cint
end

function zGenCOOLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.zGenCOOLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{doublecomplex}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function zGenCSCLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.zGenCSCLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function zGenCSRLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.zGenCSRLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function zprepare_multiGPU_buffers(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.zprepare_multiGPU_buffers(arg1::Cint, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Cint, arg6::Cint)::Cvoid
end

# no prototype is found for this function at superlu_zdefs.h:1154:13, please use with caution
function zdelete_multiGPU_buffers()
    @ccall libsuperlu_dist_Int32.zdelete_multiGPU_buffers()::Cvoid
end

function superlu_zgemm(transa, transb, m, n, k, alpha, a, lda, b, ldb, beta, c, ldc)
    @ccall libsuperlu_dist_Int32.superlu_zgemm(transa::Ptr{Cchar}, transb::Ptr{Cchar}, m::Cint, n::Cint, k::Cint, alpha::doublecomplex, a::Ptr{doublecomplex}, lda::Cint, b::Ptr{doublecomplex}, ldb::Cint, beta::doublecomplex, c::Ptr{doublecomplex}, ldc::Cint)::Cint
end

function superlu_ztrsm(sideRL, uplo, transa, diag, m, n, alpha, a, lda, b, ldb)
    @ccall libsuperlu_dist_Int32.superlu_ztrsm(sideRL::Ptr{Cchar}, uplo::Ptr{Cchar}, transa::Ptr{Cchar}, diag::Ptr{Cchar}, m::Cint, n::Cint, alpha::doublecomplex, a::Ptr{doublecomplex}, lda::Cint, b::Ptr{doublecomplex}, ldb::Cint)::Cint
end

function superlu_zger(m, n, alpha, x, incx, y, incy, a, lda)
    @ccall libsuperlu_dist_Int32.superlu_zger(m::Cint, n::Cint, alpha::doublecomplex, x::Ptr{doublecomplex}, incx::Cint, y::Ptr{doublecomplex}, incy::Cint, a::Ptr{doublecomplex}, lda::Cint)::Cint
end

function superlu_zscal(n, alpha, x, incx)
    @ccall libsuperlu_dist_Int32.superlu_zscal(n::Cint, alpha::doublecomplex, x::Ptr{doublecomplex}, incx::Cint)::Cint
end

function superlu_zaxpy(n, alpha, x, incx, y, incy)
    @ccall libsuperlu_dist_Int32.superlu_zaxpy(n::Cint, alpha::doublecomplex, x::Ptr{doublecomplex}, incx::Cint, y::Ptr{doublecomplex}, incy::Cint)::Cint
end

function superlu_zgemv(trans, m, n, alpha, a, lda, x, incx, beta, y, incy)
    @ccall libsuperlu_dist_Int32.superlu_zgemv(trans::Ptr{Cchar}, m::Cint, n::Cint, alpha::doublecomplex, a::Ptr{doublecomplex}, lda::Cint, x::Ptr{doublecomplex}, incx::Cint, beta::doublecomplex, y::Ptr{doublecomplex}, incy::Cint)::Cint
end

function superlu_ztrsv(uplo, trans, diag, n, a, lda, x, incx)
    @ccall libsuperlu_dist_Int32.superlu_ztrsv(uplo::Ptr{Cchar}, trans::Ptr{Cchar}, diag::Ptr{Cchar}, n::Cint, a::Ptr{doublecomplex}, lda::Cint, x::Ptr{doublecomplex}, incx::Cint)::Cint
end

function zcreate_matrix3d(A, nrhs, rhs, ldb, x, ldx, fp, grid3d)
    @ccall libsuperlu_dist_Int32.zcreate_matrix3d(A::Ptr{SuperMatrix}, nrhs::Cint, rhs::Ptr{Ptr{doublecomplex}}, ldb::Ptr{Cint}, x::Ptr{Ptr{doublecomplex}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function zcreate_matrix_postfix3d(A, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.zcreate_matrix_postfix3d(A::Ptr{SuperMatrix}, nrhs::Cint, rhs::Ptr{Ptr{doublecomplex}}, ldb::Ptr{Cint}, x::Ptr{Ptr{doublecomplex}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function zcreate_block_diag_3d(A, batchCount, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.zcreate_block_diag_3d(A::Ptr{SuperMatrix}, batchCount::Cint, nrhs::Cint, rhs::Ptr{Ptr{doublecomplex}}, ldb::Ptr{Cint}, x::Ptr{Ptr{doublecomplex}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function zcreate_batch_systems(SparseMatrix_handles, batchCount, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.zcreate_batch_systems(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, rhs::Ptr{Ptr{doublecomplex}}, ldb::Ptr{Cint}, x::Ptr{Ptr{doublecomplex}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function zcreate_batch_systems_multiple(SparseMatrix_handles, batchCount, nrhs, RHSptr, ldRHS, xtrue, ldX, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.zcreate_batch_systems_multiple(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, RHSptr::Ptr{Ptr{doublecomplex}}, ldRHS::Ptr{Cint}, xtrue::Ptr{Ptr{doublecomplex}}, ldX::Ptr{Cint}, fp::Ptr{Ptr{Libc.FILE}}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function zcreate_batch_systems_rhsfile(SparseMatrix_handles, batchCount, nrhs, RHSptr, ldRHS, xtrue, ldX, fpA, fpB, fpX, postfix, grid3d)
    @ccall libsuperlu_dist_Int32.zcreate_batch_systems_rhsfile(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, nrhs::Cint, RHSptr::Ptr{Ptr{doublecomplex}}, ldRHS::Ptr{Cint}, xtrue::Ptr{Ptr{doublecomplex}}, ldX::Ptr{Cint}, fpA::Ptr{Ptr{Libc.FILE}}, fpB::Ptr{Ptr{Libc.FILE}}, fpX::Ptr{Ptr{Libc.FILE}}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function zbatch_systems_free(SparseMatrix_handles, batchCount, RHSptr, xtrue)
    @ccall libsuperlu_dist_Int32.zbatch_systems_free(SparseMatrix_handles::Ptr{handle_t}, batchCount::Cint, RHSptr::Ptr{Ptr{doublecomplex}}, xtrue::Ptr{Ptr{doublecomplex}})::Cvoid
end

function zGatherNRformat_loc3d(Fact, A, B, ldb, nrhs, grid3d, arg7)
    @ccall libsuperlu_dist_Int32.zGatherNRformat_loc3d(Fact::fact_t, A::Ptr{NRformat_loc}, B::Ptr{doublecomplex}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, arg7::Ptr{Ptr{NRformat_loc3d}})::Cvoid
end

function zGatherNRformat_loc3d_allgrid(options, Fact, A, B, ldb, nrhs, grid3d, arg8)
    @ccall libsuperlu_dist_Int32.zGatherNRformat_loc3d_allgrid(options::Ptr{superlu_dist_options_t}, Fact::fact_t, A::Ptr{NRformat_loc}, B::Ptr{doublecomplex}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, arg8::Ptr{Ptr{NRformat_loc3d}})::Cvoid
end

function zScatter_B3d(options, A3d, grid3d)
    @ccall libsuperlu_dist_Int32.zScatter_B3d(options::Ptr{superlu_dist_options_t}, A3d::Ptr{NRformat_loc3d}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function pzgssvx3d(arg1, arg2, arg3, B, ldb, nrhs, arg7, arg8, arg9, berr, arg11, info)
    @ccall libsuperlu_dist_Int32.pzgssvx3d(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{zScalePermstruct_t}, B::Ptr{doublecomplex}, ldb::Cint, nrhs::Cint, arg7::Ptr{gridinfo3d_t}, arg8::Ptr{zLUstruct_t}, arg9::Ptr{zSOLVEstruct_t}, berr::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pzgstrf3d(arg1, m, n, anorm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.pzgstrf3d(arg1::Ptr{superlu_dist_options_t}, m::Cint, n::Cint, anorm::Cdouble, arg5::Ptr{ztrf3Dpartition_t}, arg6::Ptr{SCT_t}, arg7::Ptr{zLUstruct_t}, arg8::Ptr{gridinfo3d_t}, arg9::Ptr{SuperLUStat_t}, arg10::Ptr{Cint})::int_t
end

function zInit_HyP(arg1, HyP, Llu, mcb, mrb)
    @ccall libsuperlu_dist_Int32.zInit_HyP(arg1::Ptr{superlu_dist_options_t}, HyP::Ptr{HyP_t}, Llu::Ptr{zLocalLU_t}, mcb::int_t, mrb::int_t)::Cvoid
end

function zblock_gemm_scatter(lb, j, Ublock_info, Remain_info, L_mat, ldl, U_mat, ldu, bigV, knsupc, klst, lsub, usub, ldt, thread_id, indirect, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, Ufstnz_br_ptr, Unzval_br_ptr, xsup, arg23, arg24)
    @ccall libsuperlu_dist_Int32.zblock_gemm_scatter(lb::int_t, j::int_t, Ublock_info::Ptr{Ublock_info_t}, Remain_info::Ptr{Remain_info_t}, L_mat::Ptr{doublecomplex}, ldl::Cint, U_mat::Ptr{doublecomplex}, ldu::Cint, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, thread_id::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{doublecomplex}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{doublecomplex}}, xsup::Ptr{int_t}, arg23::Ptr{gridinfo_t}, arg24::Ptr{SuperLUStat_t})::Cvoid
end

function zblock_gemm_scatterTopLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.zblock_gemm_scatterTopLeft(lb::int_t, j::int_t, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{zLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function zblock_gemm_scatterTopRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.zblock_gemm_scatterTopRight(lb::int_t, j::int_t, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{zLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function zblock_gemm_scatterBottomLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.zblock_gemm_scatterBottomLeft(lb::int_t, j::int_t, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{zLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function zblock_gemm_scatterBottomRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int32.zblock_gemm_scatterBottomRight(lb::int_t, j::int_t, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{zLUstruct_t}, arg13::Ptr{gridinfo_t}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t})::int_t
end

function zgather_u(num_u_blks, Ublock_info, usub, uval, bigU, ldu, xsup, klst)
    @ccall libsuperlu_dist_Int32.zgather_u(num_u_blks::int_t, Ublock_info::Ptr{Ublock_info_t}, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, bigU::Ptr{doublecomplex}, ldu::int_t, xsup::Ptr{int_t}, klst::int_t)::Cvoid
end

function zgather_l(num_LBlk, knsupc, L_info, lval, LD_lval, L_buff)
    @ccall libsuperlu_dist_Int32.zgather_l(num_LBlk::int_t, knsupc::int_t, L_info::Ptr{Remain_info_t}, lval::Ptr{doublecomplex}, LD_lval::int_t, L_buff::Ptr{doublecomplex})::Cvoid
end

function zRgather_L(k, lsub, lusup, arg4, arg5, arg6, arg7, myIperm, iperm_c_supno)
    @ccall libsuperlu_dist_Int32.zRgather_L(k::int_t, lsub::Ptr{int_t}, lusup::Ptr{doublecomplex}, arg4::Ptr{gEtreeInfo_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t})::Cvoid
end

function zRgather_U(k, jj0, usub, uval, bigU, arg6, arg7, arg8, arg9, myIperm, iperm_c_supno, perm_u)
    @ccall libsuperlu_dist_Int32.zRgather_U(k::int_t, jj0::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, bigU::Ptr{doublecomplex}, arg6::Ptr{gEtreeInfo_t}, arg7::Ptr{Glu_persist_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, perm_u::Ptr{int_t})::Cvoid
end

function zbcastPermutedSparseA(A, ScalePermstruct, Glu_freeable, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zbcastPermutedSparseA(A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{zScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function znewTrfPartitionInit(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.znewTrfPartitionInit(nsupers::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function zinitTrf3Dpartition(nsupers, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zinitTrf3Dpartition(nsupers::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{ztrf3Dpartition_t}
end

function zinitTrf3Dpartition_allgrid(n, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zinitTrf3Dpartition_allgrid(n::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{ztrf3Dpartition_t}
end

function zinitTrf3DpartitionLUstructgrid0(n, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zinitTrf3DpartitionLUstructgrid0(n::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{ztrf3Dpartition_t}
end

function zDestroy_trf3Dpartition(trf3Dpartition)
    @ccall libsuperlu_dist_Int32.zDestroy_trf3Dpartition(trf3Dpartition::Ptr{ztrf3Dpartition_t})::Cvoid
end

function z3D_printMemUse(trf3Dpartition, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.z3D_printMemUse(trf3Dpartition::Ptr{ztrf3Dpartition_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function zinit3DLUstructForest(myTreeIdxs, myZeroTrIdxs, sForests, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zinit3DLUstructForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t}}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function zgatherAllFactoredLUFr(myZeroTrIdxs, sForests, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zgatherAllFactoredLUFr(myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zLpanelUpdate(off0, nsupc, ublk_ptr, ld_ujrow, lusup, nsupr, arg7)
    @ccall libsuperlu_dist_Int32.zLpanelUpdate(off0::int_t, nsupc::int_t, ublk_ptr::Ptr{doublecomplex}, ld_ujrow::int_t, lusup::Ptr{doublecomplex}, nsupr::int_t, arg7::Ptr{SCT_t})::int_t
end

function zgstrf2(k, diagBlk, LDA, BlockUfactor, LDU, thresh, xsup, options, stat, info)
    @ccall libsuperlu_dist_Int32.zgstrf2(k::int_t, diagBlk::Ptr{doublecomplex}, LDA::int_t, BlockUfactor::Ptr{doublecomplex}, LDU::int_t, thresh::Cdouble, xsup::Ptr{int_t}, options::Ptr{superlu_dist_options_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function Local_Zgstrf2(options, k, thresh, BlockUFactor, arg5, arg6, arg7, arg8, info, arg10)
    @ccall libsuperlu_dist_Int32.Local_Zgstrf2(options::Ptr{superlu_dist_options_t}, k::int_t, thresh::Cdouble, BlockUFactor::Ptr{doublecomplex}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{zLocalLU_t}, arg8::Ptr{SuperLUStat_t}, info::Ptr{Cint}, arg10::Ptr{SCT_t})::Cvoid
end

function zTrs2_GatherU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int32.zTrs2_GatherU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, tempv::Ptr{doublecomplex})::int_t
end

function zTrs2_ScatterU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int32.zTrs2_ScatterU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, tempv::Ptr{doublecomplex})::int_t
end

function zTrs2_GatherTrsmScatter(klst, iukp, rukp, usub, uval, tempv, knsupc, nsupr, lusup, Glu_persist)
    @ccall libsuperlu_dist_Int32.zTrs2_GatherTrsmScatter(klst::int_t, iukp::int_t, rukp::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, tempv::Ptr{doublecomplex}, knsupc::int_t, nsupr::Cint, lusup::Ptr{doublecomplex}, Glu_persist::Ptr{Glu_persist_t})::int_t
end

function pzgstrs2(m, k0, k, Glu_persist, grid, Llu, stat)
    @ccall libsuperlu_dist_Int32.pzgstrs2(m::int_t, k0::int_t, k::int_t, Glu_persist::Ptr{Glu_persist_t}, grid::Ptr{gridinfo_t}, Llu::Ptr{zLocalLU_t}, stat::Ptr{SuperLUStat_t})::Cvoid
end

function pzgstrf2(arg1, nsupers, k0, k, thresh, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.pzgstrf2(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, k0::int_t, k::int_t, thresh::Cdouble, arg6::Ptr{Glu_persist_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{zLocalLU_t}, arg9::Ptr{MPI_Request}, arg10::Cint, arg11::Ptr{SuperLUStat_t}, arg12::Ptr{Cint})::Cvoid
end

function zAllocLlu_3d(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zAllocLlu_3d(nsupers::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function zp3dScatter(n, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.zp3dScatter(n::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function zscatter3dLPanels(nsupers, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.zscatter3dLPanels(nsupers::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function zscatter3dUPanels(nsupers, LUstruct, grid3d, supernodeMask)
    @ccall libsuperlu_dist_Int32.zscatter3dUPanels(nsupers::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, supernodeMask::Ptr{Cint})::int_t
end

function zcollect3dLpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zcollect3dLpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function zcollect3dUpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zcollect3dUpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function zp3dCollect(layer, n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zp3dCollect(layer::int_t, n::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function zzeroSetLU(nnodes, nodeList, arg3, arg4)
    @ccall libsuperlu_dist_Int32.zzeroSetLU(nnodes::int_t, nodeList::Ptr{int_t}, arg3::Ptr{zLUstruct_t}, arg4::Ptr{gridinfo3d_t})::int_t
end

function zAllocGlu_3d(n, nsupers, arg3)
    @ccall libsuperlu_dist_Int32.zAllocGlu_3d(n::int_t, nsupers::int_t, arg3::Ptr{zLUstruct_t})::Cint
end

function zDeAllocLlu_3d(n, arg2, arg3)
    @ccall libsuperlu_dist_Int32.zDeAllocLlu_3d(n::int_t, arg2::Ptr{zLUstruct_t}, arg3::Ptr{gridinfo3d_t})::Cint
end

function zDeAllocGlu_3d(arg1)
    @ccall libsuperlu_dist_Int32.zDeAllocGlu_3d(arg1::Ptr{zLUstruct_t})::Cint
end

function zreduceAncestors3d(sender, receiver, nnodes, nodeList, Lval_buf, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zreduceAncestors3d(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, Lval_buf::Ptr{doublecomplex}, Uval_buf::Ptr{doublecomplex}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zreduceAllAncestors3d(ilvl, myNodeCount, treePerm, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zreduceAllAncestors3d(ilvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}}, LUvsb::Ptr{zLUValSubBuf_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cint
end

function zgatherFactoredLU(sender, receiver, nnodes, nodeList, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zgatherFactoredLU(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, LUvsb::Ptr{zLUValSubBuf_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zgatherAllFactoredLU(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zgatherAllFactoredLU(trf3Dpartition::Ptr{ztrf3Dpartition_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zinit3DLUstruct(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.zinit3DLUstruct(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function zzSendLPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zzSendLPanel(k::int_t, receiver::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zzRecvLPanel(k, sender, alpha, beta, Lval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zzRecvLPanel(k::int_t, sender::int_t, alpha::doublecomplex, beta::doublecomplex, Lval_buf::Ptr{doublecomplex}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zzSendUPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zzSendUPanel(k::int_t, receiver::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zzRecvUPanel(k, sender, alpha, beta, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int32.zzRecvUPanel(k::int_t, sender::int_t, alpha::doublecomplex, beta::doublecomplex, Uval_buf::Ptr{doublecomplex}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::int_t
end

function zIBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, arg7, ToSendR, xsup, arg10)
    @ccall libsuperlu_dist_Int32.zIBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg10::Cint)::int_t
end

function zBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, ToSendR, xsup, arg9, arg10)
    @ccall libsuperlu_dist_Int32.zBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg9::Ptr{SCT_t}, arg10::Cint)::int_t
end

function zIBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, arg7, ToSendD, arg9)
    @ccall libsuperlu_dist_Int32.zIBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendD::Ptr{Cint}, arg9::Cint)::int_t
end

function zBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, ToSendD, arg8, arg9)
    @ccall libsuperlu_dist_Int32.zBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t}, msgcnt::Ptr{Cint}, ToSendD::Ptr{Cint}, arg8::Ptr{SCT_t}, arg9::Cint)::int_t
end

function zIrecv_LPanel(k, k0, Lsub_buf, Lval_buf, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zIrecv_LPanel(k::int_t, k0::int_t, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t}, arg6::Ptr{MPI_Request}, arg7::Ptr{zLocalLU_t}, arg8::Cint)::int_t
end

function zIrecv_UPanel(k, k0, Usub_buf, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zIrecv_UPanel(k::int_t, k0::int_t, Usub_buf::Ptr{int_t}, arg4::Ptr{doublecomplex}, arg5::Ptr{zLocalLU_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{MPI_Request}, arg8::Cint)::int_t
end

function zWait_URecv(arg1, msgcnt, arg3)
    @ccall libsuperlu_dist_Int32.zWait_URecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, arg3::Ptr{SCT_t})::int_t
end

function zWait_LRecv(arg1, msgcnt, msgcntsU, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zWait_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, msgcntsU::Ptr{Cint}, arg4::Ptr{gridinfo_t}, arg5::Ptr{SCT_t})::int_t
end

function zISend_UDiagBlock(k0, ublk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.zISend_UDiagBlock(k0::int_t, ublk_ptr::Ptr{doublecomplex}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Cint)::int_t
end

function zRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{doublecomplex}, size::int_t, src::int_t, arg5::Ptr{gridinfo_t}, arg6::Ptr{SCT_t}, arg7::Cint)::int_t
end

function zPackLBlock(k, Dest, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zPackLBlock(k::int_t, Dest::Ptr{doublecomplex}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{zLocalLU_t})::int_t
end

function zISend_LDiagBlock(k0, lblk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int32.zISend_LDiagBlock(k0::int_t, lblk_ptr::Ptr{doublecomplex}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Cint)::int_t
end

function zIRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zIRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{doublecomplex}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function zIRecv_LDiagBlock(k0, L_blk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zIRecv_LDiagBlock(k0::int_t, L_blk_ptr::Ptr{doublecomplex}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function zUDiagBlockRecvWait(k, IrecvPlcd_D, factored_L, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zUDiagBlockRecvWait(k::int_t, IrecvPlcd_D::Ptr{Cint}, factored_L::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Ptr{zLUstruct_t}, arg7::Ptr{SCT_t})::int_t
end

function zIBcast_UDiagBlock(k, ublk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zIBcast_UDiagBlock(k::int_t, ublk_ptr::Ptr{doublecomplex}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function zIBcast_LDiagBlock(k, lblk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zIBcast_LDiagBlock(k::int_t, lblk_ptr::Ptr{doublecomplex}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function zDiagFactIBCast(k, k0, BlockUFactor, BlockLFactor, IrecvPlcd_D, arg6, arg7, arg8, arg9, arg10, arg11, thresh, LUstruct, arg14, info, arg16, tag_ub)
    @ccall libsuperlu_dist_Int32.zDiagFactIBCast(k::int_t, k0::int_t, BlockUFactor::Ptr{doublecomplex}, BlockLFactor::Ptr{doublecomplex}, IrecvPlcd_D::Ptr{Cint}, arg6::Ptr{MPI_Request}, arg7::Ptr{MPI_Request}, arg8::Ptr{MPI_Request}, arg9::Ptr{MPI_Request}, arg10::Ptr{gridinfo_t}, arg11::Ptr{superlu_dist_options_t}, thresh::Cdouble, LUstruct::Ptr{zLUstruct_t}, arg14::Ptr{SuperLUStat_t}, info::Ptr{Cint}, arg16::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function zUPanelTrSolve(k, BlockLFactor, bigV, ldt, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.zUPanelTrSolve(k::int_t, BlockLFactor::Ptr{doublecomplex}, bigV::Ptr{doublecomplex}, ldt::int_t, arg5::Ptr{Ublock_info_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{zLUstruct_t}, arg8::Ptr{SuperLUStat_t}, arg9::Ptr{SCT_t})::int_t
end

function zLPanelUpdate(k, IrecvPlcd_D, factored_L, arg4, BlockUFactor, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zLPanelUpdate(k::int_t, IrecvPlcd_D::Ptr{Cint}, factored_L::Ptr{Cint}, arg4::Ptr{MPI_Request}, BlockUFactor::Ptr{doublecomplex}, arg6::Ptr{gridinfo_t}, arg7::Ptr{zLUstruct_t}, arg8::Ptr{SCT_t})::int_t
end

function zUPanelUpdate(k, factored_U, arg3, BlockLFactor, bigV, ldt, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.zUPanelUpdate(k::int_t, factored_U::Ptr{Cint}, arg3::Ptr{MPI_Request}, BlockLFactor::Ptr{doublecomplex}, bigV::Ptr{doublecomplex}, ldt::int_t, arg7::Ptr{Ublock_info_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{zLUstruct_t}, arg10::Ptr{SuperLUStat_t}, arg11::Ptr{SCT_t})::int_t
end

function zIBcastRecvLPanel(k, k0, msgcnt, arg4, arg5, Lsub_buf, Lval_buf, factored, arg9, arg10, arg11, tag_ub)
    @ccall libsuperlu_dist_Int32.zIBcastRecvLPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{doublecomplex}, factored::Ptr{Cint}, arg9::Ptr{gridinfo_t}, arg10::Ptr{zLUstruct_t}, arg11::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function zIBcastRecvUPanel(k, k0, msgcnt, arg4, arg5, Usub_buf, Uval_buf, arg8, arg9, arg10, tag_ub)
    @ccall libsuperlu_dist_Int32.zIBcastRecvUPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{doublecomplex}, arg8::Ptr{gridinfo_t}, arg9::Ptr{zLUstruct_t}, arg10::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function zWaitL(k, msgcnt, msgcntU, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.zWaitL(k::int_t, msgcnt::Ptr{Cint}, msgcntU::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t}, arg7::Ptr{zLUstruct_t}, arg8::Ptr{SCT_t})::int_t
end

function zWaitU(k, msgcnt, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zWaitU(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{MPI_Request}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Ptr{zLUstruct_t}, arg7::Ptr{SCT_t})::int_t
end

function zLPanelTrSolve(k, factored_L, BlockUFactor, arg4, arg5)
    @ccall libsuperlu_dist_Int32.zLPanelTrSolve(k::int_t, factored_L::Ptr{Cint}, BlockUFactor::Ptr{doublecomplex}, arg4::Ptr{gridinfo_t}, arg5::Ptr{zLUstruct_t})::int_t
end

function zSchurComplementSetup(k, msgcnt, arg3, arg4, arg5, arg6, arg7, arg8, arg9, bigU, Lsub_buf, Lval_buf, Usub_buf, Uval_buf, arg15, arg16)
    @ccall libsuperlu_dist_Int32.zSchurComplementSetup(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{Ublock_info_t}, arg4::Ptr{Remain_info_t}, arg5::Ptr{uPanelInfo_t}, arg6::Ptr{lPanelInfo_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, bigU::Ptr{doublecomplex}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{doublecomplex}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{doublecomplex}, arg15::Ptr{gridinfo_t}, arg16::Ptr{zLUstruct_t})::int_t
end

function zSchurComplementSetupGPU(k, msgs, arg3, arg4, arg5, arg6, arg7, arg8, arg9, LUvsb, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int32.zSchurComplementSetupGPU(k::int_t, msgs::Ptr{msgs_t}, arg3::Ptr{packLUInfo_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{gEtreeInfo_t}, arg8::Ptr{factNodelists_t}, arg9::Ptr{zscuBufs_t}, LUvsb::Ptr{zLUValSubBuf_t}, arg11::Ptr{gridinfo_t}, arg12::Ptr{zLUstruct_t}, arg13::Ptr{HyP_t})::int_t
end

function zgetBigV(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zgetBigV(arg1::int_t, arg2::int_t)::Ptr{doublecomplex}
end

function zgetBigU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int32.zgetBigU(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{gridinfo_t}, arg4::Ptr{zLUstruct_t})::Ptr{doublecomplex}
end

function zLluBufInit(arg1, arg2)
    @ccall libsuperlu_dist_Int32.zLluBufInit(arg1::Ptr{zLUValSubBuf_t}, arg2::Ptr{zLUstruct_t})::int_t
end

function zinitScuBufs(arg1, ldt, num_threads, nsupers, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.zinitScuBufs(arg1::Ptr{superlu_dist_options_t}, ldt::int_t, num_threads::int_t, nsupers::int_t, arg5::Ptr{zscuBufs_t}, arg6::Ptr{zLUstruct_t}, arg7::Ptr{gridinfo_t})::int_t
end

function zfreeScuBufs(scuBufs)
    @ccall libsuperlu_dist_Int32.zfreeScuBufs(scuBufs::Ptr{zscuBufs_t})::Cint
end

function zsparseTreeFactor(nnodes, perm_c_supno, treeTopoInfo, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, info)
    @ccall libsuperlu_dist_Int32.zsparseTreeFactor(nnodes::int_t, perm_c_supno::Ptr{int_t}, treeTopoInfo::Ptr{treeTopoInfo_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{zscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgs::Ptr{msgs_t}, LUvsb::Ptr{zLUValSubBuf_t}, dFBuf::Ptr{zdiagFactBufs_t}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, info::Ptr{Cint})::int_t
end

function zdenseTreeFactor(nnnodes, perm_c_supno, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int32.zdenseTreeFactor(nnnodes::int_t, perm_c_supno::Ptr{int_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{zscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgs::Ptr{msgs_t}, LUvsb::Ptr{zLUValSubBuf_t}, dFBuf::Ptr{zdiagFactBufs_t}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function zsparseTreeFactor_ASYNC(sforest, comReqss, scuBufs, packLUInfo, msgss, LUvsbs, dFBufs, factStat, fNlists, gEtreeInfo, options, gIperm_c_supno, ldt, HyP, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int32.zsparseTreeFactor_ASYNC(sforest::Ptr{sForest_t}, comReqss::Ptr{Ptr{commRequests_t}}, scuBufs::Ptr{zscuBufs_t}, packLUInfo::Ptr{packLUInfo_t}, msgss::Ptr{Ptr{msgs_t}}, LUvsbs::Ptr{Ptr{zLUValSubBuf_t}}, dFBufs::Ptr{Ptr{zdiagFactBufs_t}}, factStat::Ptr{factStat_t}, fNlists::Ptr{factNodelists_t}, gEtreeInfo::Ptr{gEtreeInfo_t}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, HyP::Ptr{HyP_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function zLluBufInitArr(numLA, LUstruct)
    @ccall libsuperlu_dist_Int32.zLluBufInitArr(numLA::int_t, LUstruct::Ptr{zLUstruct_t})::Ptr{Ptr{zLUValSubBuf_t}}
end

function zLluBufFreeArr(numLA, LUvsbs)
    @ccall libsuperlu_dist_Int32.zLluBufFreeArr(numLA::int_t, LUvsbs::Ptr{Ptr{zLUValSubBuf_t}})::Cint
end

function zinitDiagFactBufsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_dist_Int32.zinitDiagFactBufsArr(mxLeafNode::Cint, ldt::Cint, grid::Ptr{gridinfo_t})::Ptr{Ptr{zdiagFactBufs_t}}
end

function zinitDiagFactBufsArrMod(mxLeafNode, ldts, grid)
    @ccall libsuperlu_dist_Int32.zinitDiagFactBufsArrMod(mxLeafNode::Cint, ldts::Ptr{Cint}, grid::Ptr{gridinfo_t})::Ptr{Ptr{zdiagFactBufs_t}}
end

function zfreeDiagFactBufsArr(mxLeafNode, dFBufs)
    @ccall libsuperlu_dist_Int32.zfreeDiagFactBufsArr(mxLeafNode::Cint, dFBufs::Ptr{Ptr{zdiagFactBufs_t}})::Cint
end

function zinitDiagFactBufs(ldt, dFBuf)
    @ccall libsuperlu_dist_Int32.zinitDiagFactBufs(ldt::Cint, dFBuf::Ptr{zdiagFactBufs_t})::Cint
end

function pzflatten_LDATA(options, n, LUstruct, grid)
    @ccall libsuperlu_dist_Int32.pzflatten_LDATA(options::Ptr{superlu_dist_options_t}, n::int_t, LUstruct::Ptr{zLUstruct_t}, grid::Ptr{gridinfo_t})::Cint
end

function pzconvert_flatten_skyline2UROWDATA(arg1, arg2, arg3, arg4, n)
    @ccall libsuperlu_dist_Int32.pzconvert_flatten_skyline2UROWDATA(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{zLUstruct_t}, arg4::Ptr{SuperLUStat_t}, n::Cint)::Cvoid
end

function pzconvertUROWDATA2skyline(arg1, arg2, arg3, arg4, n)
    @ccall libsuperlu_dist_Int32.pzconvertUROWDATA2skyline(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{gridinfo_t}, arg3::Ptr{zLUstruct_t}, arg4::Ptr{SuperLUStat_t}, n::Cint)::Cvoid
end

function zReDistribute_A(A, ScalePermstruct, Glu_freeable, xsup, supno, grid, colptr, rowind, a)
    @ccall libsuperlu_dist_Int32.zReDistribute_A(A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{zScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, xsup::Ptr{int_t}, supno::Ptr{int_t}, grid::Ptr{gridinfo_t}, colptr::Ptr{Ptr{int_t}}, rowind::Ptr{Ptr{int_t}}, a::Ptr{Ptr{doublecomplex}})::int_t
end

function pzdistribute3d(options, n, A, ScalePermstruct, Glu_freeable, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.pzdistribute3d(options::Ptr{superlu_dist_options_t}, n::int_t, A::Ptr{SuperMatrix}, ScalePermstruct::Ptr{zScalePermstruct_t}, Glu_freeable::Ptr{Glu_freeable_t}, LUstruct::Ptr{zLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Cfloat
end

function pzgssvx3d_csc_batch(arg1, batchCount, m, n, nnz, nrhs, arg7, RHSptr, ldRHS, ReqPtr, CeqPtr, RpivPtr, CpivPtr, DiagScale, F, Xptr, ldX, Berrs, grid3d, stat, info)
    @ccall libsuperlu_dist_Int32.pzgssvx3d_csc_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, nnz::Cint, nrhs::Cint, arg7::Ptr{handle_t}, RHSptr::Ptr{Ptr{doublecomplex}}, ldRHS::Ptr{Cint}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, RpivPtr::Ptr{Ptr{Cint}}, CpivPtr::Ptr{Ptr{Cint}}, DiagScale::Ptr{DiagScale_t}, F::Ptr{handle_t}, Xptr::Ptr{Ptr{doublecomplex}}, ldX::Ptr{Cint}, Berrs::Ptr{Ptr{Cdouble}}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cint
end

function zequil_batch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8)
    @ccall libsuperlu_dist_Int32.zequil_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, arg8::Ptr{DiagScale_t})::Cint
end

function zpivot_batch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, RpivPtr)
    @ccall libsuperlu_dist_Int32.zpivot_batch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Cint, n::Cint, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, arg8::Ptr{DiagScale_t}, RpivPtr::Ptr{Ptr{Cint}})::Cint
end

function pzgssvx3d_csc_vbatch(arg1, batchCount, m, n, nnz, nrhs, arg7, RHSptr, ldRHS, ReqPtr, CeqPtr, RpivPtr, CpivPtr, DiagScale, F, Xptr, ldX, Berrs, grid3d, stat, info)
    @ccall libsuperlu_dist_Int32.pzgssvx3d_csc_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, nnz::Ptr{Cint}, nrhs::Cint, arg7::Ptr{handle_t}, RHSptr::Ptr{Ptr{doublecomplex}}, ldRHS::Ptr{Cint}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, RpivPtr::Ptr{Ptr{Cint}}, CpivPtr::Ptr{Ptr{Cint}}, DiagScale::Ptr{DiagScale_t}, F::Ptr{handle_t}, Xptr::Ptr{Ptr{doublecomplex}}, ldX::Ptr{Cint}, Berrs::Ptr{Ptr{Cdouble}}, grid3d::Ptr{gridinfo3d_t}, stat::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cint
end

function zvbatch_free(F)
    @ccall libsuperlu_dist_Int32.zvbatch_free(F::Ptr{handle_t})::Cvoid
end

function zequil_vbatch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, info)
    @ccall libsuperlu_dist_Int32.zequil_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, arg8::Ptr{DiagScale_t}, info::Ptr{Cint})::Cint
end

function zpivot_vbatch(arg1, batchCount, m, n, arg5, ReqPtr, CeqPtr, arg8, RpivPtr, info)
    @ccall libsuperlu_dist_Int32.zpivot_vbatch(arg1::Ptr{superlu_dist_options_t}, batchCount::Cint, m::Ptr{Cint}, n::Ptr{Cint}, arg5::Ptr{handle_t}, ReqPtr::Ptr{Ptr{Cdouble}}, CeqPtr::Ptr{Ptr{Cdouble}}, arg8::Ptr{DiagScale_t}, RpivPtr::Ptr{Ptr{Cint}}, info::Ptr{Cint})::Cint
end

function zwriteLUtoDisk(nsupers, xsup, LUstruct)
    @ccall libsuperlu_dist_Int32.zwriteLUtoDisk(nsupers::Cint, xsup::Ptr{int_t}, LUstruct::Ptr{zLUstruct_t})::Cint
end

function zcheckArr(A, B, n)
    @ccall libsuperlu_dist_Int32.zcheckArr(A::Ptr{doublecomplex}, B::Ptr{doublecomplex}, n::Cint)::Cint
end

function zcheckLUFromDisk(nsupers, xsup, LUstruct)
    @ccall libsuperlu_dist_Int32.zcheckLUFromDisk(nsupers::Cint, xsup::Ptr{int_t}, LUstruct::Ptr{zLUstruct_t})::Cint
end

function zDumpLblocks3D(nsupers, grid3d, Glu_persist, Llu)
    @ccall libsuperlu_dist_Int32.zDumpLblocks3D(nsupers::int_t, grid3d::Ptr{gridinfo3d_t}, Glu_persist::Ptr{Glu_persist_t}, Llu::Ptr{zLocalLU_t})::Cvoid
end

function zDumpUblocks3D(nsupers, grid3d, Glu_persist, Llu)
    @ccall libsuperlu_dist_Int32.zDumpUblocks3D(nsupers::int_t, grid3d::Ptr{gridinfo3d_t}, Glu_persist::Ptr{Glu_persist_t}, Llu::Ptr{zLocalLU_t})::Cvoid
end

const SUPERLU_DIST_MAJOR_VERSION = 9

const SUPERLU_DIST_MINOR_VERSION = 3

const SUPERLU_DIST_PATCH_VERSION = 0

const SUPERLU_DIST_RELEASE_DATE = "September, 2026"

const TRUE = 1

const HAVE_CUDA = TRUE

const HAVE_PARMETIS = TRUE

const SLU_HAVE_LAPACK = TRUE

const XSDK_INDEX_SIZE = 32

const IFMT = "%8d"

const LargeDiag_AWPM = LargeDiag_HWPM

const SLU_EMPTY = -1

const FALSE = 0

const MAX_3D_LEVEL = 32

const CBLOCK = 192

const CACHE_LINE_SIZE = 8

const CSTEPPING = 8

const NO_MARKER = 3

const tag_interLvl = 2

const tag_interLvl_LData = 0

const tag_interLvl_UData = 1

const tag_intraLvl_szMsg = 1000

const tag_intraLvl_LData = 1001

const tag_intraLvl_UData = 1002

const tag_intraLvl = 1003

const DIAG_IND = 0

const NELTS_IND = 1

const RCVD_IND = 2

const SUCCES_RET = 0

const ERROR_RET = 1

const FILLED_SEP = 2

const FILLED_SEPS = 3

const USUB_PR = 0

const LSUB_PR = 1

const RL_SYMB = 0

const DOMAIN_SYMB = 1

const LL_SYMB = 2

const DNS_UPSEPS = 3

const DNS_CURSEP = 4

const MAX_SUPER_SIZE = 512

const BC_HEADER = 2

const LB_DESCRIPTOR = 2

const BR_HEADER = 3

const UB_DESCRIPTOR = 2

const BC_HEADER_NEWU = 3

const UB_DESCRIPTOR_NEWU = 2

const UB_DESCRIPTOR_NEWUCPP = 3

const NBUFFERS = 5

const NTAGS = INT_MAX

const UjROW = 10

const UkSUB = 11

const UkVAL = 12

const LkSUB = 13

const LkVAL = 14

const LkkDIAG = 15

const GSUM = 20

const Xk = 21

const Yk = 22

const LSUM = 23

const COMM_ALL = 100

const COMM_COLUMN = 101

const COMM_ROW = 102

const SUPER_LINEAR = 11

const SUPER_BLOCK = 12

const SuperLU_timer_ = SuperLU_timer_dist_

const DIM_X = 16

const DIM_Y = 16

const DIM_XA = DIM_X

const DIM_YA = DIM_Y

const DIM_XB = DIM_X

const DIM_YB = DIM_Y

const WARP_SIZE = 32

const NWARP = (DIM_X * DIM_Y) ÷ WARP_SIZE

const HANDLE_SIZE = 8

const DEG_TREE = 2

const MAX_LOOKAHEADS = 50



end # module
