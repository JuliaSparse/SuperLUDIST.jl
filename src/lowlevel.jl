for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
for T ∈ (Float32, Float64, ComplexF64)
@eval begin
    function _create_csrlocal_matrix(
        a::Base.RefValue{$L.SuperMatrix}, m, n, nnz_local, m_local, first_row, 
        nzval::AbstractVector{$T}, 
        colindices::AbstractVector{CIndex{$I}}, 
        rowptrs::AbstractVector{CIndex{$I}}, 
        mtype = Common.SLU_GE
    )
        $L.$(prefixname(T, :Create_CompRowLoc_Matrix_dist))(
            a, m, n, nnz_local, m_local, first_row,
            nzval, colindices, rowptrs, Common.SLU_NR_loc,
            toslutype($T), mtype
        )
        return a
    end

    function _create_cscglobal_matrix(
        a::Base.RefValue{$L.SuperMatrix}, m, n, nnz, 
        nzval::AbstractVector{$T},
        rowindices::AbstractVector{CIndex{$I}},
        colptrs::AbstractVector{CIndex{$I}},
        mtype = Common.SLU_GE
    )
        $L.$(prefixname(T, :Create_CompCol_Matrix_dist))(
            a, m, n, nnz, nzval, rowindices, colptrs,
            Common.SLU_NC, toslutype($T), mtype
        )
        return a
    end
end
end
end