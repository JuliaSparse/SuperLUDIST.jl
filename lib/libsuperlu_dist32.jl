import MPI: MPI_Comm, MPI_Request, MPI_Datatype, MPI_Errhandler


function superlu_abort_and_exit_dist(arg1)
    @ccall libsuperlu_defs.superlu_abort_and_exit_dist(arg1::Ptr{Cchar})::Cvoid
end

function superlu_malloc_dist(arg1)
    @ccall libsuperlu_defs.superlu_malloc_dist(arg1::Csize_t)::Ptr{Cvoid}
end

function superlu_free_dist(arg1)
    @ccall libsuperlu_defs.superlu_free_dist(arg1::Ptr{Cvoid})::Cvoid
end

const int_t = Cint

# no prototype is found for this function at superlu_defs.h:1116:15, please use with caution
function SuperLU_timer_dist_()
    @ccall libsuperlu_defs.SuperLU_timer_dist_()::Cdouble
end

@enum yes_no_t::UInt32 begin
    NO = 0
    YES = 1
end

@enum fact_t::UInt32 begin
    DOFACT = 0
    SamePattern = 1
    SamePattern_SameRowPerm = 2
    FACTORED = 3
end

@enum rowperm_t::UInt32 begin
    NOROWPERM = 0
    LargeDiag_MC64 = 1
    LargeDiag_HWPM = 2
    MY_PERMR = 3
end

@enum colperm_t::UInt32 begin
    NATURAL = 0
    MMD_ATA = 1
    MMD_AT_PLUS_A = 2
    COLAMD = 3
    METIS_AT_PLUS_A = 4
    PARMETIS = 5
    ZOLTAN = 6
    MY_PERMC = 7
end

@enum trans_t::UInt32 begin
    NOTRANS = 0
    TRANS = 1
    CONJ = 2
end

@enum DiagScale_t::UInt32 begin
    NOEQUIL = 0
    ROW = 1
    COL = 2
    BOTH = 3
end

@enum IterRefine_t::UInt32 begin
    NOREFINE = 0
    SLU_SINGLE = 1
    SLU_DOUBLE = 2
    SLU_EXTRA = 3
end

@enum MemType::UInt32 begin
    USUB = 0
    LSUB = 1
    UCOL = 2
    LUSUP = 3
    LLVL = 4
    ULVL = 5
    NO_MEMTYPE = 6
end

@enum stack_end_t::UInt32 begin
    HEAD = 0
    TAIL = 1
end

@enum LU_space_t::UInt32 begin
    SYSTEM = 0
    USER = 1
end

@enum norm_t::UInt32 begin
    ONE_NORM = 0
    TWO_NORM = 1
    INF_NORM = 2
end

@enum milu_t::UInt32 begin
    SILU = 0
    SMILU_1 = 1
    SMILU_2 = 2
    SMILU_3 = 3
end

@enum rule_t::UInt32 begin
    NODROP = 0
    DROP_BASIC = 1
    DROP_PROWS = 2
    DROP_COLUMN = 4
    DROP_AREA = 8
    DROP_SECONDARY = 14
    DROP_DYNAMIC = 16
    DROP_INTERP = 256
end

@enum PhaseType::UInt32 begin
    COLPERM = 0
    ROWPERM = 1
    RELAX = 2
    ETREE = 3
    EQUIL = 4
    SYMBFAC = 5
    DIST = 6
    FACT = 7
    COMM = 8
    COMM_DIAG = 9
    COMM_RIGHT = 10
    COMM_DOWN = 11
    SOL_COMM = 12
    SOL_GEMM = 13
    SOL_TRSM = 14
    SOL_TOT = 15
    RCOND = 16
    SOLVE = 17
    REFINE = 18
    TRSV = 19
    GEMV = 20
    FERR = 21
    NPHASES = 22
end

@enum Stype_t::UInt32 begin
    SLU_NC = 0
    SLU_NCP = 1
    SLU_NR = 2
    SLU_SC = 3
    SLU_SCP = 4
    SLU_SR = 5
    SLU_DN = 6
    SLU_NR_loc = 7
end

@enum Dtype_t::UInt32 begin
    SLU_S = 0
    SLU_D = 1
    SLU_C = 2
    SLU_Z = 3
end

@enum Mtype_t::UInt32 begin
    SLU_GE = 0
    SLU_TRLU = 1
    SLU_TRUU = 2
    SLU_TRL = 3
    SLU_TRU = 4
    SLU_SYL = 5
    SLU_SYU = 6
    SLU_HEL = 7
    SLU_HEU = 8
end

struct SuperMatrix
    Stype::Stype_t
    Dtype::Dtype_t
    Mtype::Mtype_t
    nrow::int_t
    ncol::int_t
    Store::Ptr{Cvoid}
end

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
    pdgstrfTimer::Cdouble
    Local_Dgstrf2_Thread_tl::Ptr{Cdouble}
    Wait_UDiagBlock_Recv_tl::Cdouble
    Wait_LDiagBlock_Recv_tl::Cdouble
    Recv_UDiagBlock_tl::Cdouble
    Wait_UDiagBlockSend_tl::Cdouble
    L_PanelUpdate_tl::Cdouble
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
    commVolFactor::Cdouble
    commVolRed::Cdouble
end

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
    ILU_DropRule::Cint
    ILU_DropTol::Cdouble
    ILU_FillFactor::Cdouble
    ILU_Norm::norm_t
    ILU_FillTol::Cdouble
    ILU_MILU::milu_t
    ILU_MILU_Dim::Cdouble
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
    superlu_max_buffer_size::Cint
    superlu_num_gpu_streams::Cint
    superlu_acc_offload::Cint
    SymPattern::yes_no_t
    Use_TensorCore::yes_no_t
    Algo3d::yes_no_t
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
    factored::Ptr{int_t}
    factored_D::Ptr{int_t}
    factored_L::Ptr{int_t}
    factored_U::Ptr{int_t}
    IrecvPlcd_D::Ptr{int_t}
    IbcastPanel_L::Ptr{int_t}
    IbcastPanel_U::Ptr{int_t}
    numChildLeft::Ptr{int_t}
    gpuLUreduced::Ptr{int_t}
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

@enum treePartStrat::UInt32 begin
    ND = 0
    GD = 1
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
    t_pdReDistribute_X_to_B::Cdouble
    t_pdReDistribute_B_to_X::Cdouble
    t_forwardSolve::Cdouble
    tfs_compute::Cdouble
    tfs_comm::Cdouble
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
    @ccall libsuperlu_defs.superlu_gridinit(arg1::MPI_Comm, arg2::Cint, arg3::Cint, arg4::Ptr{gridinfo_t})::Cvoid
end

