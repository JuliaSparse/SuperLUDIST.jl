for T ∈ (Float32, Float64, ComplexF64)
for I ∈ (:Int32, :Int64)
L = Symbol(String(:SuperLU_) * String(I))
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
        a::Base.RefValue{SuperMatrix{$I}}, m, n, nnz, 
        nzval::AbstractVector{$T},
        rowindices::AbstractVector{$I},
        colptrs::AbstractVector{$I},
        mtype = Common.SLU_GE
    )
        $L.$(prefixname(T, :Create_CompCol_Matrix_dist))(
            a, m, n, nnz, nzval, rowindices, colptrs,
            Common.SLU_NC, toslutype($T), mtype
        )
        return a
    end

    function readhb_dist(iam, fpp, m, n, nnz, aref::Base.RefValue{Ptr{$T}}, asubref::Base.RefValue{Ptr{$I}}, xaref::Base.RefValue{Ptr{$I}})
        $L.$(prefixname(T, :readhb_dist))(
            iam, fpp, m, n, nnz, aref, asubref, xaref
        )
    end
    function readtriple_dist(iam, fpp, m, n, nnz, aref::Base.RefValue{Ptr{$T}}, asubref::Base.RefValue{Ptr{$I}}, xaref::Base.RefValue{Ptr{$I}})
        $L.$(prefixname(T, :readtriple_dist))(
            iam, fpp, m, n, nnz, aref, asubref, xaref
        )
    end
    function allocateA_dist(n, nnz, aref::Base.RefValue{Ptr{$T}}, asubref::Base.RefValue{Ptr{$I}}, xaref::Base.RefValue{Ptr{$I}})
        $L.$(prefixname(T, :allocateA_dist))(n, nnz, aref, asubref, xaref)
    end

    function GenXtrue_dist!(xtrue::Array{$T}, n::$I, nrhs::$I, ldx = n)
        $L.$(prefixname(T, :GenXtrue_dist))(n, nrhs, xtrue, ldx)
    end
    function FillRHS_dist!(b, A::AbstractSuperMatrix{$T, $I}, xtrue::Array{$T}, trans, nrhs, ldx, ldb)
        trans = trans ? Ref{Cchar}('T') : Ref{Cchar}('N')
        $L.$(prefixname(T, :FillRHS_dist))(trans, nrhs, xtrue, ldx, A, b, ldb)
    end

    function ScalePermstructFree(r::Base.RefValue{$(prefixname(T, :ScalePermstruct_t)){$I}})
        $L.$(prefixname(T, :ScalePermstructFree))(r)
    end
    function ScalePermstructInit(r::Base.RefValue{$(prefixname(T, :ScalePermstruct_t)){$I}}, m, n)
        $L.$(prefixname(T, :ScalePermstructInit))(m, n, r)
        return finalizer(r) do x
            !MPI.Finalized() && ScalePermstructFree(x)
        end
    end
    function LUstructFree(r::Base.RefValue{$(prefixname(T, :LUstruct_t)){$I}})
        $L.$(prefixname(T, :LUstructFree))(r)
    end
    function Destroy_LU(r::Base.RefValue{$(prefixname(T, :LUstruct_t)){$I}}, n, grid)
        $L.$(prefixname(T, :Destroy_LU))(n, grid, r) # why do I have to grid.grid here?!
    end
    function LUstructInit(r::$(prefixname(T, :LUstruct_t)){$I}, n, grid)
        $L.$(prefixname(T, :LUstructInit))(n, r)
        return finalizer(r) do x
            # !MPI.Finalized() && Destroy_LU(x, n, grid)
            # !MPI.Finalized() && LUstructFree(x)
        end
    end
end
end
end

function GenXtrue_dist!(xtrue, ::Type{Ti} = Int) where Ti
    GenXtrue_dist!(xtrue, Ti(size(xtrue, 1)), Ti(size(xtrue, 2)))
    return xtrue
end

function FillRHS_dist!(b::Array, A::AbstractSuperMatrix, xtrue::Array;
    trans = false, nrhs = size(xtrue, 2), ldx = size(xtrue, 1), ldb = size(b, 1))
    FillRHS_dist!(b, A, xtrue, trans, nrhs, ldx, ldb)
    return b
end
