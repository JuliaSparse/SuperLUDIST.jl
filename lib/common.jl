module SuperLUDIST_Common



"""
    yes_no_t

Enumerate types
"""
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
    METIS_ATA = 6
    ZOLTAN = 7
    MY_PERMC = 8
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
    SLU_GMRES = 4
end

@enum MemType::UInt32 begin
    LUSUP = 0
    UCOL = 1
    LSUB = 2
    USUB = 3
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

"""
    Stype_t

The matrix types are defined as follows. *
"""
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

@enum treePartStrat::UInt32 begin
    ND = 0
    GD = 1
end

@enum SupernodeToGridMap_t::UInt32 begin
    NOT_IN_GRID = 0
    IN_GRID_ZERO = 1
    IN_GRID_AIJ = 2
end

@enum trtype_t::UInt32 begin
    UPPER_TRI = 0
    LOWER_TRI = 1
end

# Export the enum types and their values for the width modules and `src/`.
for name in names(@__MODULE__; all = true)
    name in (:eval, :include, nameof(@__MODULE__)) || startswith(string(name), '#') ||
        @eval export $name
end


end # module
