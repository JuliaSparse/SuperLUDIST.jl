
using SparseBase: CoordinateStore
"""
    mmread(ReplicatedSuperMatrix{Tv, Ti}, filename::String)

Read an `mtx` file into a compressed sparse column format and
broadcast it to all ranks in `comm`.

To read an `mtx` file locally use `mmread(SparseBase.CSCStore...)`.

# Arguments
  - `arg1<:Type{ReplicatedSuperMatrix{Tv, Ti}}`
    - `Tv <: Union{Float32, Float64, ComplexF64}`: Non-optional eltype.
    - `Ti <: Union{Int32, Int64}`: Non-optional index type.
  - `filename::String`: `.mtx` file accessible by the `root` process.

# Keyword Arguments
  - `desymmetrize::Bool = true`: If the matrix file is represented
in symmetric form, represent in the full form.
  - `root::Int = 0`: The MPI process on which to read the file.
  - `comm::MPI.Comm = MPI.COMM_WORLD`: The MPI communicator on which to distribute
the matrix.

# Example
```julia
using MPI, SuperLUDIST, MatrixMarket
A = MatrixMarket.mmread(ReplicatedSuperMatrix{Float64, Int32}, )
```
"""
function MatrixMarket.mmread(
    ::Type{<:ReplicatedSuperMatrix{Tv, Ti}}, filename, grid::Grid{Ti}; 
    desymmetrize = true, root = 0
) where {Tv <: Union{Float32, Float64, ComplexF64}, Ti <: Union{Int32, Int64}}
    comm = grid.comm
    rank = MPI.Comm_rank(comm)
    if rank == root
        x = convert(SparseBase.CSCStore, mmread(CoordinateStore{Tv, CIndex{Ti}}, filename; desymmetrize))
    else
        x = SparseBase.CSCStore(CIndex{Ti}[], CIndex{Ti}[], Tv[], (0, 0))
    end
    Communication.bcaststore!(x, root, comm)
    ReplicatedSuperMatrix(x, grid)
end

"""
    mmread(DistributedSuperMatrix{Tv, Ti}, filename::String, partitioner = distribute_evenly)

Read an `mtx` file into a compressed sparse column format and
broadcast it to all ranks in `comm`.

To read an `mtx` file locally use `mmread(SparseBase.CSCStore...)`.

# Arguments
  - `arg1<:Type{ReplicatedSuperMatrix{Tv, Ti}}`
    - `Tv <: Union{Float32, Float64, ComplexF64}`: Non-optional eltype.
    - `Ti <: Union{Int32, Int64}`: Non-optional index type.
  - `filename::String`: `.mtx` file accessible by the `root` process.

# Keyword Arguments
  - `desymmetrize::Bool = true`: If the matrix file is represented
in symmetric form, represent in the full form.
  - `root::Int = 0`: The MPI process on which to read the file.
  - `comm::MPI.Comm = MPI.COMM_WORLD`: The MPI communicator on which to distribute
the matrix.

# Example
```julia
using MPI, SuperLUDIST, MatrixMarket
A = MatrixMarket.mmread(ReplicatedSuperMatrix{Float64, Int32}, )
```
"""
function MatrixMarket.mmread(
  ::Type{<:DistributedSuperMatrix{Tv, Ti}}, filename, grid::Grid{Ti}; 
  desymmetrize = true, root = 0, partitioner = Communication.distribute_evenly
) where {Tv <: Union{Float32, Float64, ComplexF64}, Ti <: Union{Int32, Int64}}
  comm = grid.comm
  rank = MPI.Comm_rank(comm)
  if rank == root
    x = convert(SparseBase.CSRStore, mmread(CoordinateStore{Tv, CIndex{Ti}}, filename; desymmetrize))
  else
    x = nothing
  end
  out = SparseBase.CSRStore(CIndex{Ti}[], CIndex{Ti}[], Tv[], (0, 0))

  part = Communication.ContinuousPartitioning(partitioner(nrows, MPI.Comm_size(comm)), ncols)
  rowsizes = Communication.partition_sizes(part)[1]
  out, globalnrows, startingrow = Communication.scatterstore!(out, x, rowsizes; root, comm)

  out = DistributedSuperMatrix(out, startingrow, (globalnrows, size(out, 2)), grid)
end

function mmread_and_generatesolution(Tv, Ti, nrhs, path, grid; root = 0)
  comm = grid.comm
  iam = grid.iam
  if iam == root
      coo = MatrixMarket.mmread(SparseBase.CoordinateStore{Tv, CIndex{Ti}},
          path)
      csc = convert(SparseBase.CSCStore, coo)
  else
      csc = SparseBase.CSCStore{Tv, CIndex{Ti}}()
      coo = nothing
  end
  Communication.bcaststore!(csc, root, comm)
  Acsc = SuperLUDIST.ReplicatedSuperMatrix(csc, grid)
  m, n, = size(Acsc)
  xtrue = Matrix{Tv}(undef, n, nrhs)
  b = Matrix{Tv}(undef, m, nrhs)
  if iam == root
      SuperLUDIST.GenXtrue_dist!(xtrue, Int32)
      SuperLUDIST.FillRHS_dist!(b, Acsc, xtrue)
  end
  MPI.Bcast!(b, root, comm)
  MPI.Bcast!(xtrue, root, comm)
  return coo, b, xtrue
end
