module SuperLU_Int64
import MPI: MPI_Comm, MPI_Request, MPI_Datatype, MPI_Errhandler
using SuperLU_DIST_jll
using ..SuperLUDIST_Common
using SuperLU_Base.Common
const libsuperlu_dist_Int64 = SuperLU_DIST_jll.libsuperlu_dist_Int64

function superlu_abort_and_exit_dist(arg1)
    @ccall libsuperlu_dist_Int64.superlu_abort_and_exit_dist(arg1::Ptr{Cchar})::Cvoid
end

function superlu_malloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.superlu_malloc_dist(arg1::Csize_t)::Ptr{Cvoid}
end

function superlu_free_dist(arg1)
    @ccall libsuperlu_dist_Int64.superlu_free_dist(arg1::Ptr{Cvoid})::Cvoid
end

const int_t = Int64

function scuStatUpdate(knsupc, HyP, SCT, stat)
    @ccall libsuperlu_dist_Int64.scuStatUpdate(knsupc::int_t, HyP::Ptr{HyP_t}, SCT::Ptr{SCT_t}, stat::Ptr{SuperLUStat_t{Int64}})::int_t
end

function dCreate_CompCol_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.dCreate_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{Cdouble}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Stype_t, arg9::Dtype_t, arg10::Mtype_t)::Cvoid
end

function dCreate_CompRowLoc_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.dCreate_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{Cdouble}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Stype_t, arg11::Dtype_t, arg12::Mtype_t)::Cvoid
end

function dCompRow_to_CompCol_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.dCompRow_to_CompCol_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{Cdouble}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{Ptr{Cdouble}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{Ptr{int_t}})::Cvoid
end

function pdCompRow_loc_to_CompCol_global(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.pdCompRow_loc_to_CompCol_global(arg1::int_t, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperMatrix{Int64}})::Cint
end

function dCopy_CompCol_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dCopy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function dCreate_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dCreate_Dense_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::Ptr{Cdouble}, arg5::int_t, arg6::Stype_t, arg7::Dtype_t, arg8::Mtype_t)::Cvoid
end

function dCreate_SuperNode_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.dCreate_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{Cdouble}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Stype_t, arg12::Dtype_t, arg13::Mtype_t)::Cvoid
end

function dCopy_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.dCopy_Dense_Matrix_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cdouble}, arg4::int_t, arg5::Ptr{Cdouble}, arg6::int_t)::Cvoid
end

function dallocateA_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dallocateA_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Ptr{int_t}}, arg5::Ptr{Ptr{int_t}})::Cvoid
end

function dGenXtrue_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.dGenXtrue_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cdouble}, arg4::int_t)::Cvoid
end

function dFillRHS_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dFillRHS_dist(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cdouble}, arg4::int_t, arg5::Ptr{SuperMatrix{Int64}}, arg6::Ptr{Cdouble}, arg7::int_t)::Cvoid
end

