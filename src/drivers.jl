function pgssvx!(
    A::ReplicatedSuperMatrix{Tv, Ti},
    b::Array{Tv},
    grid;
    options = Options(),
    perm = ScalePermStruct{Tv, Ti}(size(A)...),
    LU = LUStruct{Tv, Ti}(size(A, 2), grid),
    stat = LUStat{Ti}(),
    berr = Vector{Tv}(undef, size(b, 2))
) where {Tv, Ti}
    return pgssvx_ABglobal!(options, A, perm, b, grid, LU, berr, stat)
end

function pgssvx!(
    A::DistributedSuperMatrix{Tv, Ti},
    b::Array{Tv},
    grid;
    options = Options(),
    Solve = SOLVE{Tv, Ti}(options),
    perm = ScalePermStruct{Tv, Ti}(size(A)...),
    LU = LUStruct{Tv, Ti}(size(A, 2), grid),
    stat = LUStat{Ti}(),
    berr = Vector{Tv}(undef, size(b, 2))
) where {Tv, Ti}
    return pgssvx_ABdist!(options, A, perm, b, grid, LU, Solve, berr, stat)
end

for T ∈ (Float32, Float64, ComplexF64)
for I ∈ (Int32, Int64)
L = Symbol(:SuperLU_, Symbol(I))
@eval begin
function pgssvx_ABglobal!(
    options,
    A::ReplicatedSuperMatrix{$T, $I},
    perm::ScalePermStruct{$T, $I},
    b::Array{$T},
    grid::Grid{$I},
    LU::LUStruct{$T, $I},
    berr, stat::LUStat{$I}
)
    info = Ref{Int32}()
    $L.$(Symbol(:p, prefixsymbol(T), :gssvx_ABglobal))(
        options, A, perm, b, size(b, 1), size(b, 2),
        grid, LU, berr, stat, info
    )
    # TODO: error handle
    info[] == 0 || throw(ArgumentError("Something wrong :)"))
    return b, perm, LU, stat
end
function pgssvx_ABdist!(
    options,
    A::DistributedSuperMatrix{$T, $I},
    perm::ScalePermStruct{$T, $I},
    b::Array{$T},
    grid::Grid{$I},
    LU::LUStruct{$T, $I},
    Solve::SOLVE{$T, $I},
    berr, stat::LUStat{$I}
)
    info = Ref{Int32}()
    $L.$(Symbol(:p, prefixsymbol(T), :gssvx))(
    options, A, perm, b, size(b, 1), size(b, 2),
    grid, LU, Solve, berr, stat, info
    )
    info[] == 0 ||
        error("Error INFO = $(info[]) from pgssvx")
    return b, perm, LU, stat
end
function inf_norm_error_dist(x::Array{$T}, xtrue::Array{$T}, grid::Grid{$I})
    $L.$(prefixname(T, :inf_norm_error_dist))(
        $I(size(x, 1)), $I(size(x, 2)),
        x, $I(size(x, 1)),
        xtrue, $I(size(xtrue, 1)),
        grid
    )
end
end
end
end
