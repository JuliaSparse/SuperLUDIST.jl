```@meta
CurrentModule = SuperLUDIST
```

# Usage

All SuperLUDIST.jl programs run under MPI. Every rank runs the same script, and calls into
SuperLU_DIST are collective: every rank in the grid must make them, in the same order.

## Process grids

SuperLU_DIST distributes the factorization over a 2D `nprow × npcol` grid of MPI ranks, which
must use at most `MPI.Comm_size(comm)` ranks. The index type of the grid (`Int32` or `Int64`)
selects which SuperLU_DIST build is used, and must match the index type of the matrices:

```julia
using MPI, SuperLUDIST
using SuperLUDIST: Grid
MPI.Init()
grid = Grid{Int64}(2, 2, MPI.COMM_WORLD)
grid.iam # this rank's number within the grid
```

By default the ranks are laid out on the grid in row-major order. With `batch = true` the grid
is built with `superlu_gridmap` instead, from a `usermap` matrix of ranks (row-major by
default), for example to give each of several grids its own subset of ranks:

```julia
grid = Grid{Int64}(2, 2, MPI.COMM_WORLD; batch = true, usermap = [0 1; 2 3])
```

## Replicated matrices

A [`ReplicatedSuperMatrix`](@ref) holds the whole matrix in compressed sparse column form on
every rank, and is solved with SuperLU_DIST's `pgssvx_ABglobal` drivers. This is the simplest
way to get started, but it needs the whole matrix and right-hand side on every rank.

```julia
using SparseArrays
A = ReplicatedSuperMatrix(S, grid)                # S::SparseMatrixCSC, the same on every rank
x, F = SuperLUDIST.pgssvx!(A, copy(b))            # b holds every row
```

A `ReplicatedSuperMatrix` can also be built from any `SparseBase` store, with 1-based indices
or 0-based `CIndex` ones, for example from coordinate (COO) form:

```julia
using SparseBase
I, J, V = findnz(S)
A = ReplicatedSuperMatrix(SparseBase.CoordinateStore((Int64.(I), Int64.(J)), V, size(S)), grid)
```

To read a Matrix Market file on one rank and broadcast it:

```julia
using MatrixMarket
A = MatrixMarket.mmread(ReplicatedSuperMatrix{Float64, Int64}, "matrix.mtx", grid)
```

!!! note
    Because of a bug in SuperLU_DIST
    ([xiaoyeli/superlu_dist#238](https://github.com/xiaoyeli/superlu_dist/issues/238)),
    `Float32` solves of a `ReplicatedSuperMatrix` on more than one rank are done without
    equilibration (`options.Equil` is set to `NO`). Use a [`DistributedSuperMatrix`](@ref)
    if you need it.

## Distributed matrices

A [`DistributedSuperMatrix`](@ref) holds a contiguous block of rows on each rank, in compressed
sparse row form, and is solved with SuperLU_DIST's `pgssvx` drivers. Each rank also holds its own
rows of the right-hand side.

If each rank builds its own rows, wrap them directly (CSR arrays with 1-based indices):

```julia
A = DistributedSuperMatrix(rowptr, colidx, nzval, firstrow, localsize, globalsize, grid)
```

Here `firstrow` is the global number of this rank's first row, `localsize` the size of the
local block (`(number of local rows, number of columns)`) and `globalsize` the size of the
whole matrix. The same block can be given in coordinate form, with local row numbers:

```julia
A = DistributedSuperMatrix((rows, cols), nzval, firstrow, localsize, globalsize, grid)
```

Or scatter a matrix assembled on one rank:

```julia
using SparseBase
using SparseBase.Communication: distribute_evenly, scatterstore!
csr = grid.iam == 0 ? convert(SparseBase.CSRStore, SuperLUDIST.coostore(Float64, Int64, S)) : nothing
chunks = grid.iam == 0 ? distribute_evenly(size(S, 1), 4) : nothing
A = scatterstore!(DistributedSuperMatrix{Float64, Int64}(grid), csr, chunks; root = 0)
rows = A.first_row:(A.first_row + SparseBase.Communication.localsize(A, 1) - 1)
```

`MatrixMarket.mmread(DistributedSuperMatrix{Tv, Ti}, filename, grid)` reads a file on the root
rank and distributes its rows the same way.

## Solving and reusing factorizations

[`pgssvx!`](@ref) factorizes and solves in one call, overwriting `b` with the solution, and
returns the solution and a factorization object:

```julia
x, F = SuperLUDIST.pgssvx!(A, b)
```

You can also factorize first with `lu!`, and then solve with `\` or `ldiv!`, as often as needed
and with any number of right-hand sides:

```julia
using LinearAlgebra
F = lu!(A)
x = F \ b
ldiv!(F, B)   # in place
```

To factorize without a right-hand side, call `pgssvx!` without `b`:

```julia
_, F = SuperLUDIST.pgssvx!(A)
SuperLUDIST.isfactored(F) # true
```

Note that SuperLU_DIST may scale and permute the values of `A` in place.

## Options

[`Options`](@ref) wraps SuperLU_DIST's `superlu_dist_options_t`. It starts from SuperLU_DIST's
defaults, and any field can be set with a keyword or as a property:

```julia
using SuperLUDIST: Options, Common
opts = Options{Int64}(; ColPerm = Common.MMD_AT_PLUS_A, PrintStat = Common.NO)
opts.IterRefine = Common.NOREFINE
x, F = SuperLUDIST.pgssvx!(A, b; options = opts)
```

The enum values (`Common.YES`, `Common.NO`, `Common.METIS_AT_PLUS_A`, …) are in
`SuperLUDIST.Common`. With `PrintStat = YES` (the default), statistics are printed after each solve,
and `SuperLUDIST.PStatPrint(F)` prints them again. `PStatPrint` is collective.

## Test problems

[`mmread_and_generatesolution`](@ref) reads a Matrix Market file and generates a known solution
and matching right-hand sides, as SuperLU_DIST's own example drivers do, and
[`inf_norm_error_dist`](@ref) prints the error of a computed solution. [`GenXtrue_dist!`](@ref)
and [`FillRHS_dist!`](@ref) are the underlying pieces.

```julia
coo, b, xtrue = SuperLUDIST.mmread_and_generatesolution(Float64, Int64, 1, "matrix.mtx", grid)
```

## Examples

The [`examples`](https://github.com/JuliaSparse/SuperLUDIST.jl/tree/main/examples) directory
has complete scripts:

```sh
mpiexecjl -n 4 julia --project examples/basic_example.jl
```

## Low-level interface

The complete SuperLU_DIST C API is available in the generated modules
`SuperLUDIST.SuperLU_Int32` and `SuperLUDIST.SuperLU_Int64`, with the shared enums in
`SuperLUDIST.Common`. They are generated with Clang.jl, see `gen/README.md` in the repository.