function dcreate_matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dcreate_matrix(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function dcreate_matrix_rb(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dcreate_matrix_rb(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function dcreate_matrix_dat(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dcreate_matrix_dat(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function dcreate_matrix_postfix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.dcreate_matrix_postfix(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{Cdouble}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{Cchar}, arg9::Ptr{gridinfo_t{Int64}})::Cint
end

function dScalePermstructInit(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.dScalePermstructInit(arg1::int_t, arg2::int_t, arg3::Ptr{dScalePermstruct_t{Int64}})::Cvoid
end

function dScalePermstructFree(arg1)
    @ccall libsuperlu_dist_Int64.dScalePermstructFree(arg1::Ptr{dScalePermstruct_t{Int64}})::Cvoid
end

function dgsequ_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dgsequ_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{int_t})::Cvoid
end

function dlangs_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dlangs_dist(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix{Int64}})::Cdouble
end

function dlaqgs_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dlaqgs_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pdgsequ(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.pdgsequ(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{int_t}, arg8::Ptr{gridinfo_t{Int64}})::Cvoid
end

function pdlangs(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.pdlangs(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}})::Cdouble
end

function pdlaqgs(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.pdlaqgs(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pdPermute_Dense_Matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.pdPermute_Dense_Matrix(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Cdouble}, arg6::Cint, arg7::Ptr{Cdouble}, arg8::Cint, arg9::Cint, arg10::Ptr{gridinfo_t{Int64}})::Cint
end

function sp_dtrsv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sp_dtrsv_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cchar}, arg3::Ptr{Cchar}, arg4::Ptr{SuperMatrix{Int64}}, arg5::Ptr{SuperMatrix{Int64}}, arg6::Ptr{Cdouble}, arg7::Ptr{Cint})::Cint
end

function sp_dgemv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sp_dgemv_dist(arg1::Ptr{Cchar}, arg2::Cdouble, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cdouble, arg7::Ptr{Cdouble}, arg8::Cint)::Cint
end

function sp_dgemm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.sp_dgemm_dist(arg1::Ptr{Cchar}, arg2::Cint, arg3::Cdouble, arg4::Ptr{SuperMatrix{Int64}}, arg5::Ptr{Cdouble}, arg6::Cint, arg7::Cdouble, arg8::Ptr{Cdouble}, arg9::Cint)::Cint
end

function ddistribute(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.ddistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{Glu_freeable_t{Int64}}, arg5::Ptr{dLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}})::Cfloat
end

function pdgssvx_ABglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.pdgssvx_ABglobal(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{dScalePermstruct_t{Int64}}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{dLUstruct_t{Int64}}, arg9::Ptr{Cdouble}, arg10::Ptr{SuperLUStat_t{Int64}}, arg11::Ptr{Cint})::Cvoid
end

function pddistribute(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.pddistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{dScalePermstruct_t{Int64}}, arg5::Ptr{Glu_freeable_t{Int64}}, arg6::Ptr{dLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::Cfloat
end

function pdgssvx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.pdgssvx(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{dScalePermstruct_t{Int64}}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{dLUstruct_t{Int64}}, arg9::Ptr{dSOLVEstruct_t{Int64}}, arg10::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t{Int64}}, arg12::Ptr{Cint})::Cvoid
end

function pdCompute_Diag_Inv(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.pdCompute_Diag_Inv(arg1::int_t, arg2::Ptr{dLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperLUStat_t{Int64}}, arg5::Ptr{Cint})::Cvoid
end

function dSolveInit(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dSolveInit(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::int_t, arg6::Ptr{dLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{dSOLVEstruct_t{Int64}})::Cint
end

function dSolveFinalize(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dSolveFinalize(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{dSOLVEstruct_t{Int64}})::Cvoid
end

function dDestroy_A3d_gathered_on_2d(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dDestroy_A3d_gathered_on_2d(arg1::Ptr{dSOLVEstruct_t{Int64}}, arg2::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function pdgstrs_init(arg1, arg2, arg3, arg4, arg5, arg6, grid, arg8, arg9)
    @ccall libsuperlu_dist_Int64.pdgstrs_init(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t}, grid::Ptr{gridinfo_t{Int64}}, arg8::Ptr{Glu_persist_t}, arg9::Ptr{dSOLVEstruct_t{Int64}})::int_t
end

function pxgstrs_finalize(arg1)
    @ccall libsuperlu_dist_Int64.pxgstrs_finalize(arg1::Ptr{pxgstrs_comm_t})::Cvoid
end

function dldperm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.dldperm_dist(arg1::Cint, arg2::Cint, arg3::int_t, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Cdouble}, arg7::Ptr{int_t}, arg8::Ptr{Cdouble}, arg9::Ptr{Cdouble})::Cint
end

function dstatic_schedule(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.dstatic_schedule(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{dLUstruct_t{Int64}}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{SuperLUStat_t{Int64}}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Cint})::Cint
end

function dLUstructInit(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dLUstructInit(arg1::int_t, arg2::Ptr{dLUstruct_t{Int64}})::Cvoid
end

function dLUstructFree(arg1)
    @ccall libsuperlu_dist_Int64.dLUstructFree(arg1::Ptr{dLUstruct_t{Int64}})::Cvoid
end

function dDestroy_LU(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.dDestroy_LU(arg1::int_t, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{dLUstruct_t{Int64}})::Cvoid
end

function dDestroy_Tree(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.dDestroy_Tree(arg1::int_t, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{dLUstruct_t{Int64}})::Cvoid
end

function dscatter_l(ib, ljb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, usub, lsub, tempv, indirect_thread, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, grid)
    @ccall libsuperlu_dist_Int64.dscatter_l(ib::Cint, ljb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, usub::Ptr{int_t}, lsub::Ptr{int_t}, tempv::Ptr{Cdouble}, indirect_thread::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{Cdouble}}, grid::Ptr{gridinfo_t{Int64}})::Cvoid
end

function dscatter_u(ib, jb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, lsub, usub, tempv, Ufstnz_br_ptr, Unzval_br_ptr, grid)
    @ccall libsuperlu_dist_Int64.dscatter_u(ib::Cint, jb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, lsub::Ptr{int_t}, usub::Ptr{int_t}, tempv::Ptr{Cdouble}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{Cdouble}}, grid::Ptr{gridinfo_t{Int64}})::Cvoid
end

function pdgstrf(arg1, arg2, arg3, anorm, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.pdgstrf(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, anorm::Cdouble, arg5::Ptr{dLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SuperLUStat_t{Int64}}, arg8::Ptr{Cint})::int_t
end

function pdgstrs_Bglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.pdgstrs_Bglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{dLUstruct_t{Int64}}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{Cdouble}, arg6::int_t, arg7::Cint, arg8::Ptr{SuperLUStat_t{Int64}}, arg9::Ptr{Cint})::Cvoid
end

function pdgstrs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.pdgstrs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{dLUstruct_t{Int64}}, arg4::Ptr{dScalePermstruct_t{Int64}}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{Cdouble}, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Cint, arg11::Ptr{dSOLVEstruct_t{Int64}}, arg12::Ptr{SuperLUStat_t{Int64}}, arg13::Ptr{Cint})::Cvoid
end

function pdgstrf2_trsm(options, k0, k, thresh, arg5, arg6, arg7, arg8, tag_ub, arg10, info)
    @ccall libsuperlu_dist_Int64.pdgstrf2_trsm(options::Ptr{superlu_dist_options_t}, k0::int_t, k::int_t, thresh::Cdouble, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{dLocalLU_t{Int64}}, arg8::Ptr{MPI_Request}, tag_ub::Cint, arg10::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint})::Cvoid
end

function pdgstrs2_omp(k0, k, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.pdgstrs2_omp(k0::int_t, k::int_t, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{dLocalLU_t{Int64}}, arg6::Ptr{Ublock_info_t}, arg7::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function pdReDistribute_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.pdReDistribute_B_to_X(B::Ptr{Cdouble}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{Cdouble}, arg8::Ptr{dScalePermstruct_t{Int64}}, arg9::Ptr{Glu_persist_t}, arg10::Ptr{gridinfo_t{Int64}}, arg11::Ptr{dSOLVEstruct_t{Int64}})::int_t
end

function dlsum_fmod(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int64.dlsum_fmod(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::int_t, arg11::int_t, arg12::Ptr{int_t}, arg13::Ptr{gridinfo_t{Int64}}, arg14::Ptr{dLocalLU_t{Int64}}, arg15::Ptr{MPI_Request}, arg16::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function dlsum_bmod(arg1, arg2, arg3, arg4, arg5, bmod, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int64.dlsum_bmod(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cint, arg5::int_t, bmod::Ptr{Cint}, arg7::Ptr{int_t}, arg8::Ptr{Ptr{Ucb_indptr_t}}, arg9::Ptr{Ptr{int_t}}, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{dLocalLU_t{Int64}}, arg13::Ptr{MPI_Request}, arg14::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function dlsum_fmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, fmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int64.dlsum_fmod_inv(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::int_t, fmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{gridinfo_t{Int64}}, arg10::Ptr{dLocalLU_t{Int64}}, arg11::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg12::Ptr{int_t}, arg13::Ptr{int_t}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function dlsum_fmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int64.dlsum_fmod_inv_master(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{dLocalLU_t{Int64}}, arg13::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function dlsum_bmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    @ccall libsuperlu_dist_Int64.dlsum_bmod_inv(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t{Int64}}, arg13::Ptr{dLocalLU_t{Int64}}, arg14::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg15::Ptr{int_t}, arg16::Ptr{int_t}, arg17::int_t, arg18::int_t, arg19::Cint, arg20::Cint)::Cvoid
end

function dlsum_bmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    @ccall libsuperlu_dist_Int64.dlsum_bmod_inv_master(arg1::Ptr{Cdouble}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t{Int64}}, arg13::Ptr{dLocalLU_t{Int64}}, arg14::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg15::int_t, arg16::int_t, arg17::Cint, arg18::Cint)::Cvoid
end

function dComputeLevelsets(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.dComputeLevelsets(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t{Int64}}, arg6::Ptr{int_t})::Cvoid
end

function pdgsrfs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int64.pdgsrfs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Cdouble, arg5::Ptr{dLUstruct_t{Int64}}, arg6::Ptr{dScalePermstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{Cdouble}, arg9::int_t, arg10::Ptr{Cdouble}, arg11::int_t, arg12::Cint, arg13::Ptr{dSOLVEstruct_t{Int64}}, arg14::Ptr{Cdouble}, arg15::Ptr{SuperLUStat_t{Int64}}, arg16::Ptr{Cint})::Cvoid
end

function pdgsrfs_ABXglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int64.pdgsrfs_ABXglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Cdouble, arg5::Ptr{dLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{Cdouble}, arg8::int_t, arg9::Ptr{Cdouble}, arg10::int_t, arg11::Cint, arg12::Ptr{Cdouble}, arg13::Ptr{SuperLUStat_t{Int64}}, arg14::Ptr{Cint})::Cvoid
end

function pdgsmv_AXglobal_setup(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.pdgsmv_AXglobal_setup(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{int_t})::Cint
end

function pdgsmv_AXglobal(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.pdgsmv_AXglobal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Cdouble}, arg4::Ptr{int_t}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble})::Cint
end

function pdgsmv_AXglobal_abs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.pdgsmv_AXglobal_abs(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Cdouble}, arg4::Ptr{int_t}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble})::Cint
end

function pdgsmv_init(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.pdgsmv_init(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{int_t}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{pdgsmv_comm_t})::Cvoid
end

function pdgsmv(arg1, arg2, arg3, arg4, x, ax)
    @ccall libsuperlu_dist_Int64.pdgsmv(arg1::int_t, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{pdgsmv_comm_t}, x::Ptr{Cdouble}, ax::Ptr{Cdouble})::Cvoid
end

function pdgsmv_finalize(arg1)
    @ccall libsuperlu_dist_Int64.pdgsmv_finalize(arg1::Ptr{pdgsmv_comm_t})::Cvoid
end

function doubleMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.doubleMalloc_dist(arg1::int_t)::Ptr{Cdouble}
end

function doubleCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.doubleCalloc_dist(arg1::int_t)::Ptr{Cdouble}
end

function duser_malloc_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.duser_malloc_dist(arg1::int_t, arg2::int_t)::Ptr{Cvoid}
end

function duser_free_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.duser_free_dist(arg1::int_t, arg2::int_t)::Cvoid
end

function dQuerySpace_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dQuerySpace_dist(arg1::int_t, arg2::Ptr{dLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperLUStat_t{Int64}}, arg5::Ptr{superlu_dist_mem_usage_t})::int_t
end

function dClone_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dClone_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function dCopy_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dCopy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function dZero_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.dZero_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function dScaleAddId_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dScaleAddId_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cdouble)::Cvoid
end

function dScaleAdd_CompRowLoc_Matrix_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.dScaleAdd_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Cdouble)::Cvoid
end

function dZeroLblocks(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.dZeroLblocks(arg1::Cint, arg2::Cint, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{dLUstruct_t{Int64}})::Cvoid
end

function dZeroUblocks(iam, n, arg3, arg4)
    @ccall libsuperlu_dist_Int64.dZeroUblocks(iam::Cint, n::Cint, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{dLUstruct_t{Int64}})::Cvoid
end

function dfill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.dfill_dist(arg1::Ptr{Cdouble}, arg2::int_t, arg3::Cdouble)::Cvoid
end

function dinf_norm_error_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dinf_norm_error_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cdouble}, arg4::int_t, arg5::Ptr{Cdouble}, arg6::int_t, arg7::Ptr{gridinfo_t{Int64}})::Cvoid
end

function pdinf_norm_error(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.pdinf_norm_error(arg1::Cint, arg2::int_t, arg3::int_t, arg4::Ptr{Cdouble}, arg5::int_t, arg6::Ptr{Cdouble}, arg7::int_t, arg8::MPI_Comm)::Cvoid
end

function dreadhb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dreadhb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function dreadtriple_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dreadtriple_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function dreadtriple_noheader(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dreadtriple_noheader(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function dreadrb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dreadrb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function dreadMM_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dreadMM_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function dread_binary(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dread_binary(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cdouble}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cint
end

function ddist_psymbtonum(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.ddist_psymbtonum(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{dScalePermstruct_t{Int64}}, arg5::Ptr{Pslu_freeable_t}, arg6::Ptr{dLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::Cfloat
end

function pdGetDiagU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.pdGetDiagU(arg1::int_t, arg2::Ptr{dLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Cdouble})::Cvoid
end

function d_c2cpp_GetHWPM(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.d_c2cpp_GetHWPM(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{dScalePermstruct_t{Int64}})::Cint
end

function dPrintLblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dPrintLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t{Int64}})::Cvoid
end

function dPrintUblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dPrintUblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t{Int64}})::Cvoid
end

function dPrint_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.dPrint_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function dPrint_Dense_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.dPrint_Dense_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function dPrint_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.dPrint_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cint
end

function file_dPrint_CompRowLoc_Matrix_dist(fp, A)
    @ccall libsuperlu_dist_Int64.file_dPrint_CompRowLoc_Matrix_dist(fp::Ptr{Libc.FILE}, A::Ptr{SuperMatrix{Int64}})::Cint
end

function Printdouble5(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.Printdouble5(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cdouble})::Cvoid
end

function file_Printdouble5(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.file_Printdouble5(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{Cdouble})::Cint
end

function dGenCOOLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.dGenCOOLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t{Int64}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{Cdouble}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function dGenCSCLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.dGenCSCLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t{Int64}}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function dGenCSRLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.dGenCSRLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{dLocalLU_t{Int64}}, arg6::Ptr{Ptr{Cdouble}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function superlu_dgemm(transa, transb, m, n, k, alpha, a, lda, b, ldb, beta, c, ldc)
    @ccall libsuperlu_dist_Int64.superlu_dgemm(transa::Ptr{Cchar}, transb::Ptr{Cchar}, m::Cint, n::Cint, k::Cint, alpha::Cdouble, a::Ptr{Cdouble}, lda::Cint, b::Ptr{Cdouble}, ldb::Cint, beta::Cdouble, c::Ptr{Cdouble}, ldc::Cint)::Cint
end

function superlu_dtrsm(sideRL, uplo, transa, diag, m, n, alpha, a, lda, b, ldb)
    @ccall libsuperlu_dist_Int64.superlu_dtrsm(sideRL::Ptr{Cchar}, uplo::Ptr{Cchar}, transa::Ptr{Cchar}, diag::Ptr{Cchar}, m::Cint, n::Cint, alpha::Cdouble, a::Ptr{Cdouble}, lda::Cint, b::Ptr{Cdouble}, ldb::Cint)::Cint
end

function superlu_dger(m, n, alpha, x, incx, y, incy, a, lda)
    @ccall libsuperlu_dist_Int64.superlu_dger(m::Cint, n::Cint, alpha::Cdouble, x::Ptr{Cdouble}, incx::Cint, y::Ptr{Cdouble}, incy::Cint, a::Ptr{Cdouble}, lda::Cint)::Cint
end

function superlu_dscal(n, alpha, x, incx)
    @ccall libsuperlu_dist_Int64.superlu_dscal(n::Cint, alpha::Cdouble, x::Ptr{Cdouble}, incx::Cint)::Cint
end

function superlu_daxpy(n, alpha, x, incx, y, incy)
    @ccall libsuperlu_dist_Int64.superlu_daxpy(n::Cint, alpha::Cdouble, x::Ptr{Cdouble}, incx::Cint, y::Ptr{Cdouble}, incy::Cint)::Cint
end

function superlu_dgemv(trans, m, n, alpha, a, lda, x, incx, beta, y, incy)
    @ccall libsuperlu_dist_Int64.superlu_dgemv(trans::Ptr{Cchar}, m::Cint, n::Cint, alpha::Cdouble, a::Ptr{Cdouble}, lda::Cint, x::Ptr{Cdouble}, incx::Cint, beta::Cdouble, y::Ptr{Cdouble}, incy::Cint)::Cint
end

function superlu_dtrsv(uplo, trans, diag, n, a, lda, x, incx)
    @ccall libsuperlu_dist_Int64.superlu_dtrsv(uplo::Ptr{Cchar}, trans::Ptr{Cchar}, diag::Ptr{Cchar}, n::Cint, a::Ptr{Cdouble}, lda::Cint, x::Ptr{Cdouble}, incx::Cint)::Cint
end

function dcreate_matrix3d(A, nrhs, rhs, ldb, x, ldx, fp, grid3d)
    @ccall libsuperlu_dist_Int64.dcreate_matrix3d(A::Ptr{SuperMatrix{Int64}}, nrhs::Cint, rhs::Ptr{Ptr{Cdouble}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cdouble}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function dcreate_matrix_postfix3d(A, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int64.dcreate_matrix_postfix3d(A::Ptr{SuperMatrix{Int64}}, nrhs::Cint, rhs::Ptr{Ptr{Cdouble}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cdouble}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function dGatherNRformat_loc3d(Fact, A, B, ldb, nrhs, grid3d, arg7)
    @ccall libsuperlu_dist_Int64.dGatherNRformat_loc3d(Fact::fact_t, A::Ptr{NRformat_loc{Int64}}, B::Ptr{Cdouble}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t{Int64}}, arg7::Ptr{Ptr{NRformat_loc3d{Int64}}})::Cvoid
end

function dScatter_B3d(A3d, grid3d)
    @ccall libsuperlu_dist_Int64.dScatter_B3d(A3d::Ptr{NRformat_loc3d{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function pdgssvx3d(arg1, arg2, arg3, B, ldb, nrhs, arg7, arg8, arg9, berr, arg11, info)
    @ccall libsuperlu_dist_Int64.pdgssvx3d(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{dScalePermstruct_t{Int64}}, B::Ptr{Cdouble}, ldb::Cint, nrhs::Cint, arg7::Ptr{gridinfo3d_t{Int64}}, arg8::Ptr{dLUstruct_t{Int64}}, arg9::Ptr{dSOLVEstruct_t{Int64}}, berr::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint})::Cvoid
end

function pdgstrf3d(arg1, m, n, anorm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.pdgstrf3d(arg1::Ptr{superlu_dist_options_t}, m::Cint, n::Cint, anorm::Cdouble, arg5::Ptr{dtrf3Dpartition_t{Int64}}, arg6::Ptr{SCT_t}, arg7::Ptr{dLUstruct_t{Int64}}, arg8::Ptr{gridinfo3d_t{Int64}}, arg9::Ptr{SuperLUStat_t{Int64}}, arg10::Ptr{Cint})::int_t
end

function dInit_HyP(HyP, Llu, mcb, mrb)
    @ccall libsuperlu_dist_Int64.dInit_HyP(HyP::Ptr{HyP_t}, Llu::Ptr{dLocalLU_t{Int64}}, mcb::int_t, mrb::int_t)::Cvoid
end

function Free_HyP(HyP)
    @ccall libsuperlu_dist_Int64.Free_HyP(HyP::Ptr{HyP_t})::Cvoid
end

function updateDirtyBit(k0, HyP, grid)
    @ccall libsuperlu_dist_Int64.updateDirtyBit(k0::int_t, HyP::Ptr{HyP_t}, grid::Ptr{gridinfo_t{Int64}})::Cint
end

function dblock_gemm_scatter(lb, j, Ublock_info, Remain_info, L_mat, ldl, U_mat, ldu, bigV, knsupc, klst, lsub, usub, ldt, thread_id, indirect, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, Ufstnz_br_ptr, Unzval_br_ptr, xsup, arg23, arg24)
    @ccall libsuperlu_dist_Int64.dblock_gemm_scatter(lb::int_t, j::int_t, Ublock_info::Ptr{Ublock_info_t}, Remain_info::Ptr{Remain_info_t}, L_mat::Ptr{Cdouble}, ldl::Cint, U_mat::Ptr{Cdouble}, ldu::Cint, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, thread_id::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{Cdouble}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{Cdouble}}, xsup::Ptr{int_t}, arg23::Ptr{gridinfo_t{Int64}}, arg24::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function dblock_gemm_scatterTopLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.dblock_gemm_scatterTopLeft(lb::int_t, j::int_t, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{dLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function dblock_gemm_scatterTopRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.dblock_gemm_scatterTopRight(lb::int_t, j::int_t, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{dLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function dblock_gemm_scatterBottomLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.dblock_gemm_scatterBottomLeft(lb::int_t, j::int_t, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{dLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function dblock_gemm_scatterBottomRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.dblock_gemm_scatterBottomRight(lb::int_t, j::int_t, bigV::Ptr{Cdouble}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{dLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function dgather_u(num_u_blks, Ublock_info, usub, uval, bigU, ldu, xsup, klst)
    @ccall libsuperlu_dist_Int64.dgather_u(num_u_blks::int_t, Ublock_info::Ptr{Ublock_info_t}, usub::Ptr{int_t}, uval::Ptr{Cdouble}, bigU::Ptr{Cdouble}, ldu::int_t, xsup::Ptr{int_t}, klst::int_t)::Cvoid
end

function dgather_l(num_LBlk, knsupc, L_info, lval, LD_lval, L_buff)
    @ccall libsuperlu_dist_Int64.dgather_l(num_LBlk::int_t, knsupc::int_t, L_info::Ptr{Remain_info_t}, lval::Ptr{Cdouble}, LD_lval::int_t, L_buff::Ptr{Cdouble})::Cvoid
end

function dRgather_L(k, lsub, lusup, arg4, arg5, arg6, arg7, myIperm, iperm_c_supno)
    @ccall libsuperlu_dist_Int64.dRgather_L(k::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cdouble}, arg4::Ptr{gEtreeInfo_t{Int64}}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t})::Cvoid
end

function dRgather_U(k, jj0, usub, uval, bigU, arg6, arg7, arg8, arg9, myIperm, iperm_c_supno, perm_u)
    @ccall libsuperlu_dist_Int64.dRgather_U(k::int_t, jj0::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, bigU::Ptr{Cdouble}, arg6::Ptr{gEtreeInfo_t{Int64}}, arg7::Ptr{Glu_persist_t}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, perm_u::Ptr{int_t})::Cvoid
end

function dinitTrf3Dpartition(nsupers, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dinitTrf3Dpartition(nsupers::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Ptr{dtrf3Dpartition_t{Int64}}
end

function dDestroy_trf3Dpartition(trf3Dpartition, grid3d)
    @ccall libsuperlu_dist_Int64.dDestroy_trf3Dpartition(trf3Dpartition::Ptr{dtrf3Dpartition_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function d3D_printMemUse(trf3Dpartition, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.d3D_printMemUse(trf3Dpartition::Ptr{dtrf3Dpartition_t{Int64}}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function dinit3DLUstructForest(myTreeIdxs, myZeroTrIdxs, sForests, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dinit3DLUstructForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t{Int64}}}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function dgatherAllFactoredLUFr(myZeroTrIdxs, sForests, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dgatherAllFactoredLUFr(myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t{Int64}}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function dLpanelUpdate(off0, nsupc, ublk_ptr, ld_ujrow, lusup, nsupr, arg7)
    @ccall libsuperlu_dist_Int64.dLpanelUpdate(off0::int_t, nsupc::int_t, ublk_ptr::Ptr{Cdouble}, ld_ujrow::int_t, lusup::Ptr{Cdouble}, nsupr::int_t, arg7::Ptr{SCT_t})::int_t
end

function Local_Dgstrf2(options, k, thresh, BlockUFactor, arg5, arg6, arg7, arg8, info, arg10)
    @ccall libsuperlu_dist_Int64.Local_Dgstrf2(options::Ptr{superlu_dist_options_t}, k::int_t, thresh::Cdouble, BlockUFactor::Ptr{Cdouble}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{dLocalLU_t{Int64}}, arg8::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint}, arg10::Ptr{SCT_t})::Cvoid
end

function dTrs2_GatherU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int64.dTrs2_GatherU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, tempv::Ptr{Cdouble})::int_t
end

function dTrs2_ScatterU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int64.dTrs2_ScatterU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, tempv::Ptr{Cdouble})::int_t
end

function dTrs2_GatherTrsmScatter(klst, iukp, rukp, usub, uval, tempv, knsupc, nsupr, lusup, Glu_persist)
    @ccall libsuperlu_dist_Int64.dTrs2_GatherTrsmScatter(klst::int_t, iukp::int_t, rukp::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, tempv::Ptr{Cdouble}, knsupc::int_t, nsupr::Cint, lusup::Ptr{Cdouble}, Glu_persist::Ptr{Glu_persist_t})::int_t
end

function pdgstrs2(m, k0, k, Glu_persist, grid, Llu, stat)
    @ccall libsuperlu_dist_Int64.pdgstrs2(m::int_t, k0::int_t, k::int_t, Glu_persist::Ptr{Glu_persist_t}, grid::Ptr{gridinfo_t{Int64}}, Llu::Ptr{dLocalLU_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function pdgstrf2(arg1, nsupers, k0, k, thresh, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.pdgstrf2(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, k0::int_t, k::int_t, thresh::Cdouble, arg6::Ptr{Glu_persist_t}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{dLocalLU_t{Int64}}, arg9::Ptr{MPI_Request}, arg10::Cint, arg11::Ptr{SuperLUStat_t{Int64}}, arg12::Ptr{Cint})::Cvoid
end

function dAllocLlu_3d(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dAllocLlu_3d(nsupers::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dp3dScatter(n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dp3dScatter(n::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dscatter3dLPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dscatter3dLPanels(nsupers::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dscatter3dUPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dscatter3dUPanels(nsupers::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dcollect3dLpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dcollect3dLpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dcollect3dUpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dcollect3dUpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dp3dCollect(layer, n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dp3dCollect(layer::int_t, n::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dzeroSetLU(nnodes, nodeList, arg3, arg4)
    @ccall libsuperlu_dist_Int64.dzeroSetLU(nnodes::int_t, nodeList::Ptr{int_t}, arg3::Ptr{dLUstruct_t{Int64}}, arg4::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dAllocGlu_3d(n, nsupers, arg3)
    @ccall libsuperlu_dist_Int64.dAllocGlu_3d(n::int_t, nsupers::int_t, arg3::Ptr{dLUstruct_t{Int64}})::Cint
end

function dDeAllocLlu_3d(n, arg2, arg3)
    @ccall libsuperlu_dist_Int64.dDeAllocLlu_3d(n::int_t, arg2::Ptr{dLUstruct_t{Int64}}, arg3::Ptr{gridinfo3d_t{Int64}})::Cint
end

function dDeAllocGlu_3d(arg1)
    @ccall libsuperlu_dist_Int64.dDeAllocGlu_3d(arg1::Ptr{dLUstruct_t{Int64}})::Cint
end

function dreduceAncestors3d(sender, receiver, nnodes, nodeList, Lval_buf, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dreduceAncestors3d(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, Uval_buf::Ptr{Cdouble}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function dreduceAllAncestors3d(ilvl, myNodeCount, treePerm, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dreduceAllAncestors3d(ilvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}}, LUvsb::Ptr{dLUValSubBuf_t{Int64}}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::Cint
end

function dgatherFactoredLU(sender, receiver, nnodes, nodeList, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dgatherFactoredLU(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, LUvsb::Ptr{dLUValSubBuf_t{Int64}}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function dgatherAllFactoredLU(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dgatherAllFactoredLU(trf3Dpartition::Ptr{dtrf3Dpartition_t{Int64}}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function dinit3DLUstruct(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.dinit3DLUstruct(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function dzSendLPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dzSendLPanel(k::int_t, receiver::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function dzRecvLPanel(k, sender, alpha, beta, Lval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dzRecvLPanel(k::int_t, sender::int_t, alpha::Cdouble, beta::Cdouble, Lval_buf::Ptr{Cdouble}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function dzSendUPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dzSendUPanel(k::int_t, receiver::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function dzRecvUPanel(k, sender, alpha, beta, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.dzRecvUPanel(k::int_t, sender::int_t, alpha::Cdouble, beta::Cdouble, Uval_buf::Ptr{Cdouble}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function dIBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, arg7, ToSendR, xsup, arg10)
    @ccall libsuperlu_dist_Int64.dIBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cdouble}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg10::Cint)::int_t
end

function dBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, ToSendR, xsup, arg9, arg10)
    @ccall libsuperlu_dist_Int64.dBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cdouble}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg9::Ptr{SCT_t}, arg10::Cint)::int_t
end

function dIBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, arg7, ToSendD, arg9)
    @ccall libsuperlu_dist_Int64.dIBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendD::Ptr{Cint}, arg9::Cint)::int_t
end

function dBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, ToSendD, arg8, arg9)
    @ccall libsuperlu_dist_Int64.dBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{Cdouble}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, ToSendD::Ptr{Cint}, arg8::Ptr{SCT_t}, arg9::Cint)::int_t
end

function dIrecv_LPanel(k, k0, Lsub_buf, Lval_buf, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dIrecv_LPanel(k::int_t, k0::int_t, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{MPI_Request}, arg7::Ptr{dLocalLU_t{Int64}}, arg8::Cint)::int_t
end

function dIrecv_UPanel(k, k0, Usub_buf, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dIrecv_UPanel(k::int_t, k0::int_t, Usub_buf::Ptr{int_t}, arg4::Ptr{Cdouble}, arg5::Ptr{dLocalLU_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{MPI_Request}, arg8::Cint)::int_t
end

function dWait_URecv(arg1, msgcnt, arg3)
    @ccall libsuperlu_dist_Int64.dWait_URecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, arg3::Ptr{SCT_t})::int_t
end

function dWait_LRecv(arg1, msgcnt, msgcntsU, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dWait_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, msgcntsU::Ptr{Cint}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{SCT_t})::int_t
end

function dISend_UDiagBlock(k0, ublk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.dISend_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Cint)::int_t
end

function dRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, src::int_t, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{SCT_t}, arg7::Cint)::int_t
end

function dPackLBlock(k, Dest, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dPackLBlock(k::int_t, Dest::Ptr{Cdouble}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{dLocalLU_t{Int64}})::int_t
end

function dISend_LDiagBlock(k0, lblk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.dISend_LDiagBlock(k0::int_t, lblk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Cint)::int_t
end

function dIRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dIRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function dIRecv_LDiagBlock(k0, L_blk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dIRecv_LDiagBlock(k0::int_t, L_blk_ptr::Ptr{Cdouble}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function dUDiagBlockRecvWait(k, IrecvPlcd_D, factored_L, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dUDiagBlockRecvWait(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{dLUstruct_t{Int64}}, arg7::Ptr{SCT_t})::int_t
end

function LDiagBlockRecvWait(k, factored_U, arg3, arg4)
    @ccall libsuperlu_dist_Int64.LDiagBlockRecvWait(k::int_t, factored_U::Ptr{int_t}, arg3::Ptr{MPI_Request}, arg4::Ptr{gridinfo_t{Int64}})::int_t
end

function dIBcast_UDiagBlock(k, ublk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dIBcast_UDiagBlock(k::int_t, ublk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}})::int_t
end

function dIBcast_LDiagBlock(k, lblk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dIBcast_LDiagBlock(k::int_t, lblk_ptr::Ptr{Cdouble}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}})::int_t
end

function dDiagFactIBCast(k, k0, BlockUFactor, BlockLFactor, IrecvPlcd_D, arg6, arg7, arg8, arg9, arg10, arg11, thresh, LUstruct, arg14, info, arg16, tag_ub)
    @ccall libsuperlu_dist_Int64.dDiagFactIBCast(k::int_t, k0::int_t, BlockUFactor::Ptr{Cdouble}, BlockLFactor::Ptr{Cdouble}, IrecvPlcd_D::Ptr{int_t}, arg6::Ptr{MPI_Request}, arg7::Ptr{MPI_Request}, arg8::Ptr{MPI_Request}, arg9::Ptr{MPI_Request}, arg10::Ptr{gridinfo_t{Int64}}, arg11::Ptr{superlu_dist_options_t}, thresh::Cdouble, LUstruct::Ptr{dLUstruct_t{Int64}}, arg14::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint}, arg16::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function dUPanelTrSolve(k, BlockLFactor, bigV, ldt, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.dUPanelTrSolve(k::int_t, BlockLFactor::Ptr{Cdouble}, bigV::Ptr{Cdouble}, ldt::int_t, arg5::Ptr{Ublock_info_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{dLUstruct_t{Int64}}, arg8::Ptr{SuperLUStat_t{Int64}}, arg9::Ptr{SCT_t})::int_t
end

function dLPanelUpdate(k, IrecvPlcd_D, factored_L, arg4, BlockUFactor, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dLPanelUpdate(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, BlockUFactor::Ptr{Cdouble}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{dLUstruct_t{Int64}}, arg8::Ptr{SCT_t})::int_t
end

function dUPanelUpdate(k, factored_U, arg3, BlockLFactor, bigV, ldt, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.dUPanelUpdate(k::int_t, factored_U::Ptr{int_t}, arg3::Ptr{MPI_Request}, BlockLFactor::Ptr{Cdouble}, bigV::Ptr{Cdouble}, ldt::int_t, arg7::Ptr{Ublock_info_t}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{dLUstruct_t{Int64}}, arg10::Ptr{SuperLUStat_t{Int64}}, arg11::Ptr{SCT_t})::int_t
end

function dIBcastRecvLPanel(k, k0, msgcnt, arg4, arg5, Lsub_buf, Lval_buf, factored, arg9, arg10, arg11, tag_ub)
    @ccall libsuperlu_dist_Int64.dIBcastRecvLPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, factored::Ptr{int_t}, arg9::Ptr{gridinfo_t{Int64}}, arg10::Ptr{dLUstruct_t{Int64}}, arg11::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function dIBcastRecvUPanel(k, k0, msgcnt, arg4, arg5, Usub_buf, Uval_buf, arg8, arg9, arg10, tag_ub)
    @ccall libsuperlu_dist_Int64.dIBcastRecvUPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{Cdouble}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{dLUstruct_t{Int64}}, arg10::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function dWaitL(k, msgcnt, msgcntU, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.dWaitL(k::int_t, msgcnt::Ptr{Cint}, msgcntU::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{dLUstruct_t{Int64}}, arg8::Ptr{SCT_t})::int_t
end

function dWaitU(k, msgcnt, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dWaitU(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{MPI_Request}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{dLUstruct_t{Int64}}, arg7::Ptr{SCT_t})::int_t
end

function dLPanelTrSolve(k, factored_L, BlockUFactor, arg4, arg5)
    @ccall libsuperlu_dist_Int64.dLPanelTrSolve(k::int_t, factored_L::Ptr{int_t}, BlockUFactor::Ptr{Cdouble}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{dLUstruct_t{Int64}})::int_t
end

function getNsupers(arg1, arg2)
    @ccall libsuperlu_dist_Int64.getNsupers(arg1::Cint, arg2::Ptr{Glu_persist_t})::Cint
end

function initPackLUInfo(nsupers, packLUInfo)
    @ccall libsuperlu_dist_Int64.initPackLUInfo(nsupers::int_t, packLUInfo::Ptr{packLUInfo_t{Int64}})::int_t
end

function freePackLUInfo(packLUInfo)
    @ccall libsuperlu_dist_Int64.freePackLUInfo(packLUInfo::Ptr{packLUInfo_t{Int64}})::Cint
end

function dSchurComplementSetup(k, msgcnt, arg3, arg4, arg5, arg6, arg7, arg8, arg9, bigU, Lsub_buf, Lval_buf, Usub_buf, Uval_buf, arg15, arg16)
    @ccall libsuperlu_dist_Int64.dSchurComplementSetup(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{Ublock_info_t}, arg4::Ptr{Remain_info_t}, arg5::Ptr{uPanelInfo_t{Int64}}, arg6::Ptr{lPanelInfo_t{Int64}}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, bigU::Ptr{Cdouble}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cdouble}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{Cdouble}, arg15::Ptr{gridinfo_t{Int64}}, arg16::Ptr{dLUstruct_t{Int64}})::int_t
end

function dSchurComplementSetupGPU(k, msgs, arg3, arg4, arg5, arg6, arg7, arg8, arg9, LUvsb, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.dSchurComplementSetupGPU(k::int_t, msgs::Ptr{msgs_t}, arg3::Ptr{packLUInfo_t{Int64}}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{gEtreeInfo_t{Int64}}, arg8::Ptr{factNodelists_t{Int64}}, arg9::Ptr{dscuBufs_t}, LUvsb::Ptr{dLUValSubBuf_t{Int64}}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{dLUstruct_t{Int64}}, arg13::Ptr{HyP_t})::int_t
end

function dgetBigV(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dgetBigV(arg1::int_t, arg2::int_t)::Ptr{Cdouble}
end

function dgetBigU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.dgetBigU(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{dLUstruct_t{Int64}})::Ptr{Cdouble}
end

function dLluBufInit(arg1, arg2)
    @ccall libsuperlu_dist_Int64.dLluBufInit(arg1::Ptr{dLUValSubBuf_t{Int64}}, arg2::Ptr{dLUstruct_t{Int64}})::int_t
end

function dinitScuBufs(arg1, ldt, num_threads, nsupers, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.dinitScuBufs(arg1::Ptr{superlu_dist_options_t}, ldt::int_t, num_threads::int_t, nsupers::int_t, arg5::Ptr{dscuBufs_t}, arg6::Ptr{dLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::int_t
end

function dfreeScuBufs(scuBufs)
    @ccall libsuperlu_dist_Int64.dfreeScuBufs(scuBufs::Ptr{dscuBufs_t})::Cint
end

function dsparseTreeFactor(nnodes, perm_c_supno, treeTopoInfo, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, info)
    @ccall libsuperlu_dist_Int64.dsparseTreeFactor(nnodes::int_t, perm_c_supno::Ptr{int_t}, treeTopoInfo::Ptr{treeTopoInfo_t{Int64}}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{dscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgs::Ptr{msgs_t}, LUvsb::Ptr{dLUValSubBuf_t{Int64}}, dFBuf::Ptr{ddiagFactBufs_t}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, info::Ptr{Cint})::int_t
end

function ddenseTreeFactor(nnnodes, perm_c_supno, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int64.ddenseTreeFactor(nnnodes::int_t, perm_c_supno::Ptr{int_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{dscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgs::Ptr{msgs_t}, LUvsb::Ptr{dLUValSubBuf_t{Int64}}, dFBuf::Ptr{ddiagFactBufs_t}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function dsparseTreeFactor_ASYNC(sforest, comReqss, scuBufs, packLUInfo, msgss, LUvsbs, dFBufs, factStat, fNlists, gEtreeInfo, options, gIperm_c_supno, ldt, HyP, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int64.dsparseTreeFactor_ASYNC(sforest::Ptr{sForest_t{Int64}}, comReqss::Ptr{Ptr{commRequests_t}}, scuBufs::Ptr{dscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgss::Ptr{Ptr{msgs_t}}, LUvsbs::Ptr{Ptr{dLUValSubBuf_t{Int64}}}, dFBufs::Ptr{Ptr{ddiagFactBufs_t}}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, gEtreeInfo::Ptr{gEtreeInfo_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, HyP::Ptr{HyP_t}, LUstruct::Ptr{dLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function dLluBufInitArr(numLA, LUstruct)
    @ccall libsuperlu_dist_Int64.dLluBufInitArr(numLA::int_t, LUstruct::Ptr{dLUstruct_t{Int64}})::Ptr{Ptr{dLUValSubBuf_t{Int64}}}
end

function dLluBufFreeArr(numLA, LUvsbs)
    @ccall libsuperlu_dist_Int64.dLluBufFreeArr(numLA::int_t, LUvsbs::Ptr{Ptr{dLUValSubBuf_t{Int64}}})::Cint
end

function dinitDiagFactBufsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_dist_Int64.dinitDiagFactBufsArr(mxLeafNode::int_t, ldt::int_t, grid::Ptr{gridinfo_t{Int64}})::Ptr{Ptr{ddiagFactBufs_t}}
end

function dfreeDiagFactBufsArr(mxLeafNode, dFBufs)
    @ccall libsuperlu_dist_Int64.dfreeDiagFactBufsArr(mxLeafNode::int_t, dFBufs::Ptr{Ptr{ddiagFactBufs_t}})::Cint
end

function dinitDiagFactBufs(ldt, dFBuf)
    @ccall libsuperlu_dist_Int64.dinitDiagFactBufs(ldt::int_t, dFBuf::Ptr{ddiagFactBufs_t})::int_t
end

function checkRecvUDiag(k, comReqs, grid, SCT)
    @ccall libsuperlu_dist_Int64.checkRecvUDiag(k::int_t, comReqs::Ptr{commRequests_t}, grid::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function checkRecvLDiag(k, comReqs, arg3, arg4)
    @ccall libsuperlu_dist_Int64.checkRecvLDiag(k::int_t, comReqs::Ptr{commRequests_t}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SCT_t})::int_t
end

# no prototype is found for this function at superlu_defs.h:1122:15, please use with caution
function SuperLU_timer_dist_()
    @ccall libsuperlu_dist_Int64.SuperLU_timer_dist_()::Cdouble
end

function superlu_gridinit(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.superlu_gridinit(arg1::MPI_Comm, arg2::Cint, arg3::Cint, arg4::Ptr{gridinfo_t{Int64}})::Cvoid
end

function superlu_gridmap(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.superlu_gridmap(arg1::MPI_Comm, arg2::Cint, arg3::Cint, arg4::Ptr{Cint}, arg5::Cint, arg6::Ptr{gridinfo_t{Int64}})::Cvoid
end

function superlu_gridexit(arg1)
    @ccall libsuperlu_dist_Int64.superlu_gridexit(arg1::Ptr{gridinfo_t{Int64}})::Cvoid
end

function superlu_gridinit3d(Bcomm, nprow, npcol, npdep, grid)
    @ccall libsuperlu_dist_Int64.superlu_gridinit3d(Bcomm::MPI_Comm, nprow::Cint, npcol::Cint, npdep::Cint, grid::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function superlu_gridmap3d(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.superlu_gridmap3d(arg1::MPI_Comm, arg2::Cint, arg3::Cint, arg4::Cint, arg5::Ptr{Cint}, arg6::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function superlu_gridexit3d(grid)
    @ccall libsuperlu_dist_Int64.superlu_gridexit3d(grid::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function set_default_options_dist(arg1)
    @ccall libsuperlu_dist_Int64.set_default_options_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function print_options_dist(arg1)
    @ccall libsuperlu_dist_Int64.print_options_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function print_sp_ienv_dist(arg1)
    @ccall libsuperlu_dist_Int64.print_sp_ienv_dist(arg1::Ptr{superlu_dist_options_t})::Cvoid
end

function Destroy_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.Destroy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function Destroy_SuperNode_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.Destroy_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function Destroy_SuperMatrix_Store_dist(arg1)
    @ccall libsuperlu_dist_Int64.Destroy_SuperMatrix_Store_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function Destroy_CompCol_Permuted_dist(arg1)
    @ccall libsuperlu_dist_Int64.Destroy_CompCol_Permuted_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function Destroy_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.Destroy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function Destroy_CompRow_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.Destroy_CompRow_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function sp_colorder(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sp_colorder(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{SuperMatrix{Int64}})::Cvoid
end

function sp_symetree_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sp_symetree_dist(arg1::Ptr{int_t}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::int_t, arg5::Ptr{int_t})::Cint
end

function sp_coletree_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.sp_coletree_dist(arg1::Ptr{int_t}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::int_t, arg5::int_t, arg6::Ptr{int_t})::Cint
end

function get_perm_c_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.get_perm_c_dist(arg1::int_t, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{int_t})::Cvoid
end

function at_plus_a_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.at_plus_a_dist(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function genmmd_dist_(arg1, arg2, a, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.genmmd_dist_(arg1::Ptr{int_t}, arg2::Ptr{int_t}, a::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Ptr{int_t}, arg12::Ptr{int_t})::Cint
end

function bcast_tree(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.bcast_tree(arg1::Ptr{Cvoid}, arg2::Cint, arg3::MPI_Datatype, arg4::Cint, arg5::Cint, arg6::Ptr{gridinfo_t{Int64}}, arg7::Cint, arg8::Ptr{Cint})::Cvoid
end

function symbfact(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.symbfact(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Glu_persist_t}, arg7::Ptr{Glu_freeable_t{Int64}})::int_t
end

function symbfact_SubInit(options, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.symbfact_SubInit(options::Ptr{superlu_dist_options_t}, arg2::fact_t, arg3::Ptr{Cvoid}, arg4::int_t, arg5::int_t, arg6::int_t, arg7::int_t, arg8::Ptr{Glu_persist_t}, arg9::Ptr{Glu_freeable_t{Int64}})::int_t
end

function symbfact_SubXpand(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.symbfact_SubXpand(arg1::int_t, arg2::int_t, arg3::int_t, arg4::MemType, arg5::Ptr{int_t}, arg6::Ptr{Glu_freeable_t{Int64}})::int_t
end

function symbfact_SubFree(arg1)
    @ccall libsuperlu_dist_Int64.symbfact_SubFree(arg1::Ptr{Glu_freeable_t{Int64}})::int_t
end

function countnz_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.countnz_dist(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{Glu_freeable_t{Int64}})::Cvoid
end

function fixupL_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.fixupL_dist(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{Glu_freeable_t{Int64}})::Int64
end

function TreePostorder_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.TreePostorder_dist(arg1::int_t, arg2::Ptr{int_t})::Ptr{int_t}
end

function smach_dist(arg1)
    @ccall libsuperlu_dist_Int64.smach_dist(arg1::Ptr{Cchar})::Cfloat
end

function dmach_dist(arg1)
    @ccall libsuperlu_dist_Int64.dmach_dist(arg1::Ptr{Cchar})::Cdouble
end

function int32Malloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.int32Malloc_dist(arg1::Cint)::Ptr{Cint}
end

function int32Calloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.int32Calloc_dist(arg1::Cint)::Ptr{Cint}
end

function intMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.intMalloc_dist(arg1::int_t)::Ptr{int_t}
end

function intCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.intCalloc_dist(arg1::int_t)::Ptr{int_t}
end

function mc64id_dist(arg1)
    @ccall libsuperlu_dist_Int64.mc64id_dist(arg1::Ptr{Cint})::Cint
end

function arrive_at_ublock(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.arrive_at_ublock(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::int_t, arg8::int_t, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t{Int64}})::Cvoid
end

function estimate_bigu_size(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.estimate_bigu_size(arg1::int_t, arg2::Ptr{Ptr{int_t}}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{int_t}, arg6::Ptr{int_t})::int_t
end

function sp_ienv_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sp_ienv_dist(arg1::Cint, arg2::Ptr{superlu_dist_options_t})::Cint
end

function ifill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.ifill_dist(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t)::Cvoid
end

function super_stats_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.super_stats_dist(arg1::int_t, arg2::Ptr{int_t})::Cvoid
end

function get_diag_procs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.get_diag_procs(arg1::int_t, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{int_t}})::Cvoid
end

function QuerySpace_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.QuerySpace_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Glu_freeable_t{Int64}}, arg4::Ptr{superlu_dist_mem_usage_t})::int_t
end

function xerr_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.xerr_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cint})::Cint
end

function pxerr_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.pxerr_dist(arg1::Ptr{Cchar}, arg2::Ptr{gridinfo_t{Int64}}, arg3::int_t)::Cvoid
end

function PStatInit(arg1)
    @ccall libsuperlu_dist_Int64.PStatInit(arg1::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function PStatFree(arg1)
    @ccall libsuperlu_dist_Int64.PStatFree(arg1::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function PStatPrint(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.PStatPrint(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperLUStat_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}})::Cvoid
end

function log_memory(arg1, arg2)
    @ccall libsuperlu_dist_Int64.log_memory(arg1::Int64, arg2::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function print_memorylog(arg1, arg2)
    @ccall libsuperlu_dist_Int64.print_memorylog(arg1::Ptr{SuperLUStat_t{Int64}}, arg2::Ptr{Cchar})::Cvoid
end

function superlu_dist_GetVersionNumber(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.superlu_dist_GetVersionNumber(arg1::Ptr{Cint}, arg2::Ptr{Cint}, arg3::Ptr{Cint})::Cint
end

function quickSort(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.quickSort(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t)::Cvoid
end

function quickSortM(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.quickSortM(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t)::Cvoid
end

function partition(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.partition(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t)::int_t
end

function partitionM(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.partitionM(arg1::Ptr{int_t}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t)::int_t
end

function symbfact_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.symbfact_dist(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{SuperMatrix{Int64}}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Pslu_freeable_t}, arg10::Ptr{MPI_Comm}, arg11::Ptr{MPI_Comm}, arg12::Ptr{superlu_dist_mem_usage_t})::Cfloat
end

function get_perm_c_parmetis(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.get_perm_c_parmetis(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Cint, arg5::Cint, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{MPI_Comm})::Cfloat
end

function psymbfact_LUXpandMem(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.psymbfact_LUXpandMem(arg1::Cint, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::Cint, arg7::Cint, arg8::Cint, arg9::Ptr{Pslu_freeable_t}, arg10::Ptr{Llu_symbfact_t}, arg11::Ptr{vtcsInfo_symbfact_t}, arg12::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_LUXpand(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.psymbfact_LUXpand(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::int_t, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Ptr{Pslu_freeable_t}, arg11::Ptr{Llu_symbfact_t}, arg12::Ptr{vtcsInfo_symbfact_t}, arg13::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_LUXpand_RL(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.psymbfact_LUXpand_RL(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{Pslu_freeable_t}, arg8::Ptr{Llu_symbfact_t}, arg9::Ptr{vtcsInfo_symbfact_t}, arg10::Ptr{psymbfact_stat_t})::int_t
end

function psymbfact_prLUXpand(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.psymbfact_prLUXpand(arg1::int_t, arg2::int_t, arg3::Cint, arg4::Ptr{Llu_symbfact_t}, arg5::Ptr{psymbfact_stat_t})::int_t
end

function isort(N, ARRAY1, ARRAY2)
    @ccall libsuperlu_dist_Int64.isort(N::int_t, ARRAY1::Ptr{int_t}, ARRAY2::Ptr{int_t})::Cvoid
end

function isort1(N, ARRAY)
    @ccall libsuperlu_dist_Int64.isort1(N::int_t, ARRAY::Ptr{int_t})::Cvoid
end

function estimate_cpu_time(m, n, k)
    @ccall libsuperlu_dist_Int64.estimate_cpu_time(m::Cint, n::Cint, k::Cint)::Cdouble
end

# no prototype is found for this function at superlu_defs.h:1198:12, please use with caution
function get_thread_per_process()
    @ccall libsuperlu_dist_Int64.get_thread_per_process()::Cint
end

# no prototype is found for this function at superlu_defs.h:1199:14, please use with caution
function get_max_buffer_size()
    @ccall libsuperlu_dist_Int64.get_max_buffer_size()::int_t
end

function get_min(arg1, arg2)
    @ccall libsuperlu_dist_Int64.get_min(arg1::Ptr{int_t}, arg2::int_t)::int_t
end

function compare_pair(arg1, arg2)
    @ccall libsuperlu_dist_Int64.compare_pair(arg1::Ptr{Cvoid}, arg2::Ptr{Cvoid})::Cint
end

function static_partition(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.static_partition(arg1::Ptr{superlu_pair}, arg2::int_t, arg3::Ptr{int_t}, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Cint)::int_t
end

# no prototype is found for this function at superlu_defs.h:1204:12, please use with caution
function get_acc_offload()
    @ccall libsuperlu_dist_Int64.get_acc_offload()::Cint
end

function print_panel_seg_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.print_panel_seg_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t})::Cvoid
end

function check_repfnz_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.check_repfnz_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{int_t})::Cvoid
end

function CheckZeroDiagonal(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.CheckZeroDiagonal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t})::int_t
end

function check_perm_dist(what, n, perm)
    @ccall libsuperlu_dist_Int64.check_perm_dist(what::Ptr{Cchar}, n::int_t, perm::Ptr{int_t})::Cint
end

function PrintDouble5(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.PrintDouble5(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cdouble})::Cvoid
end

function PrintInt10(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.PrintInt10(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{int_t})::Cvoid
end

function PrintInt32(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.PrintInt32(arg1::Ptr{Cchar}, arg2::Cint, arg3::Ptr{Cint})::Cvoid
end

function file_PrintInt10(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.file_PrintInt10(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{int_t})::Cint
end

function file_PrintInt32(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.file_PrintInt32(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::Cint, arg4::Ptr{Cint})::Cint
end

function file_PrintLong10(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.file_PrintLong10(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{int_t})::Cint
end

function C_RdTree_Create(tree, comm, ranks, rank_cnt, msgSize, precision)
    @ccall libsuperlu_dist_Int64.C_RdTree_Create(tree::Ptr{C_Tree}, comm::MPI_Comm, ranks::Ptr{Cint}, rank_cnt::Cint, msgSize::Cint, precision::Cchar)::Cvoid
end

function C_RdTree_Nullify(tree)
    @ccall libsuperlu_dist_Int64.C_RdTree_Nullify(tree::Ptr{C_Tree})::Cvoid
end

function C_RdTree_IsRoot(tree)
    @ccall libsuperlu_dist_Int64.C_RdTree_IsRoot(tree::Ptr{C_Tree})::yes_no_t
end

function C_RdTree_forwardMessageSimple(Tree, localBuffer, msgSize)
    @ccall libsuperlu_dist_Int64.C_RdTree_forwardMessageSimple(Tree::Ptr{C_Tree}, localBuffer::Ptr{Cvoid}, msgSize::Cint)::Cvoid
end

function C_RdTree_waitSendRequest(Tree)
    @ccall libsuperlu_dist_Int64.C_RdTree_waitSendRequest(Tree::Ptr{C_Tree})::Cvoid
end

function C_BcTree_Create(tree, comm, ranks, rank_cnt, msgSize, precision)
    @ccall libsuperlu_dist_Int64.C_BcTree_Create(tree::Ptr{C_Tree}, comm::MPI_Comm, ranks::Ptr{Cint}, rank_cnt::Cint, msgSize::Cint, precision::Cchar)::Cvoid
end

function C_BcTree_Nullify(tree)
    @ccall libsuperlu_dist_Int64.C_BcTree_Nullify(tree::Ptr{C_Tree})::Cvoid
end

function C_BcTree_IsRoot(tree)
    @ccall libsuperlu_dist_Int64.C_BcTree_IsRoot(tree::Ptr{C_Tree})::yes_no_t
end

function C_BcTree_forwardMessageSimple(tree, localBuffer, msgSize)
    @ccall libsuperlu_dist_Int64.C_BcTree_forwardMessageSimple(tree::Ptr{C_Tree}, localBuffer::Ptr{Cvoid}, msgSize::Cint)::Cvoid
end

function C_BcTree_waitSendRequest(tree)
    @ccall libsuperlu_dist_Int64.C_BcTree_waitSendRequest(tree::Ptr{C_Tree})::Cvoid
end

function DistPrint(function_name, value, Units, grid)
    @ccall libsuperlu_dist_Int64.DistPrint(function_name::Ptr{Cchar}, value::Cdouble, Units::Ptr{Cchar}, grid::Ptr{gridinfo_t{Int64}})::Cvoid
end

function DistPrint3D(function_name, value, Units, grid3d)
    @ccall libsuperlu_dist_Int64.DistPrint3D(function_name::Ptr{Cchar}, value::Cdouble, Units::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function treeImbalance3D(grid3d, SCT)
    @ccall libsuperlu_dist_Int64.treeImbalance3D(grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::Cvoid
end

function SCT_printComm3D(grid3d, SCT)
    @ccall libsuperlu_dist_Int64.SCT_printComm3D(grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::Cvoid
end

function getPerm_c_supno(nsupers, arg2, etree, Glu_persist, Lrowind_bc_ptr, Ufstnz_br_ptr, arg7)
    @ccall libsuperlu_dist_Int64.getPerm_c_supno(nsupers::int_t, arg2::Ptr{superlu_dist_options_t}, etree::Ptr{int_t}, Glu_persist::Ptr{Glu_persist_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, arg7::Ptr{gridinfo_t{Int64}})::Ptr{int_t}
end

function SCT_init(arg1)
    @ccall libsuperlu_dist_Int64.SCT_init(arg1::Ptr{SCT_t})::Cvoid
end

function SCT_print(grid, SCT)
    @ccall libsuperlu_dist_Int64.SCT_print(grid::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t})::Cvoid
end

function SCT_print3D(grid3d, SCT)
    @ccall libsuperlu_dist_Int64.SCT_print3D(grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::Cvoid
end

function SCT_free(arg1)
    @ccall libsuperlu_dist_Int64.SCT_free(arg1::Ptr{SCT_t})::Cvoid
end

function setree2list(nsuper, setree)
    @ccall libsuperlu_dist_Int64.setree2list(nsuper::int_t, setree::Ptr{int_t})::Ptr{treeList_t{Int64}}
end

function free_treelist(nsuper, treeList)
    @ccall libsuperlu_dist_Int64.free_treelist(nsuper::int_t, treeList::Ptr{treeList_t{Int64}})::Cint
end

function calcTreeWeight(nsupers, setree, treeList, xsup)
    @ccall libsuperlu_dist_Int64.calcTreeWeight(nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t{Int64}}, xsup::Ptr{int_t})::int_t
end

function getDescendList(k, dlist, treeList)
    @ccall libsuperlu_dist_Int64.getDescendList(k::int_t, dlist::Ptr{int_t}, treeList::Ptr{treeList_t{Int64}})::int_t
end

function getCommonAncestorList(k, alist, seTree, treeList)
    @ccall libsuperlu_dist_Int64.getCommonAncestorList(k::int_t, alist::Ptr{int_t}, seTree::Ptr{int_t}, treeList::Ptr{treeList_t{Int64}})::int_t
end

function getCommonAncsCount(k, treeList)
    @ccall libsuperlu_dist_Int64.getCommonAncsCount(k::int_t, treeList::Ptr{treeList_t{Int64}})::int_t
end

function getPermNodeList(nnode, nlist, perm_c_sup, iperm_c_sup)
    @ccall libsuperlu_dist_Int64.getPermNodeList(nnode::int_t, nlist::Ptr{int_t}, perm_c_sup::Ptr{int_t}, iperm_c_sup::Ptr{int_t})::Ptr{int_t}
end

function getEtreeLB(nnodes, perm_l, gTopOrder)
    @ccall libsuperlu_dist_Int64.getEtreeLB(nnodes::int_t, perm_l::Ptr{int_t}, gTopOrder::Ptr{int_t})::Ptr{int_t}
end

function getSubTreeRoots(k, treeList)
    @ccall libsuperlu_dist_Int64.getSubTreeRoots(k::int_t, treeList::Ptr{treeList_t{Int64}})::Ptr{int_t}
end

function merg_perms(nperms, nnodes, perms)
    @ccall libsuperlu_dist_Int64.merg_perms(nperms::int_t, nnodes::Ptr{int_t}, perms::Ptr{Ptr{int_t}})::Ptr{int_t}
end

function getGlobal_iperm(nsupers, nperms, perms, nnodes)
    @ccall libsuperlu_dist_Int64.getGlobal_iperm(nsupers::int_t, nperms::int_t, perms::Ptr{Ptr{int_t}}, nnodes::Ptr{int_t})::Ptr{int_t}
end

function log2i(index)
    @ccall libsuperlu_dist_Int64.log2i(index::int_t)::int_t
end

function supernodal_etree(nsuper, etree, supno, xsup)
    @ccall libsuperlu_dist_Int64.supernodal_etree(nsuper::int_t, etree::Ptr{int_t}, supno::Ptr{int_t}, xsup::Ptr{int_t})::Ptr{int_t}
end

function testSubtreeNodelist(nsupers, numList, nodeList, nodeCount)
    @ccall libsuperlu_dist_Int64.testSubtreeNodelist(nsupers::int_t, numList::int_t, nodeList::Ptr{Ptr{int_t}}, nodeCount::Ptr{int_t})::int_t
end

function testListPerm(nodeCount, nodeList, permList, gTopLevel)
    @ccall libsuperlu_dist_Int64.testListPerm(nodeCount::int_t, nodeList::Ptr{int_t}, permList::Ptr{int_t}, gTopLevel::Ptr{int_t})::int_t
end

function topological_ordering(nsuper, setree)
    @ccall libsuperlu_dist_Int64.topological_ordering(nsuper::int_t, setree::Ptr{int_t})::Ptr{int_t}
end

function Etree_LevelBoundry(perm, tsort_etree, nsuper)
    @ccall libsuperlu_dist_Int64.Etree_LevelBoundry(perm::Ptr{int_t}, tsort_etree::Ptr{int_t}, nsuper::int_t)::Ptr{int_t}
end

function calculate_num_children(nsuper, setree)
    @ccall libsuperlu_dist_Int64.calculate_num_children(nsuper::int_t, setree::Ptr{int_t})::Ptr{int_t}
end

function Print_EtreeLevelBoundry(Etree_LvlBdry, max_level, nsuper)
    @ccall libsuperlu_dist_Int64.Print_EtreeLevelBoundry(Etree_LvlBdry::Ptr{int_t}, max_level::int_t, nsuper::int_t)::Cvoid
end

function print_etree_leveled(setree, tsort_etree, nsuper)
    @ccall libsuperlu_dist_Int64.print_etree_leveled(setree::Ptr{int_t}, tsort_etree::Ptr{int_t}, nsuper::int_t)::Cvoid
end

function print_etree(setree, iperm, nsuper)
    @ccall libsuperlu_dist_Int64.print_etree(setree::Ptr{int_t}, iperm::Ptr{int_t}, nsuper::int_t)::Cvoid
end

function printFileList(sname, nnodes, dlist, setree)
    @ccall libsuperlu_dist_Int64.printFileList(sname::Ptr{Cchar}, nnodes::int_t, dlist::Ptr{int_t}, setree::Ptr{int_t})::int_t
end

function getLastDepBtree(nsupers, treeList)
    @ccall libsuperlu_dist_Int64.getLastDepBtree(nsupers::int_t, treeList::Ptr{treeList_t{Int64}})::Ptr{Cint}
end

function getReplicatedTrees(grid3d)
    @ccall libsuperlu_dist_Int64.getReplicatedTrees(grid3d::Ptr{gridinfo3d_t{Int64}})::Ptr{int_t}
end

function getGridTrees(grid3d)
    @ccall libsuperlu_dist_Int64.getGridTrees(grid3d::Ptr{gridinfo3d_t{Int64}})::Ptr{int_t}
end

function getNodeList(maxLvl, setree, nnodes, treeHeads, treeList)
    @ccall libsuperlu_dist_Int64.getNodeList(maxLvl::int_t, setree::Ptr{int_t}, nnodes::Ptr{int_t}, treeHeads::Ptr{int_t}, treeList::Ptr{treeList_t{Int64}})::Ptr{Ptr{int_t}}
end

function calcNumNodes(maxLvl, treeHeads, treeList)
    @ccall libsuperlu_dist_Int64.calcNumNodes(maxLvl::int_t, treeHeads::Ptr{int_t}, treeList::Ptr{treeList_t{Int64}})::Ptr{int_t}
end

function getTreeHeads(maxLvl, nsupers, treeList)
    @ccall libsuperlu_dist_Int64.getTreeHeads(maxLvl::int_t, nsupers::int_t, treeList::Ptr{treeList_t{Int64}})::Ptr{int_t}
end

function getMyIperm(nnodes, nsupers, myPerm)
    @ccall libsuperlu_dist_Int64.getMyIperm(nnodes::int_t, nsupers::int_t, myPerm::Ptr{int_t})::Ptr{int_t}
end

function getMyTopOrder(nnodes, myPerm, myIperm, setree)
    @ccall libsuperlu_dist_Int64.getMyTopOrder(nnodes::int_t, myPerm::Ptr{int_t}, myIperm::Ptr{int_t}, setree::Ptr{int_t})::Ptr{int_t}
end

function getMyEtLims(nnodes, myTopOrder)
    @ccall libsuperlu_dist_Int64.getMyEtLims(nnodes::int_t, myTopOrder::Ptr{int_t})::Ptr{int_t}
end

function getMyTreeTopoInfo(nnodes, nsupers, myPerm, setree)
    @ccall libsuperlu_dist_Int64.getMyTreeTopoInfo(nnodes::int_t, nsupers::int_t, myPerm::Ptr{int_t}, setree::Ptr{int_t})::treeTopoInfo_t{Int64}
end

function getNestDissForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_dist_Int64.getNestDissForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t{Int64}})::Ptr{Ptr{sForest_t{Int64}}}
end

function getTreePermForest(myTreeIdxs, myZeroTrIdxs, sForests, perm_c_supno, iperm_c_supno, grid3d)
    @ccall libsuperlu_dist_Int64.getTreePermForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t{Int64}}, perm_c_supno::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, grid3d::Ptr{gridinfo3d_t{Int64}})::Ptr{Ptr{int_t}}
end

function getTreePermFr(myTreeIdxs, sForests, grid3d)
    @ccall libsuperlu_dist_Int64.getTreePermFr(myTreeIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t{Int64}}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Ptr{Ptr{int_t}}
end

function getMyNodeCountsFr(maxLvl, myTreeIdxs, sForests)
    @ccall libsuperlu_dist_Int64.getMyNodeCountsFr(maxLvl::int_t, myTreeIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t{Int64}}})::Ptr{int_t}
end

function getNodeListFr(maxLvl, sForests)
    @ccall libsuperlu_dist_Int64.getNodeListFr(maxLvl::int_t, sForests::Ptr{Ptr{sForest_t{Int64}}})::Ptr{Ptr{int_t}}
end

function getNodeCountsFr(maxLvl, sForests)
    @ccall libsuperlu_dist_Int64.getNodeCountsFr(maxLvl::int_t, sForests::Ptr{Ptr{sForest_t{Int64}}})::Ptr{int_t}
end

function getIsNodeInMyGrid(nsupers, maxLvl, myNodeCount, treePerm)
    @ccall libsuperlu_dist_Int64.getIsNodeInMyGrid(nsupers::int_t, maxLvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}})::Ptr{Cint}
end

function printForestWeightCost(sForests, SCT, grid3d)
    @ccall libsuperlu_dist_Int64.printForestWeightCost(sForests::Ptr{Ptr{sForest_t{Int64}}}, SCT::Ptr{SCT_t}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function getGreedyLoadBalForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_dist_Int64.getGreedyLoadBalForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t{Int64}})::Ptr{Ptr{sForest_t{Int64}}}
end

function getForests(maxLvl, nsupers, setree, treeList)
    @ccall libsuperlu_dist_Int64.getForests(maxLvl::int_t, nsupers::int_t, setree::Ptr{int_t}, treeList::Ptr{treeList_t{Int64}})::Ptr{Ptr{sForest_t{Int64}}}
end

function getBigUSize(arg1, nsupers, grid, Lrowind_bc_ptr)
    @ccall libsuperlu_dist_Int64.getBigUSize(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, grid::Ptr{gridinfo_t{Int64}}, Lrowind_bc_ptr::Ptr{Ptr{int_t}})::int_t
end

function getSCUweight(nsupers, treeList, xsup, Lrowind_bc_ptr, Ufstnz_br_ptr, grid3d)
    @ccall libsuperlu_dist_Int64.getSCUweight(nsupers::int_t, treeList::Ptr{treeList_t{Int64}}, xsup::Ptr{int_t}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function Wait_LUDiagSend(k, U_diag_blk_send_req, L_diag_blk_send_req, grid, SCT)
    @ccall libsuperlu_dist_Int64.Wait_LUDiagSend(k::int_t, U_diag_blk_send_req::Ptr{MPI_Request}, L_diag_blk_send_req::Ptr{MPI_Request}, grid::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t})::Cint
end

# no prototype is found for this function at superlu_defs.h:1368:12, please use with caution
function set_tag_ub()
    @ccall libsuperlu_dist_Int64.set_tag_ub()::Cint
end

function getNumThreads(arg1)
    @ccall libsuperlu_dist_Int64.getNumThreads(arg1::Cint)::Cint
end

function num_full_cols_U(kk, Ufstnz_br_ptr, xsup, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.num_full_cols_U(kk::int_t, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, xsup::Ptr{int_t}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{int_t}, arg6::Ptr{int_t})::int_t
end

function getFactPerm(arg1)
    @ccall libsuperlu_dist_Int64.getFactPerm(arg1::int_t)::Ptr{int_t}
end

function getFactIperm(arg1, arg2)
    @ccall libsuperlu_dist_Int64.getFactIperm(arg1::Ptr{int_t}, arg2::int_t)::Ptr{int_t}
end

function initCommRequests(comReqs, grid)
    @ccall libsuperlu_dist_Int64.initCommRequests(comReqs::Ptr{commRequests_t}, grid::Ptr{gridinfo_t{Int64}})::int_t
end

function initFactStat(nsupers, factStat)
    @ccall libsuperlu_dist_Int64.initFactStat(nsupers::int_t, factStat::Ptr{factStat_t{Int64}})::int_t
end

function freeFactStat(factStat)
    @ccall libsuperlu_dist_Int64.freeFactStat(factStat::Ptr{factStat_t{Int64}})::Cint
end

function initFactNodelists(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.initFactNodelists(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{factNodelists_t{Int64}})::int_t
end

function freeFactNodelists(fNlists)
    @ccall libsuperlu_dist_Int64.freeFactNodelists(fNlists::Ptr{factNodelists_t{Int64}})::Cint
end

function initMsgs(msgs)
    @ccall libsuperlu_dist_Int64.initMsgs(msgs::Ptr{msgs_t})::int_t
end

function getNumLookAhead(arg1)
    @ccall libsuperlu_dist_Int64.getNumLookAhead(arg1::Ptr{superlu_dist_options_t})::int_t
end

function initCommRequestsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_dist_Int64.initCommRequestsArr(mxLeafNode::int_t, ldt::int_t, grid::Ptr{gridinfo_t{Int64}})::Ptr{Ptr{commRequests_t}}
end

function freeCommRequestsArr(mxLeafNode, comReqss)
    @ccall libsuperlu_dist_Int64.freeCommRequestsArr(mxLeafNode::int_t, comReqss::Ptr{Ptr{commRequests_t}})::Cint
end

function initMsgsArr(numLA)
    @ccall libsuperlu_dist_Int64.initMsgsArr(numLA::int_t)::Ptr{Ptr{msgs_t}}
end

function freeMsgsArr(numLA, msgss)
    @ccall libsuperlu_dist_Int64.freeMsgsArr(numLA::int_t, msgss::Ptr{Ptr{msgs_t}})::Cint
end

function Trs2_InitUblock_info(klst, nb, arg3, usub, arg5, arg6)
    @ccall libsuperlu_dist_Int64.Trs2_InitUblock_info(klst::int_t, nb::int_t, arg3::Ptr{Ublock_info_t}, usub::Ptr{int_t}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{SuperLUStat_t{Int64}})::int_t
end

function Cmpfunc_R_info(a, b)
    @ccall libsuperlu_dist_Int64.Cmpfunc_R_info(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function Cmpfunc_U_info(a, b)
    @ccall libsuperlu_dist_Int64.Cmpfunc_U_info(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function sort_R_info(Remain_info, n)
    @ccall libsuperlu_dist_Int64.sort_R_info(Remain_info::Ptr{Remain_info_t}, n::Cint)::Cint
end

function sort_U_info(Ublock_info, n)
    @ccall libsuperlu_dist_Int64.sort_U_info(Ublock_info::Ptr{Ublock_info_t}, n::Cint)::Cint
end

function sort_R_info_elm(Remain_info, n)
    @ccall libsuperlu_dist_Int64.sort_R_info_elm(Remain_info::Ptr{Remain_info_t}, n::Cint)::Cint
end

function sort_U_info_elm(Ublock_info, n)
    @ccall libsuperlu_dist_Int64.sort_U_info_elm(Ublock_info::Ptr{Ublock_info_t}, n::Cint)::Cint
end

function printTRStimer(xtrsTimer, grid3d)
    @ccall libsuperlu_dist_Int64.printTRStimer(xtrsTimer::Ptr{xtrsTimer_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function initTRStimer(xtrsTimer, grid)
    @ccall libsuperlu_dist_Int64.initTRStimer(xtrsTimer::Ptr{xtrsTimer_t{Int64}}, grid::Ptr{gridinfo_t{Int64}})::Cvoid
end

function getTreePerm(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, perm_c_supno, iperm_c_supno, grid3d)
    @ccall libsuperlu_dist_Int64.getTreePerm(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, perm_c_supno::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, grid3d::Ptr{gridinfo3d_t{Int64}})::Ptr{Ptr{int_t}}
end

function getMyNodeCounts(maxLvl, myTreeIdxs, gNodeCount)
    @ccall libsuperlu_dist_Int64.getMyNodeCounts(maxLvl::int_t, myTreeIdxs::Ptr{int_t}, gNodeCount::Ptr{int_t})::Ptr{int_t}
end

function checkIntVector3d(vec, len, grid3d)
    @ccall libsuperlu_dist_Int64.checkIntVector3d(vec::Ptr{int_t}, len::int_t, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function reduceStat(PHASE, stat, grid3d)
    @ccall libsuperlu_dist_Int64.reduceStat(PHASE::PhaseType, stat::Ptr{SuperLUStat_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function Wait_LSend(k, grid, ToSendR, s, arg5)
    @ccall libsuperlu_dist_Int64.Wait_LSend(k::int_t, grid::Ptr{gridinfo_t{Int64}}, ToSendR::Ptr{Ptr{Cint}}, s::Ptr{MPI_Request}, arg5::Ptr{SCT_t})::int_t
end

function Wait_USend(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.Wait_USend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{SCT_t})::int_t
end

function Check_LRecv(arg1, msgcnt)
    @ccall libsuperlu_dist_Int64.Check_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint})::int_t
end

function Wait_UDiagBlockSend(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.Wait_UDiagBlockSend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{SCT_t})::int_t
end

function Wait_LDiagBlockSend(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.Wait_LDiagBlockSend(arg1::Ptr{MPI_Request}, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{SCT_t})::int_t
end

function Wait_UDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_dist_Int64.Wait_UDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Test_UDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_dist_Int64.Test_UDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Wait_LDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_dist_Int64.Wait_LDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function Test_LDiagBlock_Recv(arg1, arg2)
    @ccall libsuperlu_dist_Int64.Test_LDiagBlock_Recv(arg1::Ptr{MPI_Request}, arg2::Ptr{SCT_t})::int_t
end

function sCreate_CompCol_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.sCreate_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{Cfloat}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Stype_t, arg9::Dtype_t, arg10::Mtype_t)::Cvoid
end

function sCreate_CompRowLoc_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.sCreate_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{Cfloat}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Stype_t, arg11::Dtype_t, arg12::Mtype_t)::Cvoid
end

function sCompRow_to_CompCol_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.sCompRow_to_CompCol_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{Cfloat}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{Ptr{Cfloat}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{Ptr{int_t}})::Cvoid
end

function psCompRow_loc_to_CompCol_global(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.psCompRow_loc_to_CompCol_global(arg1::int_t, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperMatrix{Int64}})::Cint
end

function sCopy_CompCol_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sCopy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function sCreate_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sCreate_Dense_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::Ptr{Cfloat}, arg5::int_t, arg6::Stype_t, arg7::Dtype_t, arg8::Mtype_t)::Cvoid
end

function sCreate_SuperNode_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.sCreate_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{Cfloat}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Stype_t, arg12::Dtype_t, arg13::Mtype_t)::Cvoid
end

function sCopy_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.sCopy_Dense_Matrix_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cfloat}, arg4::int_t, arg5::Ptr{Cfloat}, arg6::int_t)::Cvoid
end

function sallocateA_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sallocateA_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Ptr{int_t}}, arg5::Ptr{Ptr{int_t}})::Cvoid
end

function sGenXtrue_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.sGenXtrue_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cfloat}, arg4::int_t)::Cvoid
end

function sFillRHS_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sFillRHS_dist(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cfloat}, arg4::int_t, arg5::Ptr{SuperMatrix{Int64}}, arg6::Ptr{Cfloat}, arg7::int_t)::Cvoid
end

function screate_matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.screate_matrix(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function screate_matrix_rb(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.screate_matrix_rb(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function screate_matrix_dat(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.screate_matrix_dat(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function screate_matrix_postfix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.screate_matrix_postfix(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{Cfloat}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{Cchar}, arg9::Ptr{gridinfo_t{Int64}})::Cint
end

function sScalePermstructInit(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.sScalePermstructInit(arg1::int_t, arg2::int_t, arg3::Ptr{sScalePermstruct_t{Int64}})::Cvoid
end

function sScalePermstructFree(arg1)
    @ccall libsuperlu_dist_Int64.sScalePermstructFree(arg1::Ptr{sScalePermstruct_t{Int64}})::Cvoid
end

function sgsequ_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sgsequ_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat}, arg7::Ptr{int_t})::Cvoid
end

function slangs_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.slangs_dist(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix{Int64}})::Cfloat
end

function slaqgs_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.slaqgs_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Cfloat, arg5::Cfloat, arg6::Cfloat, arg7::Ptr{Cchar})::Cvoid
end

function psgsequ(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.psgsequ(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat}, arg7::Ptr{int_t}, arg8::Ptr{gridinfo_t{Int64}})::Cvoid
end

function pslangs(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.pslangs(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}})::Cfloat
end

function pslaqgs(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.pslaqgs(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Cfloat, arg5::Cfloat, arg6::Cfloat, arg7::Ptr{Cchar})::Cvoid
end

function psPermute_Dense_Matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.psPermute_Dense_Matrix(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Cfloat}, arg6::Cint, arg7::Ptr{Cfloat}, arg8::Cint, arg9::Cint, arg10::Ptr{gridinfo_t{Int64}})::Cint
end

function sp_strsv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sp_strsv_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cchar}, arg3::Ptr{Cchar}, arg4::Ptr{SuperMatrix{Int64}}, arg5::Ptr{SuperMatrix{Int64}}, arg6::Ptr{Cfloat}, arg7::Ptr{Cint})::Cint
end

function sp_sgemv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sp_sgemv_dist(arg1::Ptr{Cchar}, arg2::Cfloat, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cfloat, arg7::Ptr{Cfloat}, arg8::Cint)::Cint
end

function sp_sgemm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.sp_sgemm_dist(arg1::Ptr{Cchar}, arg2::Cint, arg3::Cfloat, arg4::Ptr{SuperMatrix{Int64}}, arg5::Ptr{Cfloat}, arg6::Cint, arg7::Cfloat, arg8::Ptr{Cfloat}, arg9::Cint)::Cint
end

function sdistribute(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.sdistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{Glu_freeable_t{Int64}}, arg5::Ptr{sLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}})::Cfloat
end

function psgssvx_ABglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.psgssvx_ABglobal(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{sScalePermstruct_t{Int64}}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{sLUstruct_t{Int64}}, arg9::Ptr{Cfloat}, arg10::Ptr{SuperLUStat_t{Int64}}, arg11::Ptr{Cint})::Cvoid
end

function psdistribute(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.psdistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{sScalePermstruct_t{Int64}}, arg5::Ptr{Glu_freeable_t{Int64}}, arg6::Ptr{sLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::Cfloat
end

function psgssvx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.psgssvx(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{sScalePermstruct_t{Int64}}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{sLUstruct_t{Int64}}, arg9::Ptr{sSOLVEstruct_t{Int64}}, arg10::Ptr{Cfloat}, arg11::Ptr{SuperLUStat_t{Int64}}, arg12::Ptr{Cint})::Cvoid
end

function psCompute_Diag_Inv(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.psCompute_Diag_Inv(arg1::int_t, arg2::Ptr{sLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperLUStat_t{Int64}}, arg5::Ptr{Cint})::Cvoid
end

function sSolveInit(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sSolveInit(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::int_t, arg6::Ptr{sLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{sSOLVEstruct_t{Int64}})::Cint
end

function sSolveFinalize(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sSolveFinalize(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{sSOLVEstruct_t{Int64}})::Cvoid
end

function sDestroy_A3d_gathered_on_2d(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sDestroy_A3d_gathered_on_2d(arg1::Ptr{sSOLVEstruct_t{Int64}}, arg2::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function psgstrs_init(arg1, arg2, arg3, arg4, arg5, arg6, grid, arg8, arg9)
    @ccall libsuperlu_dist_Int64.psgstrs_init(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t}, grid::Ptr{gridinfo_t{Int64}}, arg8::Ptr{Glu_persist_t}, arg9::Ptr{sSOLVEstruct_t{Int64}})::int_t
end

function sldperm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.sldperm_dist(arg1::Cint, arg2::Cint, arg3::int_t, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Cfloat}, arg7::Ptr{int_t}, arg8::Ptr{Cfloat}, arg9::Ptr{Cfloat})::Cint
end

function sstatic_schedule(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.sstatic_schedule(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{sLUstruct_t{Int64}}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{SuperLUStat_t{Int64}}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Cint})::Cint
end

function sLUstructInit(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sLUstructInit(arg1::int_t, arg2::Ptr{sLUstruct_t{Int64}})::Cvoid
end

function sLUstructFree(arg1)
    @ccall libsuperlu_dist_Int64.sLUstructFree(arg1::Ptr{sLUstruct_t{Int64}})::Cvoid
end

function sDestroy_LU(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.sDestroy_LU(arg1::int_t, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{sLUstruct_t{Int64}})::Cvoid
end

function sDestroy_Tree(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.sDestroy_Tree(arg1::int_t, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{sLUstruct_t{Int64}})::Cvoid
end

function sscatter_l(ib, ljb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, usub, lsub, tempv, indirect_thread, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, grid)
    @ccall libsuperlu_dist_Int64.sscatter_l(ib::Cint, ljb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, usub::Ptr{int_t}, lsub::Ptr{int_t}, tempv::Ptr{Cfloat}, indirect_thread::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{Cfloat}}, grid::Ptr{gridinfo_t{Int64}})::Cvoid
end

function sscatter_u(ib, jb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, lsub, usub, tempv, Ufstnz_br_ptr, Unzval_br_ptr, grid)
    @ccall libsuperlu_dist_Int64.sscatter_u(ib::Cint, jb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, lsub::Ptr{int_t}, usub::Ptr{int_t}, tempv::Ptr{Cfloat}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{Cfloat}}, grid::Ptr{gridinfo_t{Int64}})::Cvoid
end

function psgstrf(arg1, arg2, arg3, anorm, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.psgstrf(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, anorm::Cfloat, arg5::Ptr{sLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SuperLUStat_t{Int64}}, arg8::Ptr{Cint})::int_t
end

function psgstrs_Bglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.psgstrs_Bglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{sLUstruct_t{Int64}}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{Cfloat}, arg6::int_t, arg7::Cint, arg8::Ptr{SuperLUStat_t{Int64}}, arg9::Ptr{Cint})::Cvoid
end

function psgstrs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.psgstrs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{sLUstruct_t{Int64}}, arg4::Ptr{sScalePermstruct_t{Int64}}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{Cfloat}, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Cint, arg11::Ptr{sSOLVEstruct_t{Int64}}, arg12::Ptr{SuperLUStat_t{Int64}}, arg13::Ptr{Cint})::Cvoid
end

function psgstrf2_trsm(options, k0, k, thresh, arg5, arg6, arg7, arg8, tag_ub, arg10, info)
    @ccall libsuperlu_dist_Int64.psgstrf2_trsm(options::Ptr{superlu_dist_options_t}, k0::int_t, k::int_t, thresh::Cdouble, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{sLocalLU_t{Int64}}, arg8::Ptr{MPI_Request}, tag_ub::Cint, arg10::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint})::Cvoid
end

function psgstrs2_omp(k0, k, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.psgstrs2_omp(k0::int_t, k::int_t, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{sLocalLU_t{Int64}}, arg6::Ptr{Ublock_info_t}, arg7::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function psReDistribute_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.psReDistribute_B_to_X(B::Ptr{Cfloat}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{Cfloat}, arg8::Ptr{sScalePermstruct_t{Int64}}, arg9::Ptr{Glu_persist_t}, arg10::Ptr{gridinfo_t{Int64}}, arg11::Ptr{sSOLVEstruct_t{Int64}})::int_t
end

function slsum_fmod(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int64.slsum_fmod(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::int_t, arg11::int_t, arg12::Ptr{int_t}, arg13::Ptr{gridinfo_t{Int64}}, arg14::Ptr{sLocalLU_t{Int64}}, arg15::Ptr{MPI_Request}, arg16::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function slsum_bmod(arg1, arg2, arg3, arg4, arg5, bmod, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int64.slsum_bmod(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Cint, arg5::int_t, bmod::Ptr{Cint}, arg7::Ptr{int_t}, arg8::Ptr{Ptr{Ucb_indptr_t}}, arg9::Ptr{Ptr{int_t}}, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{sLocalLU_t{Int64}}, arg13::Ptr{MPI_Request}, arg14::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function slsum_fmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, fmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int64.slsum_fmod_inv(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::int_t, fmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{gridinfo_t{Int64}}, arg10::Ptr{sLocalLU_t{Int64}}, arg11::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg12::Ptr{int_t}, arg13::Ptr{int_t}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function slsum_fmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int64.slsum_fmod_inv_master(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{sLocalLU_t{Int64}}, arg13::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function slsum_bmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    @ccall libsuperlu_dist_Int64.slsum_bmod_inv(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t{Int64}}, arg13::Ptr{sLocalLU_t{Int64}}, arg14::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg15::Ptr{int_t}, arg16::Ptr{int_t}, arg17::int_t, arg18::int_t, arg19::Cint, arg20::Cint)::Cvoid
end

function slsum_bmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    @ccall libsuperlu_dist_Int64.slsum_bmod_inv_master(arg1::Ptr{Cfloat}, arg2::Ptr{Cfloat}, arg3::Ptr{Cfloat}, arg4::Ptr{Cfloat}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t{Int64}}, arg13::Ptr{sLocalLU_t{Int64}}, arg14::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg15::int_t, arg16::int_t, arg17::Cint, arg18::Cint)::Cvoid
end

function sComputeLevelsets(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.sComputeLevelsets(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t{Int64}}, arg6::Ptr{int_t})::Cvoid
end

function psgsrfs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int64.psgsrfs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Cfloat, arg5::Ptr{sLUstruct_t{Int64}}, arg6::Ptr{sScalePermstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{Cfloat}, arg9::int_t, arg10::Ptr{Cfloat}, arg11::int_t, arg12::Cint, arg13::Ptr{sSOLVEstruct_t{Int64}}, arg14::Ptr{Cfloat}, arg15::Ptr{SuperLUStat_t{Int64}}, arg16::Ptr{Cint})::Cvoid
end

function psgsrfs_ABXglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int64.psgsrfs_ABXglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Cfloat, arg5::Ptr{sLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{Cfloat}, arg8::int_t, arg9::Ptr{Cfloat}, arg10::int_t, arg11::Cint, arg12::Ptr{Cfloat}, arg13::Ptr{SuperLUStat_t{Int64}}, arg14::Ptr{Cint})::Cvoid
end

function psgsmv_AXglobal_setup(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.psgsmv_AXglobal_setup(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{int_t})::Cint
end

function psgsmv_AXglobal(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.psgsmv_AXglobal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Cfloat}, arg4::Ptr{int_t}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat})::Cint
end

function psgsmv_AXglobal_abs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.psgsmv_AXglobal_abs(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{Cfloat}, arg4::Ptr{int_t}, arg5::Ptr{Cfloat}, arg6::Ptr{Cfloat})::Cint
end

function psgsmv_init(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.psgsmv_init(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{int_t}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{psgsmv_comm_t{Int64}})::Cvoid
end

function psgsmv(arg1, arg2, arg3, arg4, x, ax)
    @ccall libsuperlu_dist_Int64.psgsmv(arg1::int_t, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{psgsmv_comm_t{Int64}}, x::Ptr{Cfloat}, ax::Ptr{Cfloat})::Cvoid
end

function psgsmv_finalize(arg1)
    @ccall libsuperlu_dist_Int64.psgsmv_finalize(arg1::Ptr{psgsmv_comm_t{Int64}})::Cvoid
end

function floatMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.floatMalloc_dist(arg1::int_t)::Ptr{Cfloat}
end

function floatCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.floatCalloc_dist(arg1::int_t)::Ptr{Cfloat}
end

function sQuerySpace_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sQuerySpace_dist(arg1::int_t, arg2::Ptr{sLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperLUStat_t{Int64}}, arg5::Ptr{superlu_dist_mem_usage_t})::int_t
end

function sClone_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sClone_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function sCopy_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sCopy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function sZero_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.sZero_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function sScaleAddId_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sScaleAddId_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cfloat)::Cvoid
end

function sScaleAdd_CompRowLoc_Matrix_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.sScaleAdd_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Cfloat)::Cvoid
end

function sZeroLblocks(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.sZeroLblocks(arg1::Cint, arg2::Cint, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{sLUstruct_t{Int64}})::Cvoid
end

function sZeroUblocks(iam, n, arg3, arg4)
    @ccall libsuperlu_dist_Int64.sZeroUblocks(iam::Cint, n::Cint, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{sLUstruct_t{Int64}})::Cvoid
end

function sfill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.sfill_dist(arg1::Ptr{Cfloat}, arg2::int_t, arg3::Cfloat)::Cvoid
end

function sinf_norm_error_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sinf_norm_error_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Cfloat}, arg4::int_t, arg5::Ptr{Cfloat}, arg6::int_t, arg7::Ptr{gridinfo_t{Int64}})::Cvoid
end

function psinf_norm_error(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.psinf_norm_error(arg1::Cint, arg2::int_t, arg3::int_t, arg4::Ptr{Cfloat}, arg5::int_t, arg6::Ptr{Cfloat}, arg7::int_t, arg8::MPI_Comm)::Cvoid
end

function sreadhb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sreadhb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function sreadtriple_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sreadtriple_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function sreadtriple_noheader(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sreadtriple_noheader(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function sreadrb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sreadrb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function sreadMM_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sreadMM_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function sread_binary(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sread_binary(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{Cfloat}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cint
end

function sdist_psymbtonum(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sdist_psymbtonum(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{sScalePermstruct_t{Int64}}, arg5::Ptr{Pslu_freeable_t}, arg6::Ptr{sLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::Cfloat
end

function psGetDiagU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.psGetDiagU(arg1::int_t, arg2::Ptr{sLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Cfloat})::Cvoid
end

function s_c2cpp_GetHWPM(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.s_c2cpp_GetHWPM(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{sScalePermstruct_t{Int64}})::Cint
end

function sPrintLblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sPrintLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t{Int64}})::Cvoid
end

function sPrintUblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sPrintUblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t{Int64}})::Cvoid
end

function sPrint_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.sPrint_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function sPrint_Dense_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.sPrint_Dense_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function sPrint_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.sPrint_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cint
end

function file_sPrint_CompRowLoc_Matrix_dist(fp, A)
    @ccall libsuperlu_dist_Int64.file_sPrint_CompRowLoc_Matrix_dist(fp::Ptr{Libc.FILE}, A::Ptr{SuperMatrix{Int64}})::Cint
end

function Printfloat5(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.Printfloat5(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{Cfloat})::Cvoid
end

function file_Printfloat5(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.file_Printfloat5(arg1::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{Cfloat})::Cint
end

function sGenCOOLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.sGenCOOLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t{Int64}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{Cfloat}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function sGenCSCLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.sGenCSCLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t{Int64}}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function sGenCSRLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.sGenCSRLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{sLocalLU_t{Int64}}, arg6::Ptr{Ptr{Cfloat}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function superlu_sgemm(transa, transb, m, n, k, alpha, a, lda, b, ldb, beta, c, ldc)
    @ccall libsuperlu_dist_Int64.superlu_sgemm(transa::Ptr{Cchar}, transb::Ptr{Cchar}, m::Cint, n::Cint, k::Cint, alpha::Cfloat, a::Ptr{Cfloat}, lda::Cint, b::Ptr{Cfloat}, ldb::Cint, beta::Cfloat, c::Ptr{Cfloat}, ldc::Cint)::Cint
end

function superlu_strsm(sideRL, uplo, transa, diag, m, n, alpha, a, lda, b, ldb)
    @ccall libsuperlu_dist_Int64.superlu_strsm(sideRL::Ptr{Cchar}, uplo::Ptr{Cchar}, transa::Ptr{Cchar}, diag::Ptr{Cchar}, m::Cint, n::Cint, alpha::Cfloat, a::Ptr{Cfloat}, lda::Cint, b::Ptr{Cfloat}, ldb::Cint)::Cint
end

function superlu_sger(m, n, alpha, x, incx, y, incy, a, lda)
    @ccall libsuperlu_dist_Int64.superlu_sger(m::Cint, n::Cint, alpha::Cfloat, x::Ptr{Cfloat}, incx::Cint, y::Ptr{Cfloat}, incy::Cint, a::Ptr{Cfloat}, lda::Cint)::Cint
end

function superlu_sscal(n, alpha, x, incx)
    @ccall libsuperlu_dist_Int64.superlu_sscal(n::Cint, alpha::Cfloat, x::Ptr{Cfloat}, incx::Cint)::Cint
end

function superlu_saxpy(n, alpha, x, incx, y, incy)
    @ccall libsuperlu_dist_Int64.superlu_saxpy(n::Cint, alpha::Cfloat, x::Ptr{Cfloat}, incx::Cint, y::Ptr{Cfloat}, incy::Cint)::Cint
end

function superlu_sgemv(trans, m, n, alpha, a, lda, x, incx, beta, y, incy)
    @ccall libsuperlu_dist_Int64.superlu_sgemv(trans::Ptr{Cchar}, m::Cint, n::Cint, alpha::Cfloat, a::Ptr{Cfloat}, lda::Cint, x::Ptr{Cfloat}, incx::Cint, beta::Cfloat, y::Ptr{Cfloat}, incy::Cint)::Cint
end

function superlu_strsv(uplo, trans, diag, n, a, lda, x, incx)
    @ccall libsuperlu_dist_Int64.superlu_strsv(uplo::Ptr{Cchar}, trans::Ptr{Cchar}, diag::Ptr{Cchar}, n::Cint, a::Ptr{Cfloat}, lda::Cint, x::Ptr{Cfloat}, incx::Cint)::Cint
end

function screate_matrix3d(A, nrhs, rhs, ldb, x, ldx, fp, grid3d)
    @ccall libsuperlu_dist_Int64.screate_matrix3d(A::Ptr{SuperMatrix{Int64}}, nrhs::Cint, rhs::Ptr{Ptr{Cfloat}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cfloat}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function screate_matrix_postfix3d(A, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int64.screate_matrix_postfix3d(A::Ptr{SuperMatrix{Int64}}, nrhs::Cint, rhs::Ptr{Ptr{Cfloat}}, ldb::Ptr{Cint}, x::Ptr{Ptr{Cfloat}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function sGatherNRformat_loc3d(Fact, A, B, ldb, nrhs, grid3d, arg7)
    @ccall libsuperlu_dist_Int64.sGatherNRformat_loc3d(Fact::fact_t, A::Ptr{NRformat_loc{Int64}}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t{Int64}}, arg7::Ptr{Ptr{NRformat_loc3d{Int64}}})::Cvoid
end

function sScatter_B3d(A3d, grid3d)
    @ccall libsuperlu_dist_Int64.sScatter_B3d(A3d::Ptr{NRformat_loc3d{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function psgssvx3d(arg1, arg2, arg3, B, ldb, nrhs, arg7, arg8, arg9, berr, arg11, info)
    @ccall libsuperlu_dist_Int64.psgssvx3d(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{sScalePermstruct_t{Int64}}, B::Ptr{Cfloat}, ldb::Cint, nrhs::Cint, arg7::Ptr{gridinfo3d_t{Int64}}, arg8::Ptr{sLUstruct_t{Int64}}, arg9::Ptr{sSOLVEstruct_t{Int64}}, berr::Ptr{Cfloat}, arg11::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint})::Cvoid
end

function psgstrf3d(arg1, m, n, anorm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.psgstrf3d(arg1::Ptr{superlu_dist_options_t}, m::Cint, n::Cint, anorm::Cfloat, arg5::Ptr{strf3Dpartition_t{Int64}}, arg6::Ptr{SCT_t}, arg7::Ptr{sLUstruct_t{Int64}}, arg8::Ptr{gridinfo3d_t{Int64}}, arg9::Ptr{SuperLUStat_t{Int64}}, arg10::Ptr{Cint})::int_t
end

function sInit_HyP(HyP, Llu, mcb, mrb)
    @ccall libsuperlu_dist_Int64.sInit_HyP(HyP::Ptr{HyP_t}, Llu::Ptr{sLocalLU_t{Int64}}, mcb::int_t, mrb::int_t)::Cvoid
end

function sblock_gemm_scatter(lb, j, Ublock_info, Remain_info, L_mat, ldl, U_mat, ldu, bigV, knsupc, klst, lsub, usub, ldt, thread_id, indirect, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, Ufstnz_br_ptr, Unzval_br_ptr, xsup, arg23, arg24)
    @ccall libsuperlu_dist_Int64.sblock_gemm_scatter(lb::int_t, j::int_t, Ublock_info::Ptr{Ublock_info_t}, Remain_info::Ptr{Remain_info_t}, L_mat::Ptr{Cfloat}, ldl::Cint, U_mat::Ptr{Cfloat}, ldu::Cint, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, thread_id::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{Cfloat}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{Cfloat}}, xsup::Ptr{int_t}, arg23::Ptr{gridinfo_t{Int64}}, arg24::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function sblock_gemm_scatterTopLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.sblock_gemm_scatterTopLeft(lb::int_t, j::int_t, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{sLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function sblock_gemm_scatterTopRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.sblock_gemm_scatterTopRight(lb::int_t, j::int_t, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{sLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function sblock_gemm_scatterBottomLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.sblock_gemm_scatterBottomLeft(lb::int_t, j::int_t, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{sLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function sblock_gemm_scatterBottomRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.sblock_gemm_scatterBottomRight(lb::int_t, j::int_t, bigV::Ptr{Cfloat}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{sLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function sgather_u(num_u_blks, Ublock_info, usub, uval, bigU, ldu, xsup, klst)
    @ccall libsuperlu_dist_Int64.sgather_u(num_u_blks::int_t, Ublock_info::Ptr{Ublock_info_t}, usub::Ptr{int_t}, uval::Ptr{Cfloat}, bigU::Ptr{Cfloat}, ldu::int_t, xsup::Ptr{int_t}, klst::int_t)::Cvoid
end

function sgather_l(num_LBlk, knsupc, L_info, lval, LD_lval, L_buff)
    @ccall libsuperlu_dist_Int64.sgather_l(num_LBlk::int_t, knsupc::int_t, L_info::Ptr{Remain_info_t}, lval::Ptr{Cfloat}, LD_lval::int_t, L_buff::Ptr{Cfloat})::Cvoid
end

function sRgather_L(k, lsub, lusup, arg4, arg5, arg6, arg7, myIperm, iperm_c_supno)
    @ccall libsuperlu_dist_Int64.sRgather_L(k::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cfloat}, arg4::Ptr{gEtreeInfo_t{Int64}}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t})::Cvoid
end

function sRgather_U(k, jj0, usub, uval, bigU, arg6, arg7, arg8, arg9, myIperm, iperm_c_supno, perm_u)
    @ccall libsuperlu_dist_Int64.sRgather_U(k::int_t, jj0::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, bigU::Ptr{Cfloat}, arg6::Ptr{gEtreeInfo_t{Int64}}, arg7::Ptr{Glu_persist_t}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, perm_u::Ptr{int_t})::Cvoid
end

function sinitTrf3Dpartition(nsupers, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.sinitTrf3Dpartition(nsupers::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Ptr{strf3Dpartition_t{Int64}}
end

function sDestroy_trf3Dpartition(trf3Dpartition, grid3d)
    @ccall libsuperlu_dist_Int64.sDestroy_trf3Dpartition(trf3Dpartition::Ptr{strf3Dpartition_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function s3D_printMemUse(trf3Dpartition, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.s3D_printMemUse(trf3Dpartition::Ptr{strf3Dpartition_t{Int64}}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function sinit3DLUstructForest(myTreeIdxs, myZeroTrIdxs, sForests, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.sinit3DLUstructForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t{Int64}}}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function sgatherAllFactoredLUFr(myZeroTrIdxs, sForests, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.sgatherAllFactoredLUFr(myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t{Int64}}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function sLpanelUpdate(off0, nsupc, ublk_ptr, ld_ujrow, lusup, nsupr, arg7)
    @ccall libsuperlu_dist_Int64.sLpanelUpdate(off0::int_t, nsupc::int_t, ublk_ptr::Ptr{Cfloat}, ld_ujrow::int_t, lusup::Ptr{Cfloat}, nsupr::int_t, arg7::Ptr{SCT_t})::int_t
end

function Local_Sgstrf2(options, k, thresh, BlockUFactor, arg5, arg6, arg7, arg8, info, arg10)
    @ccall libsuperlu_dist_Int64.Local_Sgstrf2(options::Ptr{superlu_dist_options_t}, k::int_t, thresh::Cdouble, BlockUFactor::Ptr{Cfloat}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{sLocalLU_t{Int64}}, arg8::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint}, arg10::Ptr{SCT_t})::Cvoid
end

function sTrs2_GatherU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int64.sTrs2_GatherU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, tempv::Ptr{Cfloat})::int_t
end

function sTrs2_ScatterU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int64.sTrs2_ScatterU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, tempv::Ptr{Cfloat})::int_t
end

function sTrs2_GatherTrsmScatter(klst, iukp, rukp, usub, uval, tempv, knsupc, nsupr, lusup, Glu_persist)
    @ccall libsuperlu_dist_Int64.sTrs2_GatherTrsmScatter(klst::int_t, iukp::int_t, rukp::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, tempv::Ptr{Cfloat}, knsupc::int_t, nsupr::Cint, lusup::Ptr{Cfloat}, Glu_persist::Ptr{Glu_persist_t})::int_t
end

function psgstrs2(m, k0, k, Glu_persist, grid, Llu, stat)
    @ccall libsuperlu_dist_Int64.psgstrs2(m::int_t, k0::int_t, k::int_t, Glu_persist::Ptr{Glu_persist_t}, grid::Ptr{gridinfo_t{Int64}}, Llu::Ptr{sLocalLU_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function psgstrf2(arg1, nsupers, k0, k, thresh, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.psgstrf2(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, k0::int_t, k::int_t, thresh::Cdouble, arg6::Ptr{Glu_persist_t}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{sLocalLU_t{Int64}}, arg9::Ptr{MPI_Request}, arg10::Cint, arg11::Ptr{SuperLUStat_t{Int64}}, arg12::Ptr{Cint})::Cvoid
end

function sAllocLlu_3d(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.sAllocLlu_3d(nsupers::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function sp3dScatter(n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.sp3dScatter(n::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function sscatter3dLPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.sscatter3dLPanels(nsupers::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function sscatter3dUPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.sscatter3dUPanels(nsupers::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function scollect3dLpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.scollect3dLpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function scollect3dUpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.scollect3dUpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function sp3dCollect(layer, n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.sp3dCollect(layer::int_t, n::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function szeroSetLU(nnodes, nodeList, arg3, arg4)
    @ccall libsuperlu_dist_Int64.szeroSetLU(nnodes::int_t, nodeList::Ptr{int_t}, arg3::Ptr{sLUstruct_t{Int64}}, arg4::Ptr{gridinfo3d_t{Int64}})::int_t
end

function sAllocGlu_3d(n, nsupers, arg3)
    @ccall libsuperlu_dist_Int64.sAllocGlu_3d(n::int_t, nsupers::int_t, arg3::Ptr{sLUstruct_t{Int64}})::Cint
end

function sDeAllocLlu_3d(n, arg2, arg3)
    @ccall libsuperlu_dist_Int64.sDeAllocLlu_3d(n::int_t, arg2::Ptr{sLUstruct_t{Int64}}, arg3::Ptr{gridinfo3d_t{Int64}})::Cint
end

function sDeAllocGlu_3d(arg1)
    @ccall libsuperlu_dist_Int64.sDeAllocGlu_3d(arg1::Ptr{sLUstruct_t{Int64}})::Cint
end

function sreduceAncestors3d(sender, receiver, nnodes, nodeList, Lval_buf, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.sreduceAncestors3d(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, Uval_buf::Ptr{Cfloat}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function sreduceAllAncestors3d(ilvl, myNodeCount, treePerm, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.sreduceAllAncestors3d(ilvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}}, LUvsb::Ptr{sLUValSubBuf_t{Int64}}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::Cint
end

function sgatherFactoredLU(sender, receiver, nnodes, nodeList, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.sgatherFactoredLU(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, LUvsb::Ptr{sLUValSubBuf_t{Int64}}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function sgatherAllFactoredLU(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.sgatherAllFactoredLU(trf3Dpartition::Ptr{strf3Dpartition_t{Int64}}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function sinit3DLUstruct(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.sinit3DLUstruct(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function szSendLPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.szSendLPanel(k::int_t, receiver::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function szRecvLPanel(k, sender, alpha, beta, Lval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.szRecvLPanel(k::int_t, sender::int_t, alpha::Cfloat, beta::Cfloat, Lval_buf::Ptr{Cfloat}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function szSendUPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.szSendUPanel(k::int_t, receiver::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function szRecvUPanel(k, sender, alpha, beta, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.szRecvUPanel(k::int_t, sender::int_t, alpha::Cfloat, beta::Cfloat, Uval_buf::Ptr{Cfloat}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function sIBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, arg7, ToSendR, xsup, arg10)
    @ccall libsuperlu_dist_Int64.sIBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cfloat}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg10::Cint)::int_t
end

function sBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, ToSendR, xsup, arg9, arg10)
    @ccall libsuperlu_dist_Int64.sBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{Cfloat}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg9::Ptr{SCT_t}, arg10::Cint)::int_t
end

function sIBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, arg7, ToSendD, arg9)
    @ccall libsuperlu_dist_Int64.sIBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendD::Ptr{Cint}, arg9::Cint)::int_t
end

function sBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, ToSendD, arg8, arg9)
    @ccall libsuperlu_dist_Int64.sBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{Cfloat}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, ToSendD::Ptr{Cint}, arg8::Ptr{SCT_t}, arg9::Cint)::int_t
end

function sIrecv_LPanel(k, k0, Lsub_buf, Lval_buf, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sIrecv_LPanel(k::int_t, k0::int_t, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{MPI_Request}, arg7::Ptr{sLocalLU_t{Int64}}, arg8::Cint)::int_t
end

function sIrecv_UPanel(k, k0, Usub_buf, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sIrecv_UPanel(k::int_t, k0::int_t, Usub_buf::Ptr{int_t}, arg4::Ptr{Cfloat}, arg5::Ptr{sLocalLU_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{MPI_Request}, arg8::Cint)::int_t
end

function sWait_URecv(arg1, msgcnt, arg3)
    @ccall libsuperlu_dist_Int64.sWait_URecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, arg3::Ptr{SCT_t})::int_t
end

function sWait_LRecv(arg1, msgcnt, msgcntsU, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sWait_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, msgcntsU::Ptr{Cint}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{SCT_t})::int_t
end

function sISend_UDiagBlock(k0, ublk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.sISend_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Cint)::int_t
end

function sRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, src::int_t, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{SCT_t}, arg7::Cint)::int_t
end

function sPackLBlock(k, Dest, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sPackLBlock(k::int_t, Dest::Ptr{Cfloat}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{sLocalLU_t{Int64}})::int_t
end

function sISend_LDiagBlock(k0, lblk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.sISend_LDiagBlock(k0::int_t, lblk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Cint)::int_t
end

function sIRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sIRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function sIRecv_LDiagBlock(k0, L_blk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sIRecv_LDiagBlock(k0::int_t, L_blk_ptr::Ptr{Cfloat}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function sUDiagBlockRecvWait(k, IrecvPlcd_D, factored_L, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sUDiagBlockRecvWait(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{sLUstruct_t{Int64}}, arg7::Ptr{SCT_t})::int_t
end

function sIBcast_UDiagBlock(k, ublk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sIBcast_UDiagBlock(k::int_t, ublk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}})::int_t
end

function sIBcast_LDiagBlock(k, lblk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sIBcast_LDiagBlock(k::int_t, lblk_ptr::Ptr{Cfloat}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}})::int_t
end

function sDiagFactIBCast(k, k0, BlockUFactor, BlockLFactor, IrecvPlcd_D, arg6, arg7, arg8, arg9, arg10, arg11, thresh, LUstruct, arg14, info, arg16, tag_ub)
    @ccall libsuperlu_dist_Int64.sDiagFactIBCast(k::int_t, k0::int_t, BlockUFactor::Ptr{Cfloat}, BlockLFactor::Ptr{Cfloat}, IrecvPlcd_D::Ptr{int_t}, arg6::Ptr{MPI_Request}, arg7::Ptr{MPI_Request}, arg8::Ptr{MPI_Request}, arg9::Ptr{MPI_Request}, arg10::Ptr{gridinfo_t{Int64}}, arg11::Ptr{superlu_dist_options_t}, thresh::Cdouble, LUstruct::Ptr{sLUstruct_t{Int64}}, arg14::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint}, arg16::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function sUPanelTrSolve(k, BlockLFactor, bigV, ldt, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.sUPanelTrSolve(k::int_t, BlockLFactor::Ptr{Cfloat}, bigV::Ptr{Cfloat}, ldt::int_t, arg5::Ptr{Ublock_info_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{sLUstruct_t{Int64}}, arg8::Ptr{SuperLUStat_t{Int64}}, arg9::Ptr{SCT_t})::int_t
end

function sLPanelUpdate(k, IrecvPlcd_D, factored_L, arg4, BlockUFactor, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sLPanelUpdate(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, BlockUFactor::Ptr{Cfloat}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{sLUstruct_t{Int64}}, arg8::Ptr{SCT_t})::int_t
end

function sUPanelUpdate(k, factored_U, arg3, BlockLFactor, bigV, ldt, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.sUPanelUpdate(k::int_t, factored_U::Ptr{int_t}, arg3::Ptr{MPI_Request}, BlockLFactor::Ptr{Cfloat}, bigV::Ptr{Cfloat}, ldt::int_t, arg7::Ptr{Ublock_info_t}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{sLUstruct_t{Int64}}, arg10::Ptr{SuperLUStat_t{Int64}}, arg11::Ptr{SCT_t})::int_t
end

function sIBcastRecvLPanel(k, k0, msgcnt, arg4, arg5, Lsub_buf, Lval_buf, factored, arg9, arg10, arg11, tag_ub)
    @ccall libsuperlu_dist_Int64.sIBcastRecvLPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, factored::Ptr{int_t}, arg9::Ptr{gridinfo_t{Int64}}, arg10::Ptr{sLUstruct_t{Int64}}, arg11::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function sIBcastRecvUPanel(k, k0, msgcnt, arg4, arg5, Usub_buf, Uval_buf, arg8, arg9, arg10, tag_ub)
    @ccall libsuperlu_dist_Int64.sIBcastRecvUPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{Cfloat}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{sLUstruct_t{Int64}}, arg10::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function sWaitL(k, msgcnt, msgcntU, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sWaitL(k::int_t, msgcnt::Ptr{Cint}, msgcntU::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{sLUstruct_t{Int64}}, arg8::Ptr{SCT_t})::int_t
end

function sWaitU(k, msgcnt, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sWaitU(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{MPI_Request}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{sLUstruct_t{Int64}}, arg7::Ptr{SCT_t})::int_t
end

function sLPanelTrSolve(k, factored_L, BlockUFactor, arg4, arg5)
    @ccall libsuperlu_dist_Int64.sLPanelTrSolve(k::int_t, factored_L::Ptr{int_t}, BlockUFactor::Ptr{Cfloat}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{sLUstruct_t{Int64}})::int_t
end

function sSchurComplementSetup(k, msgcnt, arg3, arg4, arg5, arg6, arg7, arg8, arg9, bigU, Lsub_buf, Lval_buf, Usub_buf, Uval_buf, arg15, arg16)
    @ccall libsuperlu_dist_Int64.sSchurComplementSetup(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{Ublock_info_t}, arg4::Ptr{Remain_info_t}, arg5::Ptr{uPanelInfo_t{Int64}}, arg6::Ptr{lPanelInfo_t{Int64}}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, bigU::Ptr{Cfloat}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{Cfloat}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{Cfloat}, arg15::Ptr{gridinfo_t{Int64}}, arg16::Ptr{sLUstruct_t{Int64}})::int_t
end

function sSchurComplementSetupGPU(k, msgs, arg3, arg4, arg5, arg6, arg7, arg8, arg9, LUvsb, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.sSchurComplementSetupGPU(k::int_t, msgs::Ptr{msgs_t}, arg3::Ptr{packLUInfo_t{Int64}}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{gEtreeInfo_t{Int64}}, arg8::Ptr{factNodelists_t{Int64}}, arg9::Ptr{sscuBufs_t}, LUvsb::Ptr{sLUValSubBuf_t{Int64}}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{sLUstruct_t{Int64}}, arg13::Ptr{HyP_t})::int_t
end

function sgetBigV(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sgetBigV(arg1::int_t, arg2::int_t)::Ptr{Cfloat}
end

function sgetBigU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.sgetBigU(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{sLUstruct_t{Int64}})::Ptr{Cfloat}
end

function sLluBufInit(arg1, arg2)
    @ccall libsuperlu_dist_Int64.sLluBufInit(arg1::Ptr{sLUValSubBuf_t{Int64}}, arg2::Ptr{sLUstruct_t{Int64}})::int_t
end

function sinitScuBufs(arg1, ldt, num_threads, nsupers, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sinitScuBufs(arg1::Ptr{superlu_dist_options_t}, ldt::int_t, num_threads::int_t, nsupers::int_t, arg5::Ptr{sscuBufs_t}, arg6::Ptr{sLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::int_t
end

function sfreeScuBufs(scuBufs)
    @ccall libsuperlu_dist_Int64.sfreeScuBufs(scuBufs::Ptr{sscuBufs_t})::Cint
end

function ssparseTreeFactor(nnodes, perm_c_supno, treeTopoInfo, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, info)
    @ccall libsuperlu_dist_Int64.ssparseTreeFactor(nnodes::int_t, perm_c_supno::Ptr{int_t}, treeTopoInfo::Ptr{treeTopoInfo_t{Int64}}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{sscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgs::Ptr{msgs_t}, LUvsb::Ptr{sLUValSubBuf_t{Int64}}, dFBuf::Ptr{sdiagFactBufs_t}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, info::Ptr{Cint})::int_t
end

function sdenseTreeFactor(nnnodes, perm_c_supno, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int64.sdenseTreeFactor(nnnodes::int_t, perm_c_supno::Ptr{int_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{sscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgs::Ptr{msgs_t}, LUvsb::Ptr{sLUValSubBuf_t{Int64}}, dFBuf::Ptr{sdiagFactBufs_t}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function ssparseTreeFactor_ASYNC(sforest, comReqss, scuBufs, packLUInfo, msgss, LUvsbs, dFBufs, factStat, fNlists, gEtreeInfo, options, gIperm_c_supno, ldt, HyP, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int64.ssparseTreeFactor_ASYNC(sforest::Ptr{sForest_t{Int64}}, comReqss::Ptr{Ptr{commRequests_t}}, scuBufs::Ptr{sscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgss::Ptr{Ptr{msgs_t}}, LUvsbs::Ptr{Ptr{sLUValSubBuf_t{Int64}}}, dFBufs::Ptr{Ptr{sdiagFactBufs_t}}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, gEtreeInfo::Ptr{gEtreeInfo_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, HyP::Ptr{HyP_t}, LUstruct::Ptr{sLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function sLluBufInitArr(numLA, LUstruct)
    @ccall libsuperlu_dist_Int64.sLluBufInitArr(numLA::int_t, LUstruct::Ptr{sLUstruct_t{Int64}})::Ptr{Ptr{sLUValSubBuf_t{Int64}}}
end

function sLluBufFreeArr(numLA, LUvsbs)
    @ccall libsuperlu_dist_Int64.sLluBufFreeArr(numLA::int_t, LUvsbs::Ptr{Ptr{sLUValSubBuf_t{Int64}}})::Cint
end

function sinitDiagFactBufsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_dist_Int64.sinitDiagFactBufsArr(mxLeafNode::int_t, ldt::int_t, grid::Ptr{gridinfo_t{Int64}})::Ptr{Ptr{sdiagFactBufs_t}}
end

function sfreeDiagFactBufsArr(mxLeafNode, dFBufs)
    @ccall libsuperlu_dist_Int64.sfreeDiagFactBufsArr(mxLeafNode::int_t, dFBufs::Ptr{Ptr{sdiagFactBufs_t}})::Cint
end

function sinitDiagFactBufs(ldt, dFBuf)
    @ccall libsuperlu_dist_Int64.sinitDiagFactBufs(ldt::int_t, dFBuf::Ptr{sdiagFactBufs_t})::int_t
end

function slud_z_div(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.slud_z_div(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex})::Cvoid
end

function slud_z_abs(arg1)
    @ccall libsuperlu_dist_Int64.slud_z_abs(arg1::Ptr{doublecomplex})::Cdouble
end

function slud_z_abs1(arg1)
    @ccall libsuperlu_dist_Int64.slud_z_abs1(arg1::Ptr{doublecomplex})::Cdouble
end

function zCreate_CompCol_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.zCreate_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{doublecomplex}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Stype_t, arg9::Dtype_t, arg10::Mtype_t)::Cvoid
end

function zCreate_CompRowLoc_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.zCreate_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::int_t, arg6::int_t, arg7::Ptr{doublecomplex}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Stype_t, arg11::Dtype_t, arg12::Mtype_t)::Cvoid
end

function zCompRow_to_CompCol_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.zCompRow_to_CompCol_dist(arg1::int_t, arg2::int_t, arg3::int_t, arg4::Ptr{doublecomplex}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{Ptr{doublecomplex}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{Ptr{int_t}})::Cvoid
end

function pzCompRow_loc_to_CompCol_global(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.pzCompRow_loc_to_CompCol_global(arg1::int_t, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperMatrix{Int64}})::Cint
end

function zCopy_CompCol_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zCopy_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function zCreate_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zCreate_Dense_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::Ptr{doublecomplex}, arg5::int_t, arg6::Stype_t, arg7::Dtype_t, arg8::Mtype_t)::Cvoid
end

function zCreate_SuperNode_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.zCreate_SuperNode_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{doublecomplex}, arg6::Ptr{int_t}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, arg10::Ptr{int_t}, arg11::Stype_t, arg12::Dtype_t, arg13::Mtype_t)::Cvoid
end

function zCopy_Dense_Matrix_dist(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.zCopy_Dense_Matrix_dist(arg1::int_t, arg2::int_t, arg3::Ptr{doublecomplex}, arg4::int_t, arg5::Ptr{doublecomplex}, arg6::int_t)::Cvoid
end

function zallocateA_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zallocateA_dist(arg1::int_t, arg2::int_t, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Ptr{int_t}}, arg5::Ptr{Ptr{int_t}})::Cvoid
end

function zGenXtrue_dist(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.zGenXtrue_dist(arg1::int_t, arg2::int_t, arg3::Ptr{doublecomplex}, arg4::int_t)::Cvoid
end

function zFillRHS_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zFillRHS_dist(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{doublecomplex}, arg4::int_t, arg5::Ptr{SuperMatrix{Int64}}, arg6::Ptr{doublecomplex}, arg7::int_t)::Cvoid
end

function zcreate_matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zcreate_matrix(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function zcreate_matrix_rb(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zcreate_matrix_rb(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function zcreate_matrix_dat(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zcreate_matrix_dat(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{gridinfo_t{Int64}})::Cint
end

function zcreate_matrix_postfix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.zcreate_matrix_postfix(arg1::Ptr{SuperMatrix{Int64}}, arg2::Cint, arg3::Ptr{Ptr{doublecomplex}}, arg4::Ptr{Cint}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Cint}, arg7::Ptr{Libc.FILE}, arg8::Ptr{Cchar}, arg9::Ptr{gridinfo_t{Int64}})::Cint
end

function zScalePermstructInit(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.zScalePermstructInit(arg1::int_t, arg2::int_t, arg3::Ptr{zScalePermstruct_t})::Cvoid
end

function zScalePermstructFree(arg1)
    @ccall libsuperlu_dist_Int64.zScalePermstructFree(arg1::Ptr{zScalePermstruct_t})::Cvoid
end

function zgsequ_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zgsequ_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{int_t})::Cvoid
end

function zlangs_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zlangs_dist(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix{Int64}})::Cdouble
end

function zlaqgs_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zlaqgs_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pzgsequ(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.pzgsequ(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Ptr{Cdouble}, arg5::Ptr{Cdouble}, arg6::Ptr{Cdouble}, arg7::Ptr{int_t}, arg8::Ptr{gridinfo_t{Int64}})::Cvoid
end

function pzlangs(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.pzlangs(arg1::Ptr{Cchar}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}})::Cdouble
end

function pzlaqgs(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.pzlaqgs(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Cdouble}, arg3::Ptr{Cdouble}, arg4::Cdouble, arg5::Cdouble, arg6::Cdouble, arg7::Ptr{Cchar})::Cvoid
end

function pzPermute_Dense_Matrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.pzPermute_Dense_Matrix(arg1::int_t, arg2::int_t, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{doublecomplex}, arg6::Cint, arg7::Ptr{doublecomplex}, arg8::Cint, arg9::Cint, arg10::Ptr{gridinfo_t{Int64}})::Cint
end

function sp_ztrsv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.sp_ztrsv_dist(arg1::Ptr{Cchar}, arg2::Ptr{Cchar}, arg3::Ptr{Cchar}, arg4::Ptr{SuperMatrix{Int64}}, arg5::Ptr{SuperMatrix{Int64}}, arg6::Ptr{doublecomplex}, arg7::Ptr{Cint})::Cint
end

function sp_zgemv_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.sp_zgemv_dist(arg1::Ptr{Cchar}, arg2::doublecomplex, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::doublecomplex, arg7::Ptr{doublecomplex}, arg8::Cint)::Cint
end

function sp_zgemm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.sp_zgemm_dist(arg1::Ptr{Cchar}, arg2::Cint, arg3::doublecomplex, arg4::Ptr{SuperMatrix{Int64}}, arg5::Ptr{doublecomplex}, arg6::Cint, arg7::doublecomplex, arg8::Ptr{doublecomplex}, arg9::Cint)::Cint
end

function zdistribute(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.zdistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{Glu_freeable_t{Int64}}, arg5::Ptr{zLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}})::Cfloat
end

function pzgssvx_ABglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.pzgssvx_ABglobal(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{zScalePermstruct_t}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{zLUstruct_t{Int64}}, arg9::Ptr{Cdouble}, arg10::Ptr{SuperLUStat_t{Int64}}, arg11::Ptr{Cint})::Cvoid
end

function pzdistribute(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.pzdistribute(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{zScalePermstruct_t}, arg5::Ptr{Glu_freeable_t{Int64}}, arg6::Ptr{zLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::Cfloat
end

function pzgssvx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.pzgssvx(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{zScalePermstruct_t}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::Cint, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{zLUstruct_t{Int64}}, arg9::Ptr{zSOLVEstruct_t{Int64}}, arg10::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t{Int64}}, arg12::Ptr{Cint})::Cvoid
end

function pzCompute_Diag_Inv(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.pzCompute_Diag_Inv(arg1::int_t, arg2::Ptr{zLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperLUStat_t{Int64}}, arg5::Ptr{Cint})::Cvoid
end

function zSolveInit(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zSolveInit(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::int_t, arg6::Ptr{zLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{zSOLVEstruct_t{Int64}})::Cint
end

function zSolveFinalize(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zSolveFinalize(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{zSOLVEstruct_t{Int64}})::Cvoid
end

function zDestroy_A3d_gathered_on_2d(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zDestroy_A3d_gathered_on_2d(arg1::Ptr{zSOLVEstruct_t{Int64}}, arg2::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function pzgstrs_init(arg1, arg2, arg3, arg4, arg5, arg6, grid, arg8, arg9)
    @ccall libsuperlu_dist_Int64.pzgstrs_init(arg1::int_t, arg2::int_t, arg3::int_t, arg4::int_t, arg5::Ptr{int_t}, arg6::Ptr{int_t}, grid::Ptr{gridinfo_t{Int64}}, arg8::Ptr{Glu_persist_t}, arg9::Ptr{zSOLVEstruct_t{Int64}})::int_t
end

function zldperm_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.zldperm_dist(arg1::Cint, arg2::Cint, arg3::int_t, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{doublecomplex}, arg7::Ptr{int_t}, arg8::Ptr{Cdouble}, arg9::Ptr{Cdouble})::Cint
end

function zstatic_schedule(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.zstatic_schedule(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, arg4::Ptr{zLUstruct_t{Int64}}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{SuperLUStat_t{Int64}}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{Cint})::Cint
end

function zLUstructInit(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zLUstructInit(arg1::int_t, arg2::Ptr{zLUstruct_t{Int64}})::Cvoid
end

function zLUstructFree(arg1)
    @ccall libsuperlu_dist_Int64.zLUstructFree(arg1::Ptr{zLUstruct_t{Int64}})::Cvoid
end

function zDestroy_LU(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.zDestroy_LU(arg1::int_t, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{zLUstruct_t{Int64}})::Cvoid
end

function zDestroy_Tree(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.zDestroy_Tree(arg1::int_t, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{zLUstruct_t{Int64}})::Cvoid
end

function zscatter_l(ib, ljb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, usub, lsub, tempv, indirect_thread, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, grid)
    @ccall libsuperlu_dist_Int64.zscatter_l(ib::Cint, ljb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, usub::Ptr{int_t}, lsub::Ptr{int_t}, tempv::Ptr{doublecomplex}, indirect_thread::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{doublecomplex}}, grid::Ptr{gridinfo_t{Int64}})::Cvoid
end

function zscatter_u(ib, jb, nsupc, iukp, xsup, klst, nbrow, lptr, temp_nbrow, lsub, usub, tempv, Ufstnz_br_ptr, Unzval_br_ptr, grid)
    @ccall libsuperlu_dist_Int64.zscatter_u(ib::Cint, jb::Cint, nsupc::Cint, iukp::int_t, xsup::Ptr{int_t}, klst::Cint, nbrow::Cint, lptr::int_t, temp_nbrow::Cint, lsub::Ptr{int_t}, usub::Ptr{int_t}, tempv::Ptr{doublecomplex}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{doublecomplex}}, grid::Ptr{gridinfo_t{Int64}})::Cvoid
end

function pzgstrf(arg1, arg2, arg3, anorm, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.pzgstrf(arg1::Ptr{superlu_dist_options_t}, arg2::Cint, arg3::Cint, anorm::Cdouble, arg5::Ptr{zLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SuperLUStat_t{Int64}}, arg8::Ptr{Cint})::int_t
end

function pzgstrs_Bglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.pzgstrs_Bglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{zLUstruct_t{Int64}}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{doublecomplex}, arg6::int_t, arg7::Cint, arg8::Ptr{SuperLUStat_t{Int64}}, arg9::Ptr{Cint})::Cvoid
end

function pzgstrs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.pzgstrs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{zLUstruct_t{Int64}}, arg4::Ptr{zScalePermstruct_t}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{doublecomplex}, arg7::int_t, arg8::int_t, arg9::int_t, arg10::Cint, arg11::Ptr{zSOLVEstruct_t{Int64}}, arg12::Ptr{SuperLUStat_t{Int64}}, arg13::Ptr{Cint})::Cvoid
end

function pzgstrf2_trsm(options, k0, k, thresh, arg5, arg6, arg7, arg8, tag_ub, arg10, info)
    @ccall libsuperlu_dist_Int64.pzgstrf2_trsm(options::Ptr{superlu_dist_options_t}, k0::int_t, k::int_t, thresh::Cdouble, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{zLocalLU_t{Int64}}, arg8::Ptr{MPI_Request}, tag_ub::Cint, arg10::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint})::Cvoid
end

function pzgstrs2_omp(k0, k, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.pzgstrs2_omp(k0::int_t, k::int_t, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{zLocalLU_t{Int64}}, arg6::Ptr{Ublock_info_t}, arg7::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function pzReDistribute_B_to_X(B, m_loc, nrhs, ldb, fst_row, ilsum, x, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.pzReDistribute_B_to_X(B::Ptr{doublecomplex}, m_loc::int_t, nrhs::Cint, ldb::int_t, fst_row::int_t, ilsum::Ptr{int_t}, x::Ptr{doublecomplex}, arg8::Ptr{zScalePermstruct_t}, arg9::Ptr{Glu_persist_t}, arg10::Ptr{gridinfo_t{Int64}}, arg11::Ptr{zSOLVEstruct_t{Int64}})::int_t
end

function zlsum_fmod(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int64.zlsum_fmod(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::int_t, arg11::int_t, arg12::Ptr{int_t}, arg13::Ptr{gridinfo_t{Int64}}, arg14::Ptr{zLocalLU_t{Int64}}, arg15::Ptr{MPI_Request}, arg16::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function zlsum_bmod(arg1, arg2, arg3, arg4, arg5, bmod, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int64.zlsum_bmod(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Cint, arg5::int_t, bmod::Ptr{Cint}, arg7::Ptr{int_t}, arg8::Ptr{Ptr{Ucb_indptr_t}}, arg9::Ptr{Ptr{int_t}}, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{zLocalLU_t{Int64}}, arg13::Ptr{MPI_Request}, arg14::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function zlsum_fmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, fmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int64.zlsum_fmod_inv(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::int_t, fmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{gridinfo_t{Int64}}, arg10::Ptr{zLocalLU_t{Int64}}, arg11::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg12::Ptr{int_t}, arg13::Ptr{int_t}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function zlsum_fmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, arg7, fmod, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    @ccall libsuperlu_dist_Int64.zlsum_fmod_inv_master(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::Cint, arg7::int_t, fmod::Ptr{Cint}, arg9::int_t, arg10::Ptr{int_t}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{zLocalLU_t{Int64}}, arg13::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg14::int_t, arg15::int_t, arg16::int_t, arg17::int_t, arg18::Cint, arg19::Cint)::Cvoid
end

function zlsum_bmod_inv(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    @ccall libsuperlu_dist_Int64.zlsum_bmod_inv(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t{Int64}}, arg13::Ptr{zLocalLU_t{Int64}}, arg14::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg15::Ptr{int_t}, arg16::Ptr{int_t}, arg17::int_t, arg18::int_t, arg19::Cint, arg20::Cint)::Cvoid
end

function zlsum_bmod_inv_master(arg1, arg2, arg3, arg4, arg5, arg6, bmod, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    @ccall libsuperlu_dist_Int64.zlsum_bmod_inv_master(arg1::Ptr{doublecomplex}, arg2::Ptr{doublecomplex}, arg3::Ptr{doublecomplex}, arg4::Ptr{doublecomplex}, arg5::Cint, arg6::int_t, bmod::Ptr{Cint}, arg8::Ptr{int_t}, arg9::Ptr{Ptr{Ucb_indptr_t}}, arg10::Ptr{Ptr{int_t}}, arg11::Ptr{int_t}, arg12::Ptr{gridinfo_t{Int64}}, arg13::Ptr{zLocalLU_t{Int64}}, arg14::Ptr{Ptr{SuperLUStat_t{Int64}}}, arg15::int_t, arg16::int_t, arg17::Cint, arg18::Cint)::Cvoid
end

function zComputeLevelsets(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.zComputeLevelsets(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t{Int64}}, arg6::Ptr{int_t})::Cvoid
end

function pzgsrfs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    @ccall libsuperlu_dist_Int64.pzgsrfs(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Cdouble, arg5::Ptr{zLUstruct_t{Int64}}, arg6::Ptr{zScalePermstruct_t}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{doublecomplex}, arg9::int_t, arg10::Ptr{doublecomplex}, arg11::int_t, arg12::Cint, arg13::Ptr{zSOLVEstruct_t{Int64}}, arg14::Ptr{Cdouble}, arg15::Ptr{SuperLUStat_t{Int64}}, arg16::Ptr{Cint})::Cvoid
end

function pzgsrfs_ABXglobal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    @ccall libsuperlu_dist_Int64.pzgsrfs_ABXglobal(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Cdouble, arg5::Ptr{zLUstruct_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{doublecomplex}, arg8::int_t, arg9::Ptr{doublecomplex}, arg10::int_t, arg11::Cint, arg12::Ptr{Cdouble}, arg13::Ptr{SuperLUStat_t{Int64}}, arg14::Ptr{Cint})::Cvoid
end

function pzgsmv_AXglobal_setup(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.pzgsmv_AXglobal_setup(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{Glu_persist_t}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{int_t}}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{int_t})::Cint
end

function pzgsmv_AXglobal(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.pzgsmv_AXglobal(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{doublecomplex}, arg4::Ptr{int_t}, arg5::Ptr{doublecomplex}, arg6::Ptr{doublecomplex})::Cint
end

function pzgsmv_AXglobal_abs(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.pzgsmv_AXglobal_abs(arg1::int_t, arg2::Ptr{int_t}, arg3::Ptr{doublecomplex}, arg4::Ptr{int_t}, arg5::Ptr{doublecomplex}, arg6::Ptr{Cdouble})::Cint
end

function pzgsmv_init(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.pzgsmv_init(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{int_t}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{pzgsmv_comm_t})::Cvoid
end

function pzgsmv(arg1, arg2, arg3, arg4, x, ax)
    @ccall libsuperlu_dist_Int64.pzgsmv(arg1::int_t, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{pzgsmv_comm_t}, x::Ptr{doublecomplex}, ax::Ptr{doublecomplex})::Cvoid
end

function pzgsmv_finalize(arg1)
    @ccall libsuperlu_dist_Int64.pzgsmv_finalize(arg1::Ptr{pzgsmv_comm_t})::Cvoid
end

function doublecomplexMalloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.doublecomplexMalloc_dist(arg1::int_t)::Ptr{doublecomplex}
end

function doublecomplexCalloc_dist(arg1)
    @ccall libsuperlu_dist_Int64.doublecomplexCalloc_dist(arg1::int_t)::Ptr{doublecomplex}
end

function zQuerySpace_dist(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zQuerySpace_dist(arg1::int_t, arg2::Ptr{zLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{SuperLUStat_t{Int64}}, arg5::Ptr{superlu_dist_mem_usage_t})::int_t
end

function zClone_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zClone_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function zCopy_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zCopy_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}})::Cvoid
end

function zZero_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.zZero_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function zScaleAddId_CompRowLoc_Matrix_dist(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zScaleAddId_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::doublecomplex)::Cvoid
end

function zScaleAdd_CompRowLoc_Matrix_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.zScaleAdd_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{SuperMatrix{Int64}}, arg3::doublecomplex)::Cvoid
end

function zZeroLblocks(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.zZeroLblocks(arg1::Cint, arg2::Cint, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{zLUstruct_t{Int64}})::Cvoid
end

function zZeroUblocks(iam, n, arg3, arg4)
    @ccall libsuperlu_dist_Int64.zZeroUblocks(iam::Cint, n::Cint, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{zLUstruct_t{Int64}})::Cvoid
end

function zfill_dist(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.zfill_dist(arg1::Ptr{doublecomplex}, arg2::int_t, arg3::doublecomplex)::Cvoid
end

function zinf_norm_error_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zinf_norm_error_dist(arg1::int_t, arg2::int_t, arg3::Ptr{doublecomplex}, arg4::int_t, arg5::Ptr{doublecomplex}, arg6::int_t, arg7::Ptr{gridinfo_t{Int64}})::Cvoid
end

function pzinf_norm_error(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.pzinf_norm_error(arg1::Cint, arg2::int_t, arg3::int_t, arg4::Ptr{doublecomplex}, arg5::int_t, arg6::Ptr{doublecomplex}, arg7::int_t, arg8::MPI_Comm)::Cvoid
end

function zreadhb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zreadhb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function zreadtriple_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zreadtriple_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function zreadtriple_noheader(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zreadtriple_noheader(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function zreadrb_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zreadrb_dist(arg1::Cint, arg2::Ptr{Libc.FILE}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}})::Cvoid
end

function zreadMM_dist(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zreadMM_dist(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cvoid
end

function zread_binary(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zread_binary(arg1::Ptr{Libc.FILE}, arg2::Ptr{int_t}, arg3::Ptr{int_t}, arg4::Ptr{int_t}, arg5::Ptr{Ptr{doublecomplex}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}})::Cint
end

function zdist_psymbtonum(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zdist_psymbtonum(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{SuperMatrix{Int64}}, arg4::Ptr{zScalePermstruct_t}, arg5::Ptr{Pslu_freeable_t}, arg6::Ptr{zLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::Cfloat
end

function pzGetDiagU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.pzGetDiagU(arg1::int_t, arg2::Ptr{zLUstruct_t{Int64}}, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{doublecomplex})::Cvoid
end

function z_c2cpp_GetHWPM(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.z_c2cpp_GetHWPM(arg1::Ptr{SuperMatrix{Int64}}, arg2::Ptr{gridinfo_t{Int64}}, arg3::Ptr{zScalePermstruct_t})::Cint
end

function zPrintLblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zPrintLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t{Int64}})::Cvoid
end

function zPrintUblocks(arg1, arg2, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zPrintUblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t{Int64}})::Cvoid
end

function zPrint_CompCol_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.zPrint_CompCol_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function zPrint_Dense_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.zPrint_Dense_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cvoid
end

function zPrint_CompRowLoc_Matrix_dist(arg1)
    @ccall libsuperlu_dist_Int64.zPrint_CompRowLoc_Matrix_dist(arg1::Ptr{SuperMatrix{Int64}})::Cint
end

function file_zPrint_CompRowLoc_Matrix_dist(fp, A)
    @ccall libsuperlu_dist_Int64.file_zPrint_CompRowLoc_Matrix_dist(fp::Ptr{Libc.FILE}, A::Ptr{SuperMatrix{Int64}})::Cint
end

function PrintDoublecomplex(arg1, arg2, arg3)
    @ccall libsuperlu_dist_Int64.PrintDoublecomplex(arg1::Ptr{Cchar}, arg2::int_t, arg3::Ptr{doublecomplex})::Cvoid
end

function file_PrintDoublecomplex(fp, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.file_PrintDoublecomplex(fp::Ptr{Libc.FILE}, arg2::Ptr{Cchar}, arg3::int_t, arg4::Ptr{doublecomplex})::Cint
end

function zGenCOOLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.zGenCOOLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t{Int64}}, arg6::Ptr{Ptr{int_t}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{doublecomplex}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function zGenCSCLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.zGenCSCLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t{Int64}}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function zGenCSRLblocks(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.zGenCSRLblocks(arg1::Cint, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{Glu_persist_t}, arg5::Ptr{zLocalLU_t{Int64}}, arg6::Ptr{Ptr{doublecomplex}}, arg7::Ptr{Ptr{int_t}}, arg8::Ptr{Ptr{int_t}}, arg9::Ptr{int_t}, arg10::Ptr{int_t})::Cvoid
end

function superlu_zgemm(transa, transb, m, n, k, alpha, a, lda, b, ldb, beta, c, ldc)
    @ccall libsuperlu_dist_Int64.superlu_zgemm(transa::Ptr{Cchar}, transb::Ptr{Cchar}, m::Cint, n::Cint, k::Cint, alpha::doublecomplex, a::Ptr{doublecomplex}, lda::Cint, b::Ptr{doublecomplex}, ldb::Cint, beta::doublecomplex, c::Ptr{doublecomplex}, ldc::Cint)::Cint
end

function superlu_ztrsm(sideRL, uplo, transa, diag, m, n, alpha, a, lda, b, ldb)
    @ccall libsuperlu_dist_Int64.superlu_ztrsm(sideRL::Ptr{Cchar}, uplo::Ptr{Cchar}, transa::Ptr{Cchar}, diag::Ptr{Cchar}, m::Cint, n::Cint, alpha::doublecomplex, a::Ptr{doublecomplex}, lda::Cint, b::Ptr{doublecomplex}, ldb::Cint)::Cint
end

function superlu_zger(m, n, alpha, x, incx, y, incy, a, lda)
    @ccall libsuperlu_dist_Int64.superlu_zger(m::Cint, n::Cint, alpha::doublecomplex, x::Ptr{doublecomplex}, incx::Cint, y::Ptr{doublecomplex}, incy::Cint, a::Ptr{doublecomplex}, lda::Cint)::Cint
end

function superlu_zscal(n, alpha, x, incx)
    @ccall libsuperlu_dist_Int64.superlu_zscal(n::Cint, alpha::doublecomplex, x::Ptr{doublecomplex}, incx::Cint)::Cint
end

function superlu_zaxpy(n, alpha, x, incx, y, incy)
    @ccall libsuperlu_dist_Int64.superlu_zaxpy(n::Cint, alpha::doublecomplex, x::Ptr{doublecomplex}, incx::Cint, y::Ptr{doublecomplex}, incy::Cint)::Cint
end

function superlu_zgemv(trans, m, n, alpha, a, lda, x, incx, beta, y, incy)
    @ccall libsuperlu_dist_Int64.superlu_zgemv(trans::Ptr{Cchar}, m::Cint, n::Cint, alpha::doublecomplex, a::Ptr{doublecomplex}, lda::Cint, x::Ptr{doublecomplex}, incx::Cint, beta::doublecomplex, y::Ptr{doublecomplex}, incy::Cint)::Cint
end

function superlu_ztrsv(uplo, trans, diag, n, a, lda, x, incx)
    @ccall libsuperlu_dist_Int64.superlu_ztrsv(uplo::Ptr{Cchar}, trans::Ptr{Cchar}, diag::Ptr{Cchar}, n::Cint, a::Ptr{doublecomplex}, lda::Cint, x::Ptr{doublecomplex}, incx::Cint)::Cint
end

function zcreate_matrix3d(A, nrhs, rhs, ldb, x, ldx, fp, grid3d)
    @ccall libsuperlu_dist_Int64.zcreate_matrix3d(A::Ptr{SuperMatrix{Int64}}, nrhs::Cint, rhs::Ptr{Ptr{doublecomplex}}, ldb::Ptr{Cint}, x::Ptr{Ptr{doublecomplex}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function zcreate_matrix_postfix3d(A, nrhs, rhs, ldb, x, ldx, fp, postfix, grid3d)
    @ccall libsuperlu_dist_Int64.zcreate_matrix_postfix3d(A::Ptr{SuperMatrix{Int64}}, nrhs::Cint, rhs::Ptr{Ptr{doublecomplex}}, ldb::Ptr{Cint}, x::Ptr{Ptr{doublecomplex}}, ldx::Ptr{Cint}, fp::Ptr{Libc.FILE}, postfix::Ptr{Cchar}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function zGatherNRformat_loc3d(Fact, A, B, ldb, nrhs, grid3d, arg7)
    @ccall libsuperlu_dist_Int64.zGatherNRformat_loc3d(Fact::fact_t, A::Ptr{NRformat_loc{Int64}}, B::Ptr{doublecomplex}, ldb::Cint, nrhs::Cint, grid3d::Ptr{gridinfo3d_t{Int64}}, arg7::Ptr{Ptr{NRformat_loc3d{Int64}}})::Cvoid
end

function zScatter_B3d(A3d, grid3d)
    @ccall libsuperlu_dist_Int64.zScatter_B3d(A3d::Ptr{NRformat_loc3d{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cint
end

function pzgssvx3d(arg1, arg2, arg3, B, ldb, nrhs, arg7, arg8, arg9, berr, arg11, info)
    @ccall libsuperlu_dist_Int64.pzgssvx3d(arg1::Ptr{superlu_dist_options_t}, arg2::Ptr{SuperMatrix{Int64}}, arg3::Ptr{zScalePermstruct_t}, B::Ptr{doublecomplex}, ldb::Cint, nrhs::Cint, arg7::Ptr{gridinfo3d_t{Int64}}, arg8::Ptr{zLUstruct_t{Int64}}, arg9::Ptr{zSOLVEstruct_t{Int64}}, berr::Ptr{Cdouble}, arg11::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint})::Cvoid
end

function pzgstrf3d(arg1, m, n, anorm, arg5, arg6, arg7, arg8, arg9, arg10)
    @ccall libsuperlu_dist_Int64.pzgstrf3d(arg1::Ptr{superlu_dist_options_t}, m::Cint, n::Cint, anorm::Cdouble, arg5::Ptr{ztrf3Dpartition_t{Int64}}, arg6::Ptr{SCT_t}, arg7::Ptr{zLUstruct_t{Int64}}, arg8::Ptr{gridinfo3d_t{Int64}}, arg9::Ptr{SuperLUStat_t{Int64}}, arg10::Ptr{Cint})::int_t
end

function zInit_HyP(HyP, Llu, mcb, mrb)
    @ccall libsuperlu_dist_Int64.zInit_HyP(HyP::Ptr{HyP_t}, Llu::Ptr{zLocalLU_t{Int64}}, mcb::int_t, mrb::int_t)::Cvoid
end

function zblock_gemm_scatter(lb, j, Ublock_info, Remain_info, L_mat, ldl, U_mat, ldu, bigV, knsupc, klst, lsub, usub, ldt, thread_id, indirect, indirect2, Lrowind_bc_ptr, Lnzval_bc_ptr, Ufstnz_br_ptr, Unzval_br_ptr, xsup, arg23, arg24)
    @ccall libsuperlu_dist_Int64.zblock_gemm_scatter(lb::int_t, j::int_t, Ublock_info::Ptr{Ublock_info_t}, Remain_info::Ptr{Remain_info_t}, L_mat::Ptr{doublecomplex}, ldl::Cint, U_mat::Ptr{doublecomplex}, ldu::Cint, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, thread_id::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, Lrowind_bc_ptr::Ptr{Ptr{int_t}}, Lnzval_bc_ptr::Ptr{Ptr{doublecomplex}}, Ufstnz_br_ptr::Ptr{Ptr{int_t}}, Unzval_br_ptr::Ptr{Ptr{doublecomplex}}, xsup::Ptr{int_t}, arg23::Ptr{gridinfo_t{Int64}}, arg24::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function zblock_gemm_scatterTopLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.zblock_gemm_scatterTopLeft(lb::int_t, j::int_t, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{zLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function zblock_gemm_scatterTopRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.zblock_gemm_scatterTopRight(lb::int_t, j::int_t, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{zLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function zblock_gemm_scatterBottomLeft(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.zblock_gemm_scatterBottomLeft(lb::int_t, j::int_t, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{zLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function zblock_gemm_scatterBottomRight(lb, j, bigV, knsupc, klst, lsub, usub, ldt, indirect, indirect2, HyP, arg12, arg13, SCT, arg15)
    @ccall libsuperlu_dist_Int64.zblock_gemm_scatterBottomRight(lb::int_t, j::int_t, bigV::Ptr{doublecomplex}, knsupc::int_t, klst::int_t, lsub::Ptr{int_t}, usub::Ptr{int_t}, ldt::int_t, indirect::Ptr{Cint}, indirect2::Ptr{Cint}, HyP::Ptr{HyP_t}, arg12::Ptr{zLUstruct_t{Int64}}, arg13::Ptr{gridinfo_t{Int64}}, SCT::Ptr{SCT_t}, arg15::Ptr{SuperLUStat_t{Int64}})::int_t
end

function zgather_u(num_u_blks, Ublock_info, usub, uval, bigU, ldu, xsup, klst)
    @ccall libsuperlu_dist_Int64.zgather_u(num_u_blks::int_t, Ublock_info::Ptr{Ublock_info_t}, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, bigU::Ptr{doublecomplex}, ldu::int_t, xsup::Ptr{int_t}, klst::int_t)::Cvoid
end

function zgather_l(num_LBlk, knsupc, L_info, lval, LD_lval, L_buff)
    @ccall libsuperlu_dist_Int64.zgather_l(num_LBlk::int_t, knsupc::int_t, L_info::Ptr{Remain_info_t}, lval::Ptr{doublecomplex}, LD_lval::int_t, L_buff::Ptr{doublecomplex})::Cvoid
end

function zRgather_L(k, lsub, lusup, arg4, arg5, arg6, arg7, myIperm, iperm_c_supno)
    @ccall libsuperlu_dist_Int64.zRgather_L(k::int_t, lsub::Ptr{int_t}, lusup::Ptr{doublecomplex}, arg4::Ptr{gEtreeInfo_t{Int64}}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t})::Cvoid
end

function zRgather_U(k, jj0, usub, uval, bigU, arg6, arg7, arg8, arg9, myIperm, iperm_c_supno, perm_u)
    @ccall libsuperlu_dist_Int64.zRgather_U(k::int_t, jj0::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, bigU::Ptr{doublecomplex}, arg6::Ptr{gEtreeInfo_t{Int64}}, arg7::Ptr{Glu_persist_t}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{HyP_t}, myIperm::Ptr{int_t}, iperm_c_supno::Ptr{int_t}, perm_u::Ptr{int_t})::Cvoid
end

function zinitTrf3Dpartition(nsupers, options, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zinitTrf3Dpartition(nsupers::int_t, options::Ptr{superlu_dist_options_t}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Ptr{ztrf3Dpartition_t{Int64}}
end

function zDestroy_trf3Dpartition(trf3Dpartition, grid3d)
    @ccall libsuperlu_dist_Int64.zDestroy_trf3Dpartition(trf3Dpartition::Ptr{ztrf3Dpartition_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function z3D_printMemUse(trf3Dpartition, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.z3D_printMemUse(trf3Dpartition::Ptr{ztrf3Dpartition_t{Int64}}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function zinit3DLUstructForest(myTreeIdxs, myZeroTrIdxs, sForests, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zinit3DLUstructForest(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{Ptr{sForest_t{Int64}}}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::Cvoid
end

function zgatherAllFactoredLUFr(myZeroTrIdxs, sForests, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zgatherAllFactoredLUFr(myZeroTrIdxs::Ptr{int_t}, sForests::Ptr{sForest_t{Int64}}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function zLpanelUpdate(off0, nsupc, ublk_ptr, ld_ujrow, lusup, nsupr, arg7)
    @ccall libsuperlu_dist_Int64.zLpanelUpdate(off0::int_t, nsupc::int_t, ublk_ptr::Ptr{doublecomplex}, ld_ujrow::int_t, lusup::Ptr{doublecomplex}, nsupr::int_t, arg7::Ptr{SCT_t})::int_t
end

function Local_Zgstrf2(options, k, thresh, BlockUFactor, arg5, arg6, arg7, arg8, info, arg10)
    @ccall libsuperlu_dist_Int64.Local_Zgstrf2(options::Ptr{superlu_dist_options_t}, k::int_t, thresh::Cdouble, BlockUFactor::Ptr{doublecomplex}, arg5::Ptr{Glu_persist_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{zLocalLU_t{Int64}}, arg8::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint}, arg10::Ptr{SCT_t})::Cvoid
end

function zTrs2_GatherU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int64.zTrs2_GatherU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, tempv::Ptr{doublecomplex})::int_t
end

function zTrs2_ScatterU(iukp, rukp, klst, nsupc, ldu, usub, uval, tempv)
    @ccall libsuperlu_dist_Int64.zTrs2_ScatterU(iukp::int_t, rukp::int_t, klst::int_t, nsupc::int_t, ldu::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, tempv::Ptr{doublecomplex})::int_t
end

function zTrs2_GatherTrsmScatter(klst, iukp, rukp, usub, uval, tempv, knsupc, nsupr, lusup, Glu_persist)
    @ccall libsuperlu_dist_Int64.zTrs2_GatherTrsmScatter(klst::int_t, iukp::int_t, rukp::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, tempv::Ptr{doublecomplex}, knsupc::int_t, nsupr::Cint, lusup::Ptr{doublecomplex}, Glu_persist::Ptr{Glu_persist_t})::int_t
end

function pzgstrs2(m, k0, k, Glu_persist, grid, Llu, stat)
    @ccall libsuperlu_dist_Int64.pzgstrs2(m::int_t, k0::int_t, k::int_t, Glu_persist::Ptr{Glu_persist_t}, grid::Ptr{gridinfo_t{Int64}}, Llu::Ptr{zLocalLU_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}})::Cvoid
end

function pzgstrf2(arg1, nsupers, k0, k, thresh, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    @ccall libsuperlu_dist_Int64.pzgstrf2(arg1::Ptr{superlu_dist_options_t}, nsupers::int_t, k0::int_t, k::int_t, thresh::Cdouble, arg6::Ptr{Glu_persist_t}, arg7::Ptr{gridinfo_t{Int64}}, arg8::Ptr{zLocalLU_t{Int64}}, arg9::Ptr{MPI_Request}, arg10::Cint, arg11::Ptr{SuperLUStat_t{Int64}}, arg12::Ptr{Cint})::Cvoid
end

function zAllocLlu_3d(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zAllocLlu_3d(nsupers::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zp3dScatter(n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zp3dScatter(n::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zscatter3dLPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zscatter3dLPanels(nsupers::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zscatter3dUPanels(nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zscatter3dUPanels(nsupers::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zcollect3dLpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zcollect3dLpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zcollect3dUpanels(layer, nsupers, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zcollect3dUpanels(layer::int_t, nsupers::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zp3dCollect(layer, n, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zp3dCollect(layer::int_t, n::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zzeroSetLU(nnodes, nodeList, arg3, arg4)
    @ccall libsuperlu_dist_Int64.zzeroSetLU(nnodes::int_t, nodeList::Ptr{int_t}, arg3::Ptr{zLUstruct_t{Int64}}, arg4::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zAllocGlu_3d(n, nsupers, arg3)
    @ccall libsuperlu_dist_Int64.zAllocGlu_3d(n::int_t, nsupers::int_t, arg3::Ptr{zLUstruct_t{Int64}})::Cint
end

function zDeAllocLlu_3d(n, arg2, arg3)
    @ccall libsuperlu_dist_Int64.zDeAllocLlu_3d(n::int_t, arg2::Ptr{zLUstruct_t{Int64}}, arg3::Ptr{gridinfo3d_t{Int64}})::Cint
end

function zDeAllocGlu_3d(arg1)
    @ccall libsuperlu_dist_Int64.zDeAllocGlu_3d(arg1::Ptr{zLUstruct_t{Int64}})::Cint
end

function zreduceAncestors3d(sender, receiver, nnodes, nodeList, Lval_buf, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zreduceAncestors3d(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, Lval_buf::Ptr{doublecomplex}, Uval_buf::Ptr{doublecomplex}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function zreduceAllAncestors3d(ilvl, myNodeCount, treePerm, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zreduceAllAncestors3d(ilvl::int_t, myNodeCount::Ptr{int_t}, treePerm::Ptr{Ptr{int_t}}, LUvsb::Ptr{zLUValSubBuf_t{Int64}}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::Cint
end

function zgatherFactoredLU(sender, receiver, nnodes, nodeList, LUvsb, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zgatherFactoredLU(sender::int_t, receiver::int_t, nnodes::int_t, nodeList::Ptr{int_t}, LUvsb::Ptr{zLUValSubBuf_t{Int64}}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function zgatherAllFactoredLU(trf3Dpartition, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zgatherAllFactoredLU(trf3Dpartition::Ptr{ztrf3Dpartition_t{Int64}}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function zinit3DLUstruct(myTreeIdxs, myZeroTrIdxs, nodeCount, nodeList, LUstruct, grid3d)
    @ccall libsuperlu_dist_Int64.zinit3DLUstruct(myTreeIdxs::Ptr{int_t}, myZeroTrIdxs::Ptr{int_t}, nodeCount::Ptr{int_t}, nodeList::Ptr{Ptr{int_t}}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}})::int_t
end

function zzSendLPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zzSendLPanel(k::int_t, receiver::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function zzRecvLPanel(k, sender, alpha, beta, Lval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zzRecvLPanel(k::int_t, sender::int_t, alpha::doublecomplex, beta::doublecomplex, Lval_buf::Ptr{doublecomplex}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function zzSendUPanel(k, receiver, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zzSendUPanel(k::int_t, receiver::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function zzRecvUPanel(k, sender, alpha, beta, Uval_buf, LUstruct, grid3d, SCT)
    @ccall libsuperlu_dist_Int64.zzRecvUPanel(k::int_t, sender::int_t, alpha::doublecomplex, beta::doublecomplex, Uval_buf::Ptr{doublecomplex}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, SCT::Ptr{SCT_t})::int_t
end

function zIBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, arg7, ToSendR, xsup, arg10)
    @ccall libsuperlu_dist_Int64.zIBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg10::Cint)::int_t
end

function zBcast_LPanel(k, k0, lsub, lusup, arg5, msgcnt, ToSendR, xsup, arg9, arg10)
    @ccall libsuperlu_dist_Int64.zBcast_LPanel(k::int_t, k0::int_t, lsub::Ptr{int_t}, lusup::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, ToSendR::Ptr{Ptr{Cint}}, xsup::Ptr{int_t}, arg9::Ptr{SCT_t}, arg10::Cint)::int_t
end

function zIBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, arg7, ToSendD, arg9)
    @ccall libsuperlu_dist_Int64.zIBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, arg7::Ptr{MPI_Request}, ToSendD::Ptr{Cint}, arg9::Cint)::int_t
end

function zBcast_UPanel(k, k0, usub, uval, arg5, msgcnt, ToSendD, arg8, arg9)
    @ccall libsuperlu_dist_Int64.zBcast_UPanel(k::int_t, k0::int_t, usub::Ptr{int_t}, uval::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t{Int64}}, msgcnt::Ptr{Cint}, ToSendD::Ptr{Cint}, arg8::Ptr{SCT_t}, arg9::Cint)::int_t
end

function zIrecv_LPanel(k, k0, Lsub_buf, Lval_buf, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zIrecv_LPanel(k::int_t, k0::int_t, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{doublecomplex}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{MPI_Request}, arg7::Ptr{zLocalLU_t{Int64}}, arg8::Cint)::int_t
end

function zIrecv_UPanel(k, k0, Usub_buf, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zIrecv_UPanel(k::int_t, k0::int_t, Usub_buf::Ptr{int_t}, arg4::Ptr{doublecomplex}, arg5::Ptr{zLocalLU_t{Int64}}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{MPI_Request}, arg8::Cint)::int_t
end

function zWait_URecv(arg1, msgcnt, arg3)
    @ccall libsuperlu_dist_Int64.zWait_URecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, arg3::Ptr{SCT_t})::int_t
end

function zWait_LRecv(arg1, msgcnt, msgcntsU, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zWait_LRecv(arg1::Ptr{MPI_Request}, msgcnt::Ptr{Cint}, msgcntsU::Ptr{Cint}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{SCT_t})::int_t
end

function zISend_UDiagBlock(k0, ublk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.zISend_UDiagBlock(k0::int_t, ublk_ptr::Ptr{doublecomplex}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Cint)::int_t
end

function zRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{doublecomplex}, size::int_t, src::int_t, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{SCT_t}, arg7::Cint)::int_t
end

function zPackLBlock(k, Dest, arg3, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zPackLBlock(k::int_t, Dest::Ptr{doublecomplex}, arg3::Ptr{Glu_persist_t}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{zLocalLU_t{Int64}})::int_t
end

function zISend_LDiagBlock(k0, lblk_ptr, size, arg4, arg5, arg6)
    @ccall libsuperlu_dist_Int64.zISend_LDiagBlock(k0::int_t, lblk_ptr::Ptr{doublecomplex}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Cint)::int_t
end

function zIRecv_UDiagBlock(k0, ublk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zIRecv_UDiagBlock(k0::int_t, ublk_ptr::Ptr{doublecomplex}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function zIRecv_LDiagBlock(k0, L_blk_ptr, size, src, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zIRecv_LDiagBlock(k0::int_t, L_blk_ptr::Ptr{doublecomplex}, size::int_t, src::int_t, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{SCT_t}, arg8::Cint)::int_t
end

function zUDiagBlockRecvWait(k, IrecvPlcd_D, factored_L, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zUDiagBlockRecvWait(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{zLUstruct_t{Int64}}, arg7::Ptr{SCT_t})::int_t
end

function zIBcast_UDiagBlock(k, ublk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zIBcast_UDiagBlock(k::int_t, ublk_ptr::Ptr{doublecomplex}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}})::int_t
end

function zIBcast_LDiagBlock(k, lblk_ptr, size, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zIBcast_LDiagBlock(k::int_t, lblk_ptr::Ptr{doublecomplex}, size::int_t, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}})::int_t
end

function zDiagFactIBCast(k, k0, BlockUFactor, BlockLFactor, IrecvPlcd_D, arg6, arg7, arg8, arg9, arg10, arg11, thresh, LUstruct, arg14, info, arg16, tag_ub)
    @ccall libsuperlu_dist_Int64.zDiagFactIBCast(k::int_t, k0::int_t, BlockUFactor::Ptr{doublecomplex}, BlockLFactor::Ptr{doublecomplex}, IrecvPlcd_D::Ptr{int_t}, arg6::Ptr{MPI_Request}, arg7::Ptr{MPI_Request}, arg8::Ptr{MPI_Request}, arg9::Ptr{MPI_Request}, arg10::Ptr{gridinfo_t{Int64}}, arg11::Ptr{superlu_dist_options_t}, thresh::Cdouble, LUstruct::Ptr{zLUstruct_t{Int64}}, arg14::Ptr{SuperLUStat_t{Int64}}, info::Ptr{Cint}, arg16::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function zUPanelTrSolve(k, BlockLFactor, bigV, ldt, arg5, arg6, arg7, arg8, arg9)
    @ccall libsuperlu_dist_Int64.zUPanelTrSolve(k::int_t, BlockLFactor::Ptr{doublecomplex}, bigV::Ptr{doublecomplex}, ldt::int_t, arg5::Ptr{Ublock_info_t}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{zLUstruct_t{Int64}}, arg8::Ptr{SuperLUStat_t{Int64}}, arg9::Ptr{SCT_t})::int_t
end

function zLPanelUpdate(k, IrecvPlcd_D, factored_L, arg4, BlockUFactor, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zLPanelUpdate(k::int_t, IrecvPlcd_D::Ptr{int_t}, factored_L::Ptr{int_t}, arg4::Ptr{MPI_Request}, BlockUFactor::Ptr{doublecomplex}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{zLUstruct_t{Int64}}, arg8::Ptr{SCT_t})::int_t
end

function zUPanelUpdate(k, factored_U, arg3, BlockLFactor, bigV, ldt, arg7, arg8, arg9, arg10, arg11)
    @ccall libsuperlu_dist_Int64.zUPanelUpdate(k::int_t, factored_U::Ptr{int_t}, arg3::Ptr{MPI_Request}, BlockLFactor::Ptr{doublecomplex}, bigV::Ptr{doublecomplex}, ldt::int_t, arg7::Ptr{Ublock_info_t}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{zLUstruct_t{Int64}}, arg10::Ptr{SuperLUStat_t{Int64}}, arg11::Ptr{SCT_t})::int_t
end

function zIBcastRecvLPanel(k, k0, msgcnt, arg4, arg5, Lsub_buf, Lval_buf, factored, arg9, arg10, arg11, tag_ub)
    @ccall libsuperlu_dist_Int64.zIBcastRecvLPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{doublecomplex}, factored::Ptr{int_t}, arg9::Ptr{gridinfo_t{Int64}}, arg10::Ptr{zLUstruct_t{Int64}}, arg11::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function zIBcastRecvUPanel(k, k0, msgcnt, arg4, arg5, Usub_buf, Uval_buf, arg8, arg9, arg10, tag_ub)
    @ccall libsuperlu_dist_Int64.zIBcastRecvUPanel(k::int_t, k0::int_t, msgcnt::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{doublecomplex}, arg8::Ptr{gridinfo_t{Int64}}, arg9::Ptr{zLUstruct_t{Int64}}, arg10::Ptr{SCT_t}, tag_ub::Cint)::int_t
end

function zWaitL(k, msgcnt, msgcntU, arg4, arg5, arg6, arg7, arg8)
    @ccall libsuperlu_dist_Int64.zWaitL(k::int_t, msgcnt::Ptr{Cint}, msgcntU::Ptr{Cint}, arg4::Ptr{MPI_Request}, arg5::Ptr{MPI_Request}, arg6::Ptr{gridinfo_t{Int64}}, arg7::Ptr{zLUstruct_t{Int64}}, arg8::Ptr{SCT_t})::int_t
end

function zWaitU(k, msgcnt, arg3, arg4, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zWaitU(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{MPI_Request}, arg4::Ptr{MPI_Request}, arg5::Ptr{gridinfo_t{Int64}}, arg6::Ptr{zLUstruct_t{Int64}}, arg7::Ptr{SCT_t})::int_t
end

function zLPanelTrSolve(k, factored_L, BlockUFactor, arg4, arg5)
    @ccall libsuperlu_dist_Int64.zLPanelTrSolve(k::int_t, factored_L::Ptr{int_t}, BlockUFactor::Ptr{doublecomplex}, arg4::Ptr{gridinfo_t{Int64}}, arg5::Ptr{zLUstruct_t{Int64}})::int_t
end

function zSchurComplementSetup(k, msgcnt, arg3, arg4, arg5, arg6, arg7, arg8, arg9, bigU, Lsub_buf, Lval_buf, Usub_buf, Uval_buf, arg15, arg16)
    @ccall libsuperlu_dist_Int64.zSchurComplementSetup(k::int_t, msgcnt::Ptr{Cint}, arg3::Ptr{Ublock_info_t}, arg4::Ptr{Remain_info_t}, arg5::Ptr{uPanelInfo_t{Int64}}, arg6::Ptr{lPanelInfo_t{Int64}}, arg7::Ptr{int_t}, arg8::Ptr{int_t}, arg9::Ptr{int_t}, bigU::Ptr{doublecomplex}, Lsub_buf::Ptr{int_t}, Lval_buf::Ptr{doublecomplex}, Usub_buf::Ptr{int_t}, Uval_buf::Ptr{doublecomplex}, arg15::Ptr{gridinfo_t{Int64}}, arg16::Ptr{zLUstruct_t{Int64}})::int_t
end

function zSchurComplementSetupGPU(k, msgs, arg3, arg4, arg5, arg6, arg7, arg8, arg9, LUvsb, arg11, arg12, arg13)
    @ccall libsuperlu_dist_Int64.zSchurComplementSetupGPU(k::int_t, msgs::Ptr{msgs_t}, arg3::Ptr{packLUInfo_t{Int64}}, arg4::Ptr{int_t}, arg5::Ptr{int_t}, arg6::Ptr{int_t}, arg7::Ptr{gEtreeInfo_t{Int64}}, arg8::Ptr{factNodelists_t{Int64}}, arg9::Ptr{zscuBufs_t}, LUvsb::Ptr{zLUValSubBuf_t{Int64}}, arg11::Ptr{gridinfo_t{Int64}}, arg12::Ptr{zLUstruct_t{Int64}}, arg13::Ptr{HyP_t})::int_t
end

function zgetBigV(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zgetBigV(arg1::int_t, arg2::int_t)::Ptr{doublecomplex}
end

function zgetBigU(arg1, arg2, arg3, arg4)
    @ccall libsuperlu_dist_Int64.zgetBigU(arg1::Ptr{superlu_dist_options_t}, arg2::int_t, arg3::Ptr{gridinfo_t{Int64}}, arg4::Ptr{zLUstruct_t{Int64}})::Ptr{doublecomplex}
end

function zLluBufInit(arg1, arg2)
    @ccall libsuperlu_dist_Int64.zLluBufInit(arg1::Ptr{zLUValSubBuf_t{Int64}}, arg2::Ptr{zLUstruct_t{Int64}})::int_t
end

function zinitScuBufs(arg1, ldt, num_threads, nsupers, arg5, arg6, arg7)
    @ccall libsuperlu_dist_Int64.zinitScuBufs(arg1::Ptr{superlu_dist_options_t}, ldt::int_t, num_threads::int_t, nsupers::int_t, arg5::Ptr{zscuBufs_t}, arg6::Ptr{zLUstruct_t{Int64}}, arg7::Ptr{gridinfo_t{Int64}})::int_t
end

function zfreeScuBufs(scuBufs)
    @ccall libsuperlu_dist_Int64.zfreeScuBufs(scuBufs::Ptr{zscuBufs_t})::Cint
end

function zsparseTreeFactor(nnodes, perm_c_supno, treeTopoInfo, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, info)
    @ccall libsuperlu_dist_Int64.zsparseTreeFactor(nnodes::int_t, perm_c_supno::Ptr{int_t}, treeTopoInfo::Ptr{treeTopoInfo_t{Int64}}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{zscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgs::Ptr{msgs_t}, LUvsb::Ptr{zLUValSubBuf_t{Int64}}, dFBuf::Ptr{zdiagFactBufs_t}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, info::Ptr{Cint})::int_t
end

function zdenseTreeFactor(nnnodes, perm_c_supno, comReqs, scuBufs, packLUInfo, msgs, LUvsb, dFBuf, factStat, fNlists, options, gIperm_c_supno, ldt, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int64.zdenseTreeFactor(nnnodes::int_t, perm_c_supno::Ptr{int_t}, comReqs::Ptr{commRequests_t}, scuBufs::Ptr{zscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgs::Ptr{msgs_t}, LUvsb::Ptr{zLUValSubBuf_t{Int64}}, dFBuf::Ptr{zdiagFactBufs_t}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function zsparseTreeFactor_ASYNC(sforest, comReqss, scuBufs, packLUInfo, msgss, LUvsbs, dFBufs, factStat, fNlists, gEtreeInfo, options, gIperm_c_supno, ldt, HyP, LUstruct, grid3d, stat, thresh, SCT, tag_ub, info)
    @ccall libsuperlu_dist_Int64.zsparseTreeFactor_ASYNC(sforest::Ptr{sForest_t{Int64}}, comReqss::Ptr{Ptr{commRequests_t}}, scuBufs::Ptr{zscuBufs_t}, packLUInfo::Ptr{packLUInfo_t{Int64}}, msgss::Ptr{Ptr{msgs_t}}, LUvsbs::Ptr{Ptr{zLUValSubBuf_t{Int64}}}, dFBufs::Ptr{Ptr{zdiagFactBufs_t}}, factStat::Ptr{factStat_t{Int64}}, fNlists::Ptr{factNodelists_t{Int64}}, gEtreeInfo::Ptr{gEtreeInfo_t{Int64}}, options::Ptr{superlu_dist_options_t}, gIperm_c_supno::Ptr{int_t}, ldt::int_t, HyP::Ptr{HyP_t}, LUstruct::Ptr{zLUstruct_t{Int64}}, grid3d::Ptr{gridinfo3d_t{Int64}}, stat::Ptr{SuperLUStat_t{Int64}}, thresh::Cdouble, SCT::Ptr{SCT_t}, tag_ub::Cint, info::Ptr{Cint})::int_t
end

function zLluBufInitArr(numLA, LUstruct)
    @ccall libsuperlu_dist_Int64.zLluBufInitArr(numLA::int_t, LUstruct::Ptr{zLUstruct_t{Int64}})::Ptr{Ptr{zLUValSubBuf_t{Int64}}}
end

function zLluBufFreeArr(numLA, LUvsbs)
    @ccall libsuperlu_dist_Int64.zLluBufFreeArr(numLA::int_t, LUvsbs::Ptr{Ptr{zLUValSubBuf_t{Int64}}})::Cint
end

function zinitDiagFactBufsArr(mxLeafNode, ldt, grid)
    @ccall libsuperlu_dist_Int64.zinitDiagFactBufsArr(mxLeafNode::int_t, ldt::int_t, grid::Ptr{gridinfo_t{Int64}})::Ptr{Ptr{zdiagFactBufs_t}}
end

function zfreeDiagFactBufsArr(mxLeafNode, dFBufs)
    @ccall libsuperlu_dist_Int64.zfreeDiagFactBufsArr(mxLeafNode::int_t, dFBufs::Ptr{Ptr{zdiagFactBufs_t}})::Cint
end

function zinitDiagFactBufs(ldt, dFBuf)
    @ccall libsuperlu_dist_Int64.zinitDiagFactBufs(ldt::int_t, dFBuf::Ptr{zdiagFactBufs_t})::int_t
end

const TRUE = 1

const HAVE_PARMETIS = TRUE

const XSDK_INDEX_SIZE = 64

const _LONGINT = 1

const EMPTY = -1

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

const MAX_LOOKAHEADS = 50

const SUPERLU_DIST_MAJOR_VERSION = 8

const SUPERLU_DIST_MINOR_VERSION = 1

const SUPERLU_DIST_PATCH_VERSION = 2

const SUPERLU_DIST_RELEASE_DATE = "November 12, 2022"

const MAX_SUPER_SIZE = 512

const BC_HEADER = 2

const LB_DESCRIPTOR = 2

const BR_HEADER = 3

const UB_DESCRIPTOR = 2

const BC_HEADER_NEWU = 3

const UB_DESCRIPTOR_NEWU = 2

const NBUFFERS = 5

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

const DIM_X = 16

const DIM_Y = 16

const BLK_M = DIM_X * 4

const BLK_N = DIM_Y * 4

const BLK_K = 2048 ÷ BLK_M

const DIM_XA = DIM_X

const DIM_YA = DIM_Y

const DIM_XB = DIM_X

const DIM_YB = DIM_Y

const NWARP = (DIM_X * DIM_Y) ÷ 32

const THR_M = BLK_M ÷ DIM_X

const THR_N = BLK_N ÷ DIM_Y

const DEG_TREE = 2

end