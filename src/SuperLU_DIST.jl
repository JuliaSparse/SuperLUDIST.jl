module SuperLU_DIST

using SparseArrays
using SparseArrays: SparseMatrixCSC
import SparseArrays: nnz
using MPI
# using SuperLU_DIST_jll
#TODO export 
libsuperlu_dist_Int64 = "/home/wimmerer/spack/opt/spack/linux-ubuntu18.04-skylake_avx512/gcc-7.5.0/superlu-dist-7.2.0-vmqreciesrsyalwhob2wv62nrgjrbei3/lib/libsuperlu_dist.so"
libsuperlu_ddefs = libsuperlu_dist_Int64
include("../lib/libsuperlu_dist.jl")
using Libdl
Libdl.dlopen(libsuperlu_dist_Int64)

import Base: (\), size, getproperty, setproperty!, propertynames, show

# Convert from 1-based to 0-based indices
function decrement!(A::AbstractArray{T}) where T<:Integer
    for i in eachindex(A); A[i] -= oneunit(T) end
    A
end
decrement(A::AbstractArray{<:Integer}) = decrement!(copy(A))

# Convert from 0-based to 1-based indices
function increment!(A::AbstractArray{T}) where T<:Integer
    for i in eachindex(A); A[i] += oneunit(T) end
    A
end
increment(A::AbstractArray{<:Integer}) = increment!(copy(A))
#=
using .Libsuperlu_dist:
    #Struct
    SuperMatrix,
    NCformat,
    NRformat,
    SCformat,
    SCPformat,
    NCPformat,
    DNformat,
    NRformat_loc,
    NRformat_loc3d,
    SuperLUStat_t,
    e_node,
    SuperLU_LU_stack_t,
    SCT_t,
    Pslu_freeable_t,
    Llu_symbfact_t,
    vtcsInfo_symbfact_t,
    matrix_symbfact_t,
    comm_symbfact_t,
    psymbfact_stat_t,
    #MPI
    superlu_scope_t,
    gridinfo_t,
    gridinfo3d_t,
    Glu_persist_t,
    Glu_freeable_t,
    pxgstrs_comm_t,
    superlu_dist_options_t,
    superlu_dist_mem_usage_t,
    Ucb_indptr_t,
    Ublock_info_t,
    Remain_info_t,
    etree_node,
    superlu_pair,
    uPanelInfo_t,
    lPanelInfo_t,
    packLUInfo_t,
    HyP_t,
    local_l_blk_info_t,
    local_u_blk_info_t,
    perm_array_t,
    factStat_t,
    d2Hreduce_t,
    treeList_t,
    treeTopoInfo_t,
    gEtreeInfo_t,
    sForest_t,
    commRequests_t,
    factNodelists_t,
    msgs_t,
    xtrsTimer_t
    =#

end

