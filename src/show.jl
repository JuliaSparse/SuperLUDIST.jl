# Display. A SuperMatrix is an `AbstractMatrix` without `getindex`, so the generic array
# printing fails on it, and the generated C structs make the default printing unreadable.

griddims(g::Grid) = (g.nprow, g.npcol)
griddims(g::Grid3D) = (g.nprow, g.npcol, g.npdep)
function showgrid(io::IO, g::AbstractGrid{I}) where I
    print(io, join(griddims(g), "×"), " ", nameof(typeof(g)), "{", I, "}")
end

Base.show(io::IO, g::AbstractGrid) = showgrid(io, g)
function Base.show(io::IO, ::MIME"text/plain", g::AbstractGrid)
    showgrid(io, g)
    # As the Grid constructor does, count ranks numbered past the grid's size as outside it.
    ingrid = g.iam != -1 && g.iam < gridsize(g)
    print(io, ingrid ? " (this rank is $(g.iam))" : " (this rank is not in the grid)")
end

function showtype(io::IO, A::AbstractSuperMatrix{T, I}) where {T, I}
    print(io, join(size(A), "×"), " ", nameof(typeof(A)), "{", T, ", ", I, "}")
end

Base.show(io::IO, A::AbstractSuperMatrix) = showtype(io, A)
function Base.show(io::IO, ::MIME"text/plain", A::ReplicatedSuperMatrix)
    showtype(io, A)
    print(io, " with ", nstored(A.store), " stored entries on a ")
    showgrid(io, A.grid)
end
function Base.show(io::IO, ::MIME"text/plain", A::DistributedSuperMatrix)
    showtype(io, A)
    m_loc = Communication.localsize(A, 1)
    print(io, " with rows ", A.first_row, ":", A.first_row + m_loc - 1, " (",
        nstored(A.store), " stored entries) on this rank of a ")
    showgrid(io, A.grid)
end

function Base.show(io::IO, F::SuperLUFactorization{T, I}) where {T, I}
    print(io, "SuperLUFactorization{", T, ", ", I, "}(")
    showtype(io, F.mat)
    print(io, ")")
end
function Base.show(io::IO, ::MIME"text/plain", F::SuperLUFactorization{T, I}) where {T, I}
    print(io, "SuperLUFactorization{", T, ", ", I, "} of a ")
    showtype(io, F.mat)
    print(io, " on a ")
    showgrid(io, F.mat.grid)
    print(io, isfactored(F) ? ", factored" : ", not factored")
end