function superlu_gridmap(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.superlu_gridmap(arg1::MPI_Comm, arg2::Cint, arg3::Cint, arg4::Ptr{Cint}, arg5::Cint, arg6::Ptr{gridinfo_t})::Cvoid
end

function superlu_gridexit(arg1)
    @ccall libsuperlu_defs.superlu_gridexit(arg1::Ptr{gridinfo_t})::Cvoid
end

function superlu_gridinit3d(Bcomm, nprow, npcol, npdep, grid)
    @ccall libsuperlu_defs.superlu_gridinit3d(Bcomm::MPI_Comm, nprow::Cint, npcol::Cint, npdep::Cint, grid::Ptr{gridinfo3d_t})::Cvoid
end

function superlu_gridexit3d(grid)
    @ccall libsuperlu_defs.superlu_gridexit3d(grid::Ptr{gridinfo3d_t})::Cvoid
end

function set_default_options_dist(arg1)
    @ccall libsuperlu_defs.set_default_options_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function print_options_dist(arg1)
    @ccall libsuperlu_defs.print_options_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function print_sp_ienv_dist(arg1)
    @ccall libsuperlu_defs.print_sp_ienv_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function Destroy_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_defs.Destroy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_SuperNode_Matrix_dist(arg1)
    @ccall libsuperlu_defs.Destroy_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_SuperMatrix_Store_dist(arg1)
    @ccall libsuperlu_defs.Destroy_SuperMatrix_Store_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_CompCol_Permuted_dist(arg1)
    @ccall libsuperlu_defs.Destroy_CompCol_Permuted_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_defs.Destroy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function Destroy_CompRow_Matrix_dist(arg1)
    @ccall libsuperlu_defs.Destroy_CompRow_Matrix_dist(arg1::Ptr{SuperMatrix})::Cvoid
end

function sp_colorder(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_defs.sp_colorder(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{SuperMatrix})::Cvoid
end

function sp_symetree_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_defs.sp_symetree_dist(arg1::Ptr{int_t}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::int_t, arg5::Ptr{int_t})::Cint
end

function sp_coletree_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.sp_coletree_dist(arg1::Ptr{int_t}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::int_t, arg5::int_t, arg6::Ptr{int_t})::Cint
end

function get_perm_c_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.get_perm_c_dist(arg1::int_t, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Ptr{int_t})::Cvoid
end

function at_plus_a_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_defs.at_plus_a_dist(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function genmmd_dist_(arg1, arg2, a, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_defs.genmmd_dist_(arg1::Ptr{int_t}, arg2::Ptr{int_t}, a::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Ptr{int_t}, arg12::Ptr{int_t})::Cint
end

function bcast_tree(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_defs.bcast_tree(arg1::Ptr{Cvoid}, arg2::Cint, arg3::MPI_Datatype, arg4::Cint, arg5::Cint, arg6::Ptr{gridinfo_t}, arg7::Cint, arg8::Ptr{Cint})::Cvoid
end

function symbfact(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_defs.symbfact(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Ptr{SuperMatrix}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Glu_persist_t}, arg7::Ptr{Glu_freeable_t})::int_t
end

function symbfact_SubInit(options, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_defs.symbfact_SubInit(options::Ptr{superlu_dist_options_t}, arg2::fact_t, arg3::Ptr{Cvoid}, arg4::int_t, arg5::int_t, arg6::int_t, arg7::int_t, arg8::Ptr{Glu_persist_t}, arg9::Ptr{Glu_freeable_t})::int_t
end

function symbfact_SubXpand(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.symbfact_SubXpand(arg1::int_t, arg2::int_t, arg3::int_t, arg4::MemType, arg5::Ptr{int_t}, arg6::Ptr{Glu_freeable_t})::int_t
end

function symbfact_SubFree(arg1)
    @ccall libsuperlu_defs.symbfact_SubFree(arg1::Ptr{Glu_freeable_t})::int_t
end

function countnz_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.countnz_dist(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{Glu_freeable_t})::Cvoid
end

function fixupL_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.fixupL_dist(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{Glu_freeable_t})::Int64
end

function TreePostorder_dist(arg1, arg2)
    @ccall libsuperlu_defs.TreePostorder_dist(arg1::int_t, arg2::Ptr{int_t})::Ptr{int_t}
end

function smach_dist(arg1)
    @ccall libsuperlu_defs.smach_dist(arg1::Ptr{Cchar})::Cfloat
end

function dmach_dist(arg1)
    @ccall libsuperlu_defs.dmach_dist(arg1::Ptr{Cchar})::Cdouble
end

function int32Malloc_dist(arg1)
    @ccall libsuperlu_defs.int32Malloc_dist(arg1::Cint)::Ptr{Cint}
end

function int32Calloc_dist(arg1)
    @ccall libsuperlu_defs.int32Calloc_dist(arg1::Cint)::Ptr{Cint}
end

function intMalloc_dist(arg1)
    @ccall libsuperlu_defs.intMalloc_dist(arg1::int_t)::Ptr{int_t}
end

function intCalloc_dist(arg1)
    @ccall libsuperlu_defs.intCalloc_dist(arg1::int_t)::Ptr{int_t}
end

function mc64id_dist(arg1)
    @ccall libsuperlu_defs.mc64id_dist(arg1::Ptr{Cint})::Cint
end

function arrive_at_ublock(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_defs.arrive_at_ublock(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::int_t, arg8::int_t, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t})::Cvoid
end

function estimate_bigu_size(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.estimate_bigu_size(arg1::int_t, arg2::Ptr{Ptr{int_t}}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t})::int_t
end

function sp_ienv_dist(arg1, arg2)
    @ccall libsuperlu_defs.sp_ienv_dist(arg1::Cint, arg2::Ptr{superlu_dist_options_t})::Cint
end

function ifill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_defs.ifill_dist(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t)::Cvoid
end

function super_stats_dist(arg1, arg2)
    @ccall libsuperlu_defs.super_stats_dist(arg1::int_t, arg2::Ptr{int_t})::Cvoid
end

function get_diag_procs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.get_diag_procs(arg1::int_t, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{int_t}})::Cvoid
end

function QuerySpace_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.QuerySpace_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Glu_freeable_t}, arg4::Ptr{superlu_dist_mem_usage_t})::int_t
end

function xerr_dist(arg1, arg2)
    @ccall libsuperlu_defs.xerr_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cint})::Cint
end

function pxerr_dist(arg1, arg2, arg3)
    @ccall libsuperlu_defs.pxerr_dist(arg1::Ptr{Cchar}, arg2::Ptr{gridinfo_t}, arg3::int_t)::Cvoid
end

function PStatInit(arg1)
    @ccall libsuperlu_defs.PStatInit(arg1::Ptr{SuperLUStat_t})::Cvoid
end

function PStatFree(arg1)
    @ccall libsuperlu_defs.PStatFree(arg1::Ptr{SuperLUStat_t})::Cvoid
end

function PStatPrint(arg1, arg2, arg3)
    @ccall libsuperlu_defs.PStatPrint(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperLUStat_t}, arg3::Ptr{gridinfo_t})::Cvoid
end

function log_memory(arg1, arg2)
    @ccall libsuperlu_defs.log_memory(arg1::Int64, arg2::Ptr{SuperLUStat_t})::Cvoid
end

function print_memorylog(arg1, arg2)
    @ccall libsuperlu_defs.print_memorylog(arg1::Ptr{SuperLUStat_t}, arg2::Ptr{Cchar})::Cvoid
end

function superlu_dist_GetVersionNumber(arg1, arg2, arg3)
    @ccall libsuperlu_defs.superlu_dist_GetVersionNumber(arg1::Ptr{Cint}, arg2::Ptr{Cint}, arg3::Ptr{Cint})::Cint
end

function quickSort(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.quickSort(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t)::Cvoid
end

function quickSortM(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.quickSortM(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t)::Cvoid
end

function partition(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.partition(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t)::int_t
end

function partitionM(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.partitionM(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t)::int_t
end

function symbfact_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_defs.symbfact_dist(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{SuperMatrix}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Pslu_freeable_t}, arg10::Ptr{MPI_Comm}, arg11::Ptr{MPI_Comm}, arg12::Ptr{superlu_dist_mem_usage_t})::Cfloat
end

function get_perm_c_parmetis(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_defs.get_perm_c_parmetis(arg1::Ptr{SuperMatrix}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Cint, arg5::Cint, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{gridinfo_t}, arg9::Ptr{MPI_Comm})::Cfloat
end

function psymbfact_LUXpandMem(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_defs.psymbfact_LUXpandMem(arg1::Cint, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::Cint, arg7::Cint, arg8::Cint, arg9::Ptr{Pslu_freeable_t}, arg10::Ptr{Llu_symbfact_t}, arg11::Ptr{vtcsInfo_symbfact_t}, arg12::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_LUXpand(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_defs.psymbfact_LUXpand(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::int_t, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Ptr{Pslu_freeable_t}, arg11::Ptr{Llu_symbfact_t}, arg12::Ptr{vtcsInfo_symbfact_t}, arg13::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_LUXpand_RL(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_defs.psymbfact_LUXpand_RL(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{Pslu_freeable_t}, arg8::Ptr{Llu_symbfact_t}, arg9::Ptr{vtcsInfo_symbfact_t}, arg10::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_prLUXpand(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_defs.psymbfact_prLUXpand(arg1::int_t, arg2::int_t, arg3::Cint, arg4::Ptr{Llu_symbfact_t}, arg5::Ptr{psymbfact_stat_t})::int_t
end

function isort(N, ARRAY1, ARRAY2)
    @ccall libsuperlu_defs.isort(N::int_t, ARRAY1::Ptr{int_t}, ARRAY2::Ptr{int_t})::Cvoid
end

function isort1(N, ARRAY)
    @ccall libsuperlu_defs.isort1(N::int_t, ARRAY::Ptr{int_t})::Cvoid
end

function estimate_cpu_time(m, n, k)
    @ccall libsuperlu_defs.estimate_cpu_time(m::Cint, n::Cint, k::Cint)::Cdouble
end

# no prototype is found for this function at superlu_defs.h:1192:12, please use with caution
function get_thread_per_process()
    @ccall libsuperlu_defs.get_thread_per_process()::Cint
end

# no prototype is found for this function at superlu_defs.h:1193:14, please use with caution
function get_max_buffer_size()
    @ccall libsuperlu_defs.get_max_buffer_size()::int_t
end

function get_min(arg1, arg2)
    @ccall libsuperlu_defs.get_min(arg1::Ptr{int_t}, arg2::int_t)::int_t
end

function compare_pair(arg1, arg2)
    @ccall libsuperlu_defs.compare_pair(arg1::Ptr{Cvoid}, arg2::Ptr{Cvoid})::Cint
end

function static_partition(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_defs.static_partition(arg1::Ptr{superlu_pair}, arg2::int_t, arg3::Ptr{int_t}, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Cint)::int_t
end

# no prototype is found for this function at superlu_defs.h:1198:12, please use with caution
function get_acc_offload()
    @ccall libsuperlu_defs.get_acc_offload()::Cint
end

function print_panel_seg_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_defs.print_panel_seg_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t})::Cvoid
end

function check_repfnz_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.check_repfnz_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{int_t})::Cvoid
end

function CheckZeroDiagonal(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.CheckZeroDiagonal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t})::int_t
end

function check_perm_dist(what, n, perm)
    @ccall libsuperlu_defs.check_perm_dist(what::Ptr{Cchar}, n::int_t, perm::Ptr{int_t})::Cint
end

function PrintDouble5(arg1, arg2, arg3)
    @ccall libsuperlu_defs.PrintDouble5(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cdouble})::Cvoid
end

function PrintInt10(arg1, arg2, arg3)
    @ccall libsuperlu_defs.PrintInt10(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{int_t})::Cvoid
end

function PrintInt32(arg1, arg2, arg3)
    @ccall libsuperlu_defs.PrintInt32(arg1::Ptr{Cchar}, arg2::Cint, arg3::Ptr{Cint})::Cvoid
end

function file_PrintInt10(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.file_PrintInt10(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{int_t})::Cint
end

function file_PrintInt32(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.file_PrintInt32(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::Cint, arg4::Ptr{Cint})::Cint
end

function file_PrintLong10(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.file_PrintLong10(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{int_t})::Cint
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

function C_RdTree_Create(tree, comm, ranks, rank_cnt, msgSize, precision)
    @ccall libsuperlu_defs.C_RdTree_Create(tree::Ptr{C_Tree}, comm::MPI_Comm, ranks::Ptr{Cint}, rank_cnt::Cint, msgSize::Cint, precision::Cchar)::Cvoid
end

function C_RdTree_Nullify(tree)
    @ccall libsuperlu_defs.C_RdTree_Nullify(tree::Ptr{C_Tree})::Cvoid
end

function C_RdTree_IsRoot(tree)
    @ccall libsuperlu_defs.C_RdTree_IsRoot(tree::Ptr{C_Tree})::yes_no_t
end

function C_RdTree_forwardMessageSimple(Tree, localBuffer, msgSize)
    @ccall libsuperlu_defs.C_RdTree_forwardMessageSimple(Tree::Ptr{C_Tree}, localBuffer::Ptr{Cvoid}, msgSize::Cint)::Cvoid
end

function C_RdTree_waitSendRequest(Tree)
    @ccall libsuperlu_defs.C_RdTree_waitSendRequest(Tree::Ptr{C_Tree})::Cvoid
end

function C_BcTree_Create(tree, comm, ranks, rank_cnt, msgSize, precision)
    @ccall libsuperlu_defs.C_BcTree_Create(tree::Ptr{C_Tree}, comm::MPI_Comm, ranks::Ptr{Cint}, rank_cnt::Cint, msgSize::Cint, precision::Cchar)::Cvoid
end

function C_BcTree_Nullify(tree)
    @ccall libsuperlu_defs.C_BcTree_Nullify(tree::Ptr{C_Tree})::Cvoid
end

function C_BcTree_IsRoot(tree)
    @ccall libsuperlu_defs.C_BcTree_IsRoot(tree::Ptr{C_Tree})::yes_no_t
end

function C_BcTree_forwardMessageSimple(tree, localBuffer, msgSize)
    @ccall libsuperlu_defs.C_BcTree_forwardMessageSimple(tree::Ptr{C_Tree}, localBuffer::Ptr{Cvoid}, msgSize::Cint)::Cvoid
end

function C_BcTree_waitSendRequest(tree)
    @ccall libsuperlu_defs.C_BcTree_waitSendRequest(tree::Ptr{C_Tree})::Cvoid
end

function DistPrint(function_name, value, Units, grid)
    @ccall libsuperlu_defs.DistPrint(function_name::Ptr{Cchar}, value::Cdouble, Units::Ptr{Cchar}, grid::Ptr{gridinfo_t})::Cvoid
end

function DistPrint3D(function_name, value, Units, grid3d)
    @ccall libsuperlu_defs.DistPrint3D(function_name::Ptr{Cchar}, value::Cdouble, Units::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function treeImbalance3D(grid3d, SCT)
    @ccall libsuperlu_defs.treeImbalance3D(grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cvoid
end

function SCT_printComm3D(grid3d, SCT)
    @ccall libsuperlu_defs.SCT_printComm3D(grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cvoid
end

function getPerm_c_supno(nsupers, arg2, etree, Glu_persist, Lrowind_bc_ptr, Ufstnz_br_ptr, arg7)
    @ccall libsuperlu_defs.getPerm_c_supno(nsupers::int_t, arg2::Ptr{superlu_dist_options_t}, etree::Ptr{int_t}, Glu_persist::Ptr{Glu_persist_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, arg7::Ptr{gridinfo_t})::Ptr{int_t}
end

function SCT_init(arg1)
    @ccall libsuperlu_defs.SCT_init(arg1::Ptr{SCT_t})::Cvoid
end

function SCT_print(grid, SCT)
    @ccall libsuperlu_defs.SCT_print(grid::Ptr{gridinfo_t}, SCT::Ptr{SCT_t})::Cvoid
end

function SCT_print3D(grid3d, SCT)
    @ccall libsuperlu_defs.SCT_print3D(grid3d::Ptr{gridinfo3d_t}, SCT::Ptr{SCT_t})::Cvoid
end

function SCT_free(arg1)
    @ccall libsuperlu_defs.SCT_free(arg1::Ptr{SCT_t})::Cvoid
end

function setree2list(nsuper, setree)
    @ccall libsuperlu_defs.setree2list(nsuper::int_t, setree::Ptr{int_t})::Ptr{treeList_t}
end

function free_treelist(nsuper, treeList)
    @ccall libsuperlu_defs.free_treelist(nsuper::int_t, treeList::Ptr{treeList_t})::Cint
end

function calcTreeWeight(nsupers, setree, treeList, xsup)
    @ccall libsuperlu_defs.calcTreeWeight(nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t}, xsup::Ptr{int_t})::int_t
end

function getDescendList(k, dlist, treeList)
    @ccall libsuperlu_defs.getDescendList(k::int_t, dlist::Ptr{int_t}, treeList::Ptr{treeList_t})::int_t
end

function getCommonAncestorList(k, alist, seTree, treeList)
    @ccall libsuperlu_defs.getCommonAncestorList(k::int_t, alist::Ptr{int_t}, seTree::Ptr{int_t}, treeList::Ptr{treeList_t})::int_t
end

function getCommonAncsCount(k, treeList)
    @ccall libsuperlu_defs.getCommonAncsCount(k::int_t, treeList::Ptr{treeList_t})::int_t
end

function getPermNodeList(nnode, nlist, perm_c_sup, iperm_c_sup)
    @ccall libsuperlu_defs.getPermNodeList(nnode::int_t, nlist::Ptr{int_t}, perm_c_sup::Ptr{int_t}, iperm_c_sup::Ptr{int_t})::Ptr{int_t}
end

function getEtreeLB(nnodes, perm_l, gTopOrder)
    @ccall libsuperlu_defs.getEtreeLB(nnodes::int_t, perm_l::Ptr{int_t}, gTopOrder::Ptr{int_t})::Ptr{int_t}
end

function getSubTreeRoots(k, treeList)
    @ccall libsuperlu_defs.getSubTreeRoots(k::int_t, treeList::Ptr{treeList_t})::Ptr{int_t}
end

function merg_perms(nperms, nnodes, perms)
    @ccall libsuperlu_defs.merg_perms(nperms::int_t, nnodes::Ptr{int_t}, perms::Ptr{Ptr{int_t}})::Ptr{int_t}
end

function getGlobal_iperm(nsupers, nperms, perms, nnodes)
    @ccall libsuperlu_defs.getGlobal_iperm(nsupers::int_t, nperms::int_t, perms::Ptr{Ptr{int_t}}, nnodes::Ptr{int_t})::Ptr{int_t}
end

function log2i(index)
    @ccall libsuperlu_defs.log2i(index::int_t)::int_t
end

function supernodal_etree(nsuper, etree, supno, xsup)
    @ccall libsuperlu_defs.supernodal_etree(nsuper::int_t, etree::Ptr{int_t}, supno::Ptr{int_t}, xsup::Ptr{int_t})::Ptr{int_t}
end

function testSubtreeNodelist(nsupers, numList, nodeList, nodeCount)
    @ccall libsuperlu_defs.testSubtreeNodelist(nsupers::int_t, numList::int_t, nodeList::Ptr{Ptr{int_t}}, nodeCount::Ptr{int_t})::int_t
end

function testListPerm(nodeCount, nodeList, permList, gTopLevel)
    @ccall libsuperlu_defs.testListPerm(nodeCount::int_t, nodeList::Ptr{int_t}, permList::Ptr{int_t}, gTopLevel::Ptr{int_t})::int_t
end

function topological_ordering(nsuper, setree)
    @ccall libsuperlu_defs.topological_ordering(nsuper::int_t, setree::Ptr{int_t})::Ptr{int_t}
end

function Etree_LevelBoundry(perm, tsort_etree, nsuper)
    @ccall libsuperlu_defs.Etree_LevelBoundry(perm::Ptr{int_t}, tsort_etree::Ptr{int_t}, nsuper::int_t)::Ptr{int_t}
end

function calculate_num_children(nsuper, setree)
    @ccall libsuperlu_defs.calculate_num_children(nsuper::int_t, setree::Ptr{int_t})::Ptr{int_t}
end

function Print_EtreeLevelBoundry(Etree_LvlBdry, max_level, nsuper)
    @ccall libsuperlu_defs.Print_EtreeLevelBoundry(Etree_LvlBdry::Ptr{int_t}, max_level::int_t, nsuper::int_t)::Cvoid
end

function print_etree_leveled(setree, tsort_etree, nsuper)
    @ccall libsuperlu_defs.print_etree_leveled(setree::Ptr{int_t}, tsort_etree::Ptr{int_t}, nsuper::int_t)::Cvoid
end

function print_etree(setree, iperm, nsuper)
    @ccall libsuperlu_defs.print_etree(setree::Ptr{int_t}, iperm::Ptr{int_t}, nsuper::int_t)::Cvoid
end

function printFileList(sname, nnodes, dlist, setree)
    @ccall libsuperlu_defs.printFileList(sname::Ptr{Cchar}, nnodes::int_t, dlist::Ptr{int_t}, setree::Ptr{int_t})::int_t
end

function getLastDepBtree(nsupers, treeList)
    @ccall libsuperlu_defs.getLastDepBtree(nsupers::int_t, treeList::Ptr{treeList_t})::Ptr{Cint}
end

function getReplicatedTrees(grid3d)
    @ccall libsuperlu_defs.getReplicatedTrees(grid3d::Ptr{gridinfo3d_t})::Ptr{int_t}
end

function getGridTrees(grid3d)
    @ccall libsuperlu_defs.getGridTrees(grid3d::Ptr{gridinfo3d_t})::Ptr{int_t}
end

function getNodeList(maxLvl, setree, nnodes, treeHeads, treeList)
    @ccall libsuperlu_defs.getNodeList(maxLvl::int_t, setree::Ptr{int_t}, nnodes::Ptr{int_t}, treeHeads::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{Ptr{int_t}}
end

function calcNumNodes(maxLvl, treeHeads, treeList)
    @ccall libsuperlu_defs.calcNumNodes(maxLvl::int_t, treeHeads::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{int_t}
end

function getTreeHeads(maxLvl, nsupers, treeList)
    @ccall libsuperlu_defs.getTreeHeads(maxLvl::int_t, nsupers::int_t, treeList::Ptr{treeList_t})::Ptr{int_t}
end

function getMyIperm(nnodes, nsupers, myPerm)
    @ccall libsuperlu_defs.getMyIperm(nnodes::int_t, nsupers::int_t, myPerm::Ptr{int_t})::Ptr{int_t}
end

function getMyTopOrder(nnodes, myPerm, myIperm, setree)
    @ccall libsuperlu_defs.getMyTopOrder(nnodes::int_t, myPerm::Ptr{int_t}, myIperm::Ptr{int_t}, setree::Ptr{int_t})::Ptr{int_t}
end

function getMyEtLims(nnodes, myTopOrder)
    @ccall libsuperlu_defs.getMyEtLims(nnodes::int_t, myTopOrder::Ptr{int_t})::Ptr{int_t}
end

function getMyTreeTopoInfo(nnodes, nsupers, myPerm, setree)
    @ccall libsuperlu_defs.getMyTreeTopoInfo(nnodes::int_t, nsupers::int_t, myPerm::Ptr{int_t}, setree::Ptr{int_t})::treeTopoInfo_t
end

function getNestDissForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_defs.getNestDissForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{Ptr{sForest_t}}
end

function getTreePermForest(myTreeIdxs, myZeroTrIdxs, sForests, perm_c_supno, iperm_c_supno, grid3d)
    @ccall libsuperlu_defs.getTreePermForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t}, perm_c_supno::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{Ptr{int_t}}
end

function getTreePermFr(myTreeIdxs, sForests, grid3d)
    @ccall libsuperlu_defs.getTreePermFr(myTreeIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t}}, grid3d::Ptr{gridinfo3d_t})::Ptr{Ptr{int_t}}
end

function getMyNodeCountsFr(maxLvl, myTreeIdxs, sForests)
    @ccall libsuperlu_defs.getMyNodeCountsFr(maxLvl::int_t, myTreeIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t}})::Ptr{int_t}
end

function getNodeListFr(maxLvl, sForests)
    @ccall libsuperlu_defs.getNodeListFr(maxLvl::int_t, sForests::Ptr{Ptr{sForest_t}})::Ptr{Ptr{int_t}}
end

function getNodeCountsFr(maxLvl, sForests)
    @ccall libsuperlu_defs.getNodeCountsFr(maxLvl::int_t, sForests::Ptr{Ptr{sForest_t}})::Ptr{int_t}
end

function getIsNodeInMyGrid(nsupers, maxLvl, myNodeCount, treePerm)
    @ccall libsuperlu_defs.getIsNodeInMyGrid(nsupers::int_t, maxLvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}})::Ptr{Cint}
end

function printForestWeightCost(sForests, SCT, grid3d)
    @ccall libsuperlu_defs.printForestWeightCost(sForests::Ptr{Ptr{sForest_t}}, SCT::Ptr{SCT_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function getGreedyLoadBalForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_defs.getGreedyLoadBalForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{Ptr{sForest_t}}
end

function getForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_defs.getForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t})::Ptr{Ptr{sForest_t}}
end

function getBigUSize(arg1, nsupers, grid, Lrowind_bc_ptr)
    @ccall libsuperlu_defs.getBigUSize(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, grid::Ptr{gridinfo_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}})::int_t
end

function getSCUweight(nsupers, treeList, xsup, Lrowind_bc_ptr, Ufstnz_br_ptr, grid3d)
    @ccall libsuperlu_defs.getSCUweight(nsupers::int_t, treeList::Ptr{treeList_t}, xsup::Ptr{int_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function Wait_LUDiagSend(k, U_diag_blk_send_req, L_diag_blk_send_req, grid, SCT)
    @ccall libsuperlu_defs.Wait_LUDiagSend(k::int_t, U_diag_blk_send_req::Ptr{MPI_Request}, L_diag_blk_send_req::Ptr{MPI_Request}, grid::Ptr{gridinfo_t}, SCT::Ptr{SCT_t})::Cint
end

function getNsupers(n, Glu_persist)
    @ccall libsuperlu_defs.getNsupers(n::Cint, Glu_persist::Ptr{Glu_persist_t})::Cint
end

# no prototype is found for this function at superlu_defs.h:1362:12, please use with caution
function set_tag_ub()
    @ccall libsuperlu_defs.set_tag_ub()::Cint
end

function getNumThreads(arg1)
    @ccall libsuperlu_defs.getNumThreads(arg1::Cint)::Cint
end

function num_full_cols_U(kk, Ufstnz_br_ptr, xsup, arg4, arg5, arg6)
    @ccall libsuperlu_defs.num_full_cols_U(kk::int_t, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, arg4::Ptr{gridinfo_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t})::int_t
end

function getFactPerm(arg1)
    @ccall libsuperlu_defs.getFactPerm(arg1::int_t)::Ptr{int_t}
end

function getFactIperm(arg1, arg2)
    @ccall libsuperlu_defs.getFactIperm(arg1::Ptr{int_t}, arg2::int_t)::Ptr{int_t}
end

function initCommRequests(comReqs, grid)
    @ccall libsuperlu_defs.initCommRequests(comReqs::Ptr{commRequests_t}, grid::Ptr{gridinfo_t})::int_t
end

function initFactStat(nsupers, factStat)
    @ccall libsuperlu_defs.initFactStat(nsupers::int_t, factStat::Ptr{factStat_t})::int_t
end

function freeFactStat(factStat)
    @ccall libsuperlu_defs.freeFactStat(factStat::Ptr{factStat_t})::Cint
end

function initFactNodelists(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_defs.initFactNodelists(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{factNodelists_t})::int_t
end

function freeFactNodelists(fNlists)
    @ccall libsuperlu_defs.freeFactNodelists(fNlists::Ptr{factNodelists_t})::Cint
end

function initMsgs(msgs)
    @ccall libsuperlu_defs.initMsgs(msgs::Ptr{msgs_t})::int_t
end

function getNumLookAhead(arg1)
    @ccall libsuperlu_defs.getNumLookAhead(arg1::Ptr{superlu_dist_options_t})::int_t
end

function initCommRequestsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_defs.initCommRequestsArr(mxLeafNode::int_t, ldt::int_t, grid::Ptr{gridinfo_t})::Ptr{Ptr{commRequests_t}}
end

function freeCommRequestsArr(mxLeafNode, comReqss)
    @ccall libsuperlu_defs.freeCommRequestsArr(mxLeafNode::int_t, comReqss::Ptr{Ptr{commRequests_t}})::Cint
end

function initMsgsArr(numLA)
    @ccall libsuperlu_defs.initMsgsArr(numLA::int_t)::Ptr{Ptr{msgs_t}}
end

function freeMsgsArr(numLA, msgss)
    @ccall libsuperlu_defs.freeMsgsArr(numLA::int_t, msgss::Ptr{Ptr{msgs_t}})::Cint
end

function Trs2_InitUblock_info(klst, nb, arg3, usub, arg5, arg6)
    @ccall libsuperlu_defs.Trs2_InitUblock_info(klst::int_t, nb::int_t, arg3::Ptr{Ublock_info_t}, usub::Ptr{int_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{SuperLUStat_t})::int_t
end

function Cmpfunc_R_info(a, b)
    @ccall libsuperlu_defs.Cmpfunc_R_info(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function Cmpfunc_U_info(a, b)
    @ccall libsuperlu_defs.Cmpfunc_U_info(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function sort_R_info(Remain_info, n)
    @ccall libsuperlu_defs.sort_R_info(Remain_info::Ptr{Remain_info_t}, n::Cint)::Cint
end

function sort_U_info(Ublock_info, n)
    @ccall libsuperlu_defs.sort_U_info(Ublock_info::Ptr{Ublock_info_t}, n::Cint)::Cint
end

function sort_R_info_elm(Remain_info, n)
    @ccall libsuperlu_defs.sort_R_info_elm(Remain_info::Ptr{Remain_info_t}, n::Cint)::Cint
end

function sort_U_info_elm(Ublock_info, n)
    @ccall libsuperlu_defs.sort_U_info_elm(Ublock_info::Ptr{Ublock_info_t}, n::Cint)::Cint
end

function printTRStimer(xtrsTimer, grid3d)
    @ccall libsuperlu_defs.printTRStimer(xtrsTimer::Ptr{xtrsTimer_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
end

function initTRStimer(xtrsTimer, grid)
    @ccall libsuperlu_defs.initTRStimer(xtrsTimer::Ptr{xtrsTimer_t}, grid::Ptr{gridinfo_t})::Cvoid
end

function getTreePerm(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, perm_c_supno, iperm_c_supno, grid3d)
    @ccall libsuperlu_defs.getTreePerm(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, perm_c_supno::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{Ptr{int_t}}
end

function getMyNodeCounts(maxLvl, myTreeIdxs, gNodeCount)
    @ccall libsuperlu_defs.getMyNodeCounts(maxLvl::int_t, myTreeIdxs::Ptr{int_t}, gNodeCount::Ptr{int_t})::Ptr{int_t}
end

function checkIntVector3d(vec, len, grid3d)
    @ccall libsuperlu_defs.checkIntVector3d(vec::Ptr{int_t}, len::int_t, grid3d::Ptr{gridinfo3d_t})::int_t
end

function reduceStat(PHASE, stat, grid3d)
    @ccall libsuperlu_defs.reduceStat(PHASE::PhaseType, stat::Ptr{SuperLUStat_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function Wait_LSend(k, grid, ToSendR, s, arg5)
    @ccall libsuperlu_defs.Wait_LSend(k::int_t, grid::Ptr{gridinfo_t}, ToSendR::Ptr{Ptr{Cint}}, s::Ptr{MPI_Request}, arg5::Ptr{SCT_t})::int_t
end

function Wait_USend(arg1, arg2, arg3)
    @ccall libsuperlu_defs.Wait_USend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t}, arg3::Ptr{SCT_t})::int_t
end

function Check_LRecv(arg1, msgcnt)
    @ccall libsuperlu_defs.Check_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint})::int_t
end

function Wait_UDiagBlockSend(arg1, arg2, arg3)
    @ccall libsuperlu_defs.Wait_UDiagBlockSend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t}, arg3::Ptr{SCT_t})::int_t
end

function Wait_LDiagBlockSend(arg1, arg2, arg3)
    @ccall libsuperlu_defs.Wait_LDiagBlockSend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t}, arg3::Ptr{SCT_t})::int_t
end

function Wait_UDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_defs.Wait_UDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Test_UDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_defs.Test_UDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Wait_LDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_defs.Wait_LDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Test_LDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_defs.Test_LDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function LDiagBlockRecvWait(k, factored_U, arg3, arg4)
    @ccall libsuperlu_defs.LDiagBlockRecvWait(k::int_t, factored_U::Ptr{int_t}, arg3::Ptr{MPI_Request}, arg4::Ptr{gridinfo_t})::int_t
end

struct sScalePermstruct_t
    DiagScale::DiagScale_t
    R::Ptr{Cfloat}
    C::Ptr{Cfloat}
    perm_r::Ptr{int_t}
    perm_c::Ptr{int_t}
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
    ilsum::Ptr{int_t}
    ldalsum::int_t
    SolveMsgSent::int_t
    SolveMsgVol::int_t
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
    nroot::int_t
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
    nleaf::int_t
    nfrecvmod::int_t
    inv::int_t
end

struct sLUstruct_t
    etree::Ptr{int_t}
    Glu_persist::Ptr{Glu_persist_t}
    Llu::Ptr{sLocalLU_t}
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
    inv_perm_c::Ptr{int_t}
    num_diag_procs::int_t
    diag_procs::Ptr{int_t}
    diag_len::Ptr{int_t}
    gsmv_comm::Ptr{psgsmv_comm_t}
    gstrs_comm::Ptr{pxgstrs_comm_t}
    A_colind_gsmv::Ptr{int_t}
    xrow_to_proc::Ptr{int_t}
    A3d::Ptr{NRformat_loc3d}
end

struct sLUValSubBuf_t
    Lsub_buf::Ptr{int_t}
    Lval_buf::Ptr{Cfloat}
    Usub_buf::Ptr{int_t}
    Uval_buf::Ptr{Cfloat}
end

function scuStatUpdate(knsupc, HyP, SCT, stat)
    @ccall libsuperlu_dist_Int32.scuStatUpdate(knsupc::int_t, HyP::Ptr{HyP_t}, SCT::Ptr{SCT_t}, stat::Ptr{SuperLUStat_t})::int_t
end

struct strf3Dpartition_t
    gEtreeInfo::gEtreeInfo_t
    iperm_c_supno::Ptr{int_t}
    myNodeCount::Ptr{int_t}
    myTreeIdxs::Ptr{int_t}
    myZeroTrIdxs::Ptr{int_t}
    treePerm::Ptr{Ptr{int_t}}
    sForests::Ptr{Ptr{sForest_t}}
    supernode2treeMap::Ptr{int_t}
    LUvsb::Ptr{sLUValSubBuf_t}
end

struct sscuBufs_t
    bigU::Ptr{Cfloat}
    bigV::Ptr{Cfloat}
end

struct sdiagFactBufs_t
    BlockLFactor::Ptr{Cfloat}
    BlockUFactor::Ptr{Cfloat}
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
    @ccall libsuperlu_dist_Int32.sgsequ_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat}, arg7::Ptr{int_t})::Cvoid
end

function slangs_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.slangs_dist(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix})::Cfloat
end

function slaqgs_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.slaqgs_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Cfloat, arg5::Cfloat, arg6::Cfloat, arg7::Ptr{Cchar})::Cvoid
end

function psgsequ(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.psgsequ(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat}, arg7::Ptr{int_t}, arg8::Ptr{gridinfo_t})::Cvoid
end

function pslangs(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.pslangs(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t})::Cfloat
end

function pslaqgs(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pslaqgs(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Cfloat, arg5::Cfloat, arg6::Cfloat, arg7::Ptr{Cchar})::Cvoid
end

function psPermute_Dense_Matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.psPermute_Dense_Matrix(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Cfloat}, arg6::Cint, arg7::Ptr{Cfloat}, arg8::Cint, arg9::Cint, arg10::Ptr{gridinfo_t})::Cint
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

function psgssvx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.psgssvx(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{sScalePermstruct_t}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t}, arg8::Ptr{sLUstruct_t}, arg9::Ptr{sSOLVEstruct_t}, arg10::Ptr{Cfloat}, arg11::Ptr{SuperLUStat_t}, arg12::Ptr{Cint})::Cvoid
end

function psCompute_Diag_Inv(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.psCompute_Diag_Inv(arg1::int_t, arg2::Ptr{sLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{Cint})::Cvoid
end

function sSolveInit(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sSolveInit(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::int_t, arg6::Ptr{sLUstruct_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{sSOLVEstruct_t})::Cint
end

function sSolveFinalize(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sSolveFinalize(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{sSOLVEstruct_t})::Cvoid
end

function sDestroy_A3d_gathered_on_2d(arg1, arg2)
    @ccall libsuperlu_dist_Int32.sDestroy_A3d_gathered_on_2d(arg1::Ptr{sSOLVEstruct_t}, arg2::Ptr{gridinfo3d_t})::Cvoid
end

function psgstrs_init(arg1, arg2, arg3, arg4, arg5, arg6, grid, arg8, arg9)
    @ccall libsuperlu_dist_Int32.psgstrs_init(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t}, grid::Ptr{gridinfo_t}, arg8::Ptr{Glu_persist_t}, arg9::Ptr{sSOLVEstruct_t})::int_t
end

function pxgstrs_finalize(arg1)
    @ccall libsuperlu_dist_Int32.pxgstrs_finalize(arg1::Ptr{pxgstrs_comm_t})::Cvoid
end

function sldperm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sldperm_dist(arg1::Cint, arg2::Cint, arg3::int_t, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Cfloat}, arg7::Ptr{int_t}, arg8::Ptr{Cfloat}, arg9::Ptr{Cfloat})::Cint
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

function psgsrfs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.psgsrfs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cfloat, arg5::Ptr{sLUstruct_t}, arg6::Ptr{sScalePermstruct_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{Cfloat}, arg9::int_t, arg10::Ptr{Cfloat}, arg11::int_t, arg12::Cint, arg13::Ptr{sSOLVEstruct_t}, arg14::Ptr{Cfloat}, arg15::Ptr{SuperLUStat_t}, arg16::Ptr{Cint})::Cvoid
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

function floatMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.floatMalloc_dist(arg1::int_t)::Ptr{Cfloat}
end

function floatCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.floatCalloc_dist(arg1::int_t)::Ptr{Cfloat}
end

function duser_malloc_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.duser_malloc_dist(arg1::int_t, arg2::int_t)::Ptr{Cvoid}
end

function duser_free_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.duser_free_dist(arg1::int_t, arg2::int_t)::Cvoid
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

function sGatherNRformat_loc3d(Fact, A, B, ldb, nrhs, grid3d, arg7)
    @ccall libsuperlu_dist_Int32.sGatherNRformat_loc3d(Fact::fact_t, A::Ptr{NRformat_loc}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, arg7::Ptr{Ptr{NRformat_loc3d}})::Cvoid
end

function sScatter_B3d(A3d, grid3d)
    @ccall libsuperlu_dist_Int32.sScatter_B3d(A3d::Ptr{NRformat_loc3d}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function psgssvx3d(arg1, arg2, arg3, B, ldb, nrhs, arg7, arg8, arg9, berr, arg11, info)
    @ccall libsuperlu_dist_Int32.psgssvx3d(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{sScalePermstruct_t}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, arg7::Ptr{gridinfo3d_t}, arg8::Ptr{sLUstruct_t}, arg9::Ptr{sSOLVEstruct_t}, berr::Ptr{Cfloat}, arg11::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function psgstrf3d(arg1, m, n, anorm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.psgstrf3d(arg1::Ptr{superlu_dist_options_t}, m::Cint, n::Cint, anorm::Cfloat, arg5::Ptr{strf3Dpartition_t}, arg6::Ptr{SCT_t}, arg7::Ptr{sLUstruct_t}, arg8::Ptr{gridinfo3d_t}, arg9::Ptr{SuperLUStat_t}, arg10::Ptr{Cint})::int_t
end

function sInit_HyP(HyP, Llu, mcb, mrb)
    @ccall libsuperlu_dist_Int32.sInit_HyP(HyP::Ptr{HyP_t}, Llu::Ptr{sLocalLU_t}, mcb::int_t, mrb::int_t)::Cvoid
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

function sinitTrf3Dpartition(nsupers, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sinitTrf3Dpartition(nsupers::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{strf3Dpartition_t}
end

function sDestroy_trf3Dpartition(trf3Dpartition, grid3d)
    @ccall libsuperlu_dist_Int32.sDestroy_trf3Dpartition(trf3Dpartition::Ptr{strf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
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

function sp3dScatter(n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sp3dScatter(n::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function sscatter3dLPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sscatter3dLPanels(nsupers::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function sscatter3dUPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.sscatter3dUPanels(nsupers::int_t, LUstruct::Ptr{sLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
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
    @ccall libsuperlu_dist_Int32.sUDiagBlockRecvWait(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Ptr{sLUstruct_t}, arg7::Ptr{SCT_t})::int_t
end

function sIBcast_UDiagBlock(k, ublk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sIBcast_UDiagBlock(k::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function sIBcast_LDiagBlock(k, lblk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.sIBcast_LDiagBlock(k::int_t, lblk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function sDiagFactIBCast(k, k0, BlockUFactor, BlockLFactor, IrecvPlcd_D, arg6, arg7, arg8, arg9, arg10, arg11, thresh, LUstruct, arg14, info, arg16, tag_ub)
    @ccall libsuperlu_dist_Int32.sDiagFactIBCast(k::int_t, k0::int_t, BlockUFactor::Ptr{Cfloat}, BlockLFactor::Ptr{Cfloat}, IrecvPlcd_D::Ptr{int_t}, arg6::Ptr{MPI_Request}, arg7::Ptr{MPI_Request}, arg8::Ptr{MPI_Request}, arg9::Ptr{MPI_Request}, arg10::Ptr{gridinfo_t}, arg11::Ptr{superlu_dist_options_t}, thresh::Cdouble, LUstruct::Ptr{sLUstruct_t}, arg14::Ptr{SuperLUStat_t}, info::Ptr{Cint}, arg16::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function sUPanelTrSolve(k, BlockLFactor, bigV, ldt, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.sUPanelTrSolve(k::int_t, BlockLFactor::Ptr{Cfloat}, bigV::Ptr{Cfloat}, ldt::int_t, arg5::Ptr{Ublock_info_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{sLUstruct_t}, arg8::Ptr{SuperLUStat_t}, arg9::Ptr{SCT_t})::int_t
end

function sLPanelUpdate(k, IrecvPlcd_D, factored_L, arg4, BlockUFactor, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.sLPanelUpdate(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, BlockUFactor::Ptr{Cfloat}, arg6::Ptr{gridinfo_t}, arg7::Ptr{sLUstruct_t}, arg8::Ptr{SCT_t})::int_t
end

function sUPanelUpdate(k, factored_U, arg3, BlockLFactor, bigV, ldt, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.sUPanelUpdate(k::int_t, factored_U::Ptr{int_t}, arg3::Ptr{MPI_Request}, BlockLFactor::Ptr{Cfloat}, bigV::Ptr{Cfloat}, ldt::int_t, arg7::Ptr{Ublock_info_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{sLUstruct_t}, arg10::Ptr{SuperLUStat_t}, arg11::Ptr{SCT_t})::int_t
end

function sIBcastRecvLPanel(k, k0, msgcnt, arg4, arg5, Lsub_buf, Lval_buf, factored, arg9, arg10, arg11, tag_ub)
    @ccall libsuperlu_dist_Int32.sIBcastRecvLPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, factored::Ptr{int_t}, arg9::Ptr{gridinfo_t}, arg10::Ptr{sLUstruct_t}, arg11::Ptr{SCT_t}, tag_ub::Cint)::int_t
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
    @ccall libsuperlu_dist_Int32.sLPanelTrSolve(k::int_t, factored_L::Ptr{int_t}, BlockUFactor::Ptr{Cfloat}, arg4::Ptr{gridinfo_t}, arg5::Ptr{sLUstruct_t})::int_t
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
    @ccall libsuperlu_dist_Int32.sinitDiagFactBufsArr(mxLeafNode::int_t, ldt::int_t, grid::Ptr{gridinfo_t})::Ptr{Ptr{sdiagFactBufs_t}}
end

function sfreeDiagFactBufsArr(mxLeafNode, dFBufs)
    @ccall libsuperlu_dist_Int32.sfreeDiagFactBufsArr(mxLeafNode::int_t, dFBufs::Ptr{Ptr{sdiagFactBufs_t}})::Cint
end

function sinitDiagFactBufs(ldt, dFBuf)
    @ccall libsuperlu_dist_Int32.sinitDiagFactBufs(ldt::int_t, dFBuf::Ptr{sdiagFactBufs_t})::int_t
end

function checkRecvUDiag(k, comReqs, grid, SCT)
    @ccall libsuperlu_dist_Int32.checkRecvUDiag(k::int_t, comReqs::Ptr{commRequests_t}, grid::Ptr{gridinfo_t}, SCT::Ptr{SCT_t})::int_t
end

function checkRecvLDiag(k, comReqs, arg3, arg4)
    @ccall libsuperlu_dist_Int32.checkRecvLDiag(k::int_t, comReqs::Ptr{commRequests_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SCT_t})::int_t
end

struct dScalePermstruct_t
    DiagScale::DiagScale_t
    R::Ptr{Cdouble}
    C::Ptr{Cdouble}
    perm_r::Ptr{int_t}
    perm_c::Ptr{int_t}
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
    ilsum::Ptr{int_t}
    ldalsum::int_t
    SolveMsgSent::int_t
    SolveMsgVol::int_t
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
    nroot::int_t
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
    nleaf::int_t
    nfrecvmod::int_t
    inv::int_t
end

struct dLUstruct_t
    etree::Ptr{int_t}
    Glu_persist::Ptr{Glu_persist_t}
    Llu::Ptr{dLocalLU_t}
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
    val_tosend::Ptr{Cdouble}
    val_torecv::Ptr{Cdouble}
    TotalIndSend::int_t
    TotalValSend::int_t
end

struct dSOLVEstruct_t
    row_to_proc::Ptr{int_t}
    inv_perm_c::Ptr{int_t}
    num_diag_procs::int_t
    diag_procs::Ptr{int_t}
    diag_len::Ptr{int_t}
    gsmv_comm::Ptr{pdgsmv_comm_t}
    gstrs_comm::Ptr{pxgstrs_comm_t}
    A_colind_gsmv::Ptr{int_t}
    xrow_to_proc::Ptr{int_t}
    A3d::Ptr{NRformat_loc3d}
end

struct dLUValSubBuf_t
    Lsub_buf::Ptr{int_t}
    Lval_buf::Ptr{Cdouble}
    Usub_buf::Ptr{int_t}
    Uval_buf::Ptr{Cdouble}
end

struct dtrf3Dpartition_t
    gEtreeInfo::gEtreeInfo_t
    iperm_c_supno::Ptr{int_t}
    myNodeCount::Ptr{int_t}
    myTreeIdxs::Ptr{int_t}
    myZeroTrIdxs::Ptr{int_t}
    treePerm::Ptr{Ptr{int_t}}
    sForests::Ptr{Ptr{sForest_t}}
    supernode2treeMap::Ptr{int_t}
    LUvsb::Ptr{dLUValSubBuf_t}
end

struct dscuBufs_t
    bigU::Ptr{Cdouble}
    bigV::Ptr{Cdouble}
end

struct ddiagFactBufs_t
    BlockLFactor::Ptr{Cdouble}
    BlockUFactor::Ptr{Cdouble}
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
    @ccall libsuperlu_dist_Int32.dgsequ_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{int_t})::Cvoid
end

function dlangs_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dlangs_dist(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix})::Cdouble
end

function dlaqgs_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.dlaqgs_dist(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pdgsequ(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.pdgsequ(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{int_t}, arg8::Ptr{gridinfo_t})::Cvoid
end

function pdlangs(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int32.pdlangs(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix}, arg3::Ptr{gridinfo_t})::Cdouble
end

function pdlaqgs(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int32.pdlaqgs(arg1::Ptr{SuperMatrix}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pdPermute_Dense_Matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.pdPermute_Dense_Matrix(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Cdouble}, arg6::Cint, arg7::Ptr{Cdouble}, arg8::Cint, arg9::Cint, arg10::Ptr{gridinfo_t})::Cint
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

function pdgssvx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int32.pdgssvx(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{dScalePermstruct_t}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t}, arg8::Ptr{dLUstruct_t}, arg9::Ptr{dSOLVEstruct_t}, arg10::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t}, arg12::Ptr{Cint})::Cvoid
end

function pdCompute_Diag_Inv(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int32.pdCompute_Diag_Inv(arg1::int_t, arg2::Ptr{dLUstruct_t}, arg3::Ptr{gridinfo_t}, arg4::Ptr{SuperLUStat_t}, arg5::Ptr{Cint})::Cvoid
end

function dSolveInit(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dSolveInit(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::int_t, arg6::Ptr{dLUstruct_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{dSOLVEstruct_t})::Cint
end

function dSolveFinalize(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dSolveFinalize(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{dSOLVEstruct_t})::Cvoid
end

function dDestroy_A3d_gathered_on_2d(arg1, arg2)
    @ccall libsuperlu_dist_Int32.dDestroy_A3d_gathered_on_2d(arg1::Ptr{dSOLVEstruct_t}, arg2::Ptr{gridinfo3d_t})::Cvoid
end

function pdgstrs_init(arg1, arg2, arg3, arg4, arg5, arg6, grid, arg8, arg9)
    @ccall libsuperlu_dist_Int32.pdgstrs_init(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t}, grid::Ptr{gridinfo_t}, arg8::Ptr{Glu_persist_t}, arg9::Ptr{dSOLVEstruct_t})::int_t
end

function dldperm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.dldperm_dist(arg1::Cint, arg2::Cint, arg3::int_t, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Cdouble}, arg7::Ptr{int_t}, arg8::Ptr{Cdouble}, arg9::Ptr{Cdouble})::Cint
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

function pdgsrfs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int32.pdgsrfs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix}, arg4::Cdouble, arg5::Ptr{dLUstruct_t}, arg6::Ptr{dScalePermstruct_t}, arg7::Ptr{gridinfo_t}, arg8::Ptr{Cdouble}, arg9::int_t, arg10::Ptr{Cdouble}, arg11::int_t, arg12::Cint, arg13::Ptr{dSOLVEstruct_t}, arg14::Ptr{Cdouble}, arg15::Ptr{SuperLUStat_t}, arg16::Ptr{Cint})::Cvoid
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

function doubleMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.doubleMalloc_dist(arg1::int_t)::Ptr{Cdouble}
end

function doubleCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int32.doubleCalloc_dist(arg1::int_t)::Ptr{Cdouble}
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

function dGatherNRformat_loc3d(Fact, A, B, ldb, nrhs, grid3d, arg7)
    @ccall libsuperlu_dist_Int32.dGatherNRformat_loc3d(Fact::fact_t, A::Ptr{NRformat_loc}, B::Ptr{Cdouble}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t}, arg7::Ptr{Ptr{NRformat_loc3d}})::Cvoid
end

function dScatter_B3d(A3d, grid3d)
    @ccall libsuperlu_dist_Int32.dScatter_B3d(A3d::Ptr{NRformat_loc3d}, grid3d::Ptr{gridinfo3d_t})::Cint
end

function pdgssvx3d(arg1, arg2, arg3, B, ldb, nrhs, arg7, arg8, arg9, berr, arg11, info)
    @ccall libsuperlu_dist_Int32.pdgssvx3d(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix}, arg3::Ptr{dScalePermstruct_t}, B::Ptr{Cdouble}, ldb::Cint, nrhs::Cint, arg7::Ptr{gridinfo3d_t}, arg8::Ptr{dLUstruct_t}, arg9::Ptr{dSOLVEstruct_t}, berr::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t}, info::Ptr{Cint})::Cvoid
end

function pdgstrf3d(arg1, m, n, anorm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int32.pdgstrf3d(arg1::Ptr{superlu_dist_options_t}, m::Cint, n::Cint, anorm::Cdouble, arg5::Ptr{dtrf3Dpartition_t}, arg6::Ptr{SCT_t}, arg7::Ptr{dLUstruct_t}, arg8::Ptr{gridinfo3d_t}, arg9::Ptr{SuperLUStat_t}, arg10::Ptr{Cint})::int_t
end

function dInit_HyP(HyP, Llu, mcb, mrb)
    @ccall libsuperlu_dist_Int32.dInit_HyP(HyP::Ptr{HyP_t}, Llu::Ptr{dLocalLU_t}, mcb::int_t, mrb::int_t)::Cvoid
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

function dinitTrf3Dpartition(nsupers, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dinitTrf3Dpartition(nsupers::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::Ptr{dtrf3Dpartition_t}
end

function dDestroy_trf3Dpartition(trf3Dpartition, grid3d)
    @ccall libsuperlu_dist_Int32.dDestroy_trf3Dpartition(trf3Dpartition::Ptr{dtrf3Dpartition_t}, grid3d::Ptr{gridinfo3d_t})::Cvoid
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

function dp3dScatter(n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dp3dScatter(n::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function dscatter3dLPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dscatter3dLPanels(nsupers::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
end

function dscatter3dUPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int32.dscatter3dUPanels(nsupers::int_t, LUstruct::Ptr{dLUstruct_t}, grid3d::Ptr{gridinfo3d_t})::int_t
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
    @ccall libsuperlu_dist_Int32.dUDiagBlockRecvWait(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t}, arg6::Ptr{dLUstruct_t}, arg7::Ptr{SCT_t})::int_t
end

function dIBcast_UDiagBlock(k, ublk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dIBcast_UDiagBlock(k::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function dIBcast_LDiagBlock(k, lblk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int32.dIBcast_LDiagBlock(k::int_t, lblk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t})::int_t
end

function dDiagFactIBCast(k, k0, BlockUFactor, BlockLFactor, IrecvPlcd_D, arg6, arg7, arg8, arg9, arg10, arg11, thresh, LUstruct, arg14, info, arg16, tag_ub)
    @ccall libsuperlu_dist_Int32.dDiagFactIBCast(k::int_t, k0::int_t, BlockUFactor::Ptr{Cdouble}, BlockLFactor::Ptr{Cdouble}, IrecvPlcd_D::Ptr{int_t}, arg6::Ptr{MPI_Request}, arg7::Ptr{MPI_Request}, arg8::Ptr{MPI_Request}, arg9::Ptr{MPI_Request}, arg10::Ptr{gridinfo_t}, arg11::Ptr{superlu_dist_options_t}, thresh::Cdouble, LUstruct::Ptr{dLUstruct_t}, arg14::Ptr{SuperLUStat_t}, info::Ptr{Cint}, arg16::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function dUPanelTrSolve(k, BlockLFactor, bigV, ldt, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int32.dUPanelTrSolve(k::int_t, BlockLFactor::Ptr{Cdouble}, bigV::Ptr{Cdouble}, ldt::int_t, arg5::Ptr{Ublock_info_t}, arg6::Ptr{gridinfo_t}, arg7::Ptr{dLUstruct_t}, arg8::Ptr{SuperLUStat_t}, arg9::Ptr{SCT_t})::int_t
end

function dLPanelUpdate(k, IrecvPlcd_D, factored_L, arg4, BlockUFactor, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int32.dLPanelUpdate(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, BlockUFactor::Ptr{Cdouble}, arg6::Ptr{gridinfo_t}, arg7::Ptr{dLUstruct_t}, arg8::Ptr{SCT_t})::int_t
end

function dUPanelUpdate(k, factored_U, arg3, BlockLFactor, bigV, ldt, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int32.dUPanelUpdate(k::int_t, factored_U::Ptr{int_t}, arg3::Ptr{MPI_Request}, BlockLFactor::Ptr{Cdouble}, bigV::Ptr{Cdouble}, ldt::int_t, arg7::Ptr{Ublock_info_t}, arg8::Ptr{gridinfo_t}, arg9::Ptr{dLUstruct_t}, arg10::Ptr{SuperLUStat_t}, arg11::Ptr{SCT_t})::int_t
end

function dIBcastRecvLPanel(k, k0, msgcnt, arg4, arg5, Lsub_buf, Lval_buf, factored, arg9, arg10, arg11, tag_ub)
    @ccall libsuperlu_dist_Int32.dIBcastRecvLPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, factored::Ptr{int_t}, arg9::Ptr{gridinfo_t}, arg10::Ptr{dLUstruct_t}, arg11::Ptr{SCT_t}, tag_ub::Cint)::int_t
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
    @ccall libsuperlu_dist_Int32.dLPanelTrSolve(k::int_t, factored_L::Ptr{int_t}, BlockUFactor::Ptr{Cdouble}, arg4::Ptr{gridinfo_t}, arg5::Ptr{dLUstruct_t})::int_t
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
    @ccall libsuperlu_dist_Int32.dinitDiagFactBufsArr(mxLeafNode::int_t, ldt::int_t, grid::Ptr{gridinfo_t})::Ptr{Ptr{ddiagFactBufs_t}}
end

function dfreeDiagFactBufsArr(mxLeafNode, dFBufs)
    @ccall libsuperlu_dist_Int32.dfreeDiagFactBufsArr(mxLeafNode::int_t, dFBufs::Ptr{Ptr{ddiagFactBufs_t}})::Cint
end

function dinitDiagFactBufs(ldt, dFBuf)
    @ccall libsuperlu_dist_Int32.dinitDiagFactBufs(ldt::int_t, dFBuf::Ptr{ddiagFactBufs_t})::int_t
end