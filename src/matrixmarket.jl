"""
    cscstore(Tv, Ti, A)

Copy the sparse matrix `A` (anything with `SparseMatrixCSC`'s `colptr`, `rowval` and `nzval`
fields, such as the result of `MatrixMarket.mmread`) into a `SparseBase.CSCStore` with the
0-based `CIndex{Ti}` indices that SuperLU_DIST expects. The values are always copied,
since SuperLU_DIST may scale and permute the matrix in place.
"""
function cscstore(::Type{Tv}, ::Type{Ti}, A) where {Tv, Ti}
    return SparseBase.CSCStore(
        CIndex{Ti}.(A.colptr), CIndex{Ti}.(A.rowval), Vector{Tv}(A.nzval), size(A)
    )
end

"""
    coostore(Tv, Ti, A)

Like [`cscstore`](@ref), but copy `A` into a `SparseBase.CoordinateStore`.
"""
function coostore(::Type{Tv}, ::Type{Ti}, A) where {Tv, Ti}
    cols = Vector{CIndex{Ti}}(undef, length(A.rowval))
    for j in 1:size(A, 2), k in A.colptr[j]:(A.colptr[j + 1] - 1)
        cols[k] = j
    end
    return SparseBase.CoordinateStore(
        (CIndex{Ti}.(A.rowval), cols), Vector{Tv}(A.nzval), size(A)
    )
end

# MatrixMarket.mmread returns symmetric matrices in full form.
_mmread_csc(::Type{Tv}, ::Type{Ti}, filename) where {Tv, Ti} =
    cscstore(Tv, Ti, MatrixMarket.mmread(filename))
_mmread_coo(::Type{Tv}, ::Type{Ti}, filename) where {Tv, Ti} =
    coostore(Tv, Ti, MatrixMarket.mmread(filename))

"""
    mmread(ReplicatedSuperMatrix{Tv, Ti}, filename::String, grid::Grid{Ti}; root = 0)

Read an `mtx` file on rank `root` into a compressed sparse column format and
broadcast it to all ranks in `grid`.

# Arguments
  - `arg1<:Type{ReplicatedSuperMatrix{Tv, Ti}}`
    - `Tv <: Union{Float32, Float64, ComplexF64}`: Non-optional eltype.
    - `Ti <: Union{Int32, Int64}`: Non-optional index type.
  - `filename::String`: `.mtx` file accessible by the `root` process.
  - `grid::Grid{Ti}`: The process grid on which to replicate the matrix.

# Keyword Arguments
  - `root::Int = 0`: The MPI process on which to read the file.

# Example
```julia
using MPI, SuperLUDIST, MatrixMarket
grid = SuperLUDIST.Grid{Int32}(1, 1)
A = MatrixMarket.mmread(ReplicatedSuperMatrix{Float64, Int32}, "matrix.mtx", grid)
```
"""
function MatrixMarket.mmread(
    ::Type{<:ReplicatedSuperMatrix{Tv, Ti}}, filename, grid::Grid{Ti};
    root = 0
) where {Tv <: Union{Float32, Float64, ComplexF64}, Ti <: Union{Int32, Int64}}
    comm = grid.comm
    rank = MPI.Comm_rank(comm)
    if rank == root
        x = _mmread_csc(Tv, Ti, filename)
    else
        x = SparseBase.CSCStore(CIndex{Ti}[], CIndex{Ti}[], Tv[], (0, 0))
    end
    Communication.bcaststore!(x, root, comm)
    ReplicatedSuperMatrix(x, grid)
end

"""
    mmread(DistributedSuperMatrix{Tv, Ti}, filename::String, grid::AbstractGrid{Ti}; root = 0, partitioner = distribute_evenly)

Read an `mtx` file on rank `root` and distribute its rows between the ranks in `grid`.
The grid must use all the ranks of `grid.comm`.

# Arguments
  - `arg1<:Type{DistributedSuperMatrix{Tv, Ti}}`
    - `Tv <: Union{Float32, Float64, ComplexF64}`: Non-optional eltype.
    - `Ti <: Union{Int32, Int64}`: Non-optional index type.
  - `filename::String`: `.mtx` file accessible by the `root` process.
  - `grid::AbstractGrid{Ti}`: The 2D or 3D process grid on which to distribute the matrix.

# Keyword Arguments
  - `root::Int = 0`: The MPI process on which to read the file.
  - `partitioner = SparseBase.Communication.distribute_evenly`: Computes the number of rows
on each rank from the number of rows and ranks.

# Example
```julia
using MPI, SuperLUDIST, MatrixMarket
grid = SuperLUDIST.Grid{Int32}(2, 2)
A = MatrixMarket.mmread(DistributedSuperMatrix{Float64, Int32}, "matrix.mtx", grid)
```
"""
function MatrixMarket.mmread(
  ::Type{<:DistributedSuperMatrix{Tv, Ti}}, filename, grid::AbstractGrid{Ti};
  root = 0, partitioner = Communication.distribute_evenly
) where {Tv <: Union{Float32, Float64, ComplexF64}, Ti <: Union{Int32, Int64}}
  comm = grid.comm
  # The rows are distributed over every rank of `comm`, so they must all be in the grid.
  # Ranks outside the grid see dimensions of 0 or the grid's, so they all throw together.
  np = MPI.Comm_size(comm)
  gridsize(grid) == np || throw(ArgumentError(
    "mmread distributes the rows over all $np ranks of grid.comm, but the grid has " *
    "$(gridsize(grid)) ranks. Build the grid on a communicator of its size."
  ))
  rank = MPI.Comm_rank(comm)
  if rank == root
    x = convert(SparseBase.CSRStore, _mmread_coo(Tv, Ti, filename))
    chunksizes = partitioner(size(x, 1), np)
  else
    x = nothing
    chunksizes = nothing
  end
  return Communication.scatterstore!(
    DistributedSuperMatrix{Tv, Ti}(grid), x, chunksizes; root, comm
  )
end

"""
    mmread_and_generatesolution(Tv, Ti, nrhs, path, grid::AbstractGrid; root = 0)

Read the Matrix Market file `path` on rank `root`, and generate a test problem for it, as
SuperLU_DIST's example drivers do. Returns `(coo, b, xtrue)`, where `coo` is the matrix as a
`SparseBase.CoordinateStore` on `root` (`nothing` elsewhere) and `b = A * xtrue` holds `nrhs`
right-hand sides on every rank.
"""
function mmread_and_generatesolution(Tv, Ti, nrhs, path, grid::AbstractGrid; root = 0)
  comm = grid.comm
  iam = grid.iam
  if iam == root
      A = MatrixMarket.mmread(path)
      coo = coostore(Tv, Ti, A)
      m, n = size(A)
  else
      coo = nothing
      m, n = 0, 0
  end
  m, n = MPI.bcast((m, n), comm; root)
  xtrue = Matrix{Tv}(undef, n, nrhs)
  b = Matrix{Tv}(undef, m, nrhs)
  if iam == root
      GenXtrue_dist!(xtrue, Ti)
      b .= A * xtrue
  end
  MPI.Bcast!(b, root, comm)
  MPI.Bcast!(xtrue, root, comm)
  return coo, b, xtrue
end
