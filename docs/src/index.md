```@meta
CurrentModule = SuperLUDIST
```

# SuperLUDIST.jl

SuperLUDIST.jl is a Julia interface to [SuperLU_DIST](https://github.com/xiaoyeli/superlu_dist),
the distributed-memory sparse direct solver from Lawrence Berkeley National Laboratory. It solves
sparse linear systems ``Ax = b`` with an LU factorization, using MPI between ranks and OpenMP
within each rank.

SuperLUDIST.jl uses SuperLU_DIST 9.3.1 from `SuperLU_DIST_jll`, or your own build of it, and
supports:

- element types `Float32`, `Float64` and `ComplexF64`,
- index types `Int32` and `Int64`, through two separate builds of SuperLU_DIST,
- matrices that are either replicated on every rank ([`ReplicatedSuperMatrix`](@ref), which uses
  the `pgssvx_ABglobal` drivers) or distributed by rows ([`DistributedSuperMatrix`](@ref), which
  uses the `pgssvx` drivers),
- SuperLU_DIST's communication-avoiding 3D factorization, for distributed matrices on a 3D
  process grid ([`Grid3D`](@ref), which uses the `pgssvx3d` drivers),
- factorizations that can be reused for further right-hand sides.

## Quick start

Save this as `solve.jl`:

```julia
using MPI, SuperLUDIST, SparseArrays, LinearAlgebra
using SuperLUDIST: Grid, Options, pgssvx!

MPI.Init()
nranks = MPI.Comm_size(MPI.COMM_WORLD)
grid = Grid{Int32}(1, nranks)          # a 1 × nranks process grid

n = 100
S = spdiagm(-1 => fill(-1.0, n - 1), 0 => fill(4.0, n), 1 => fill(-1.0, n - 1))
xtrue = ones(n)
b = S * xtrue

A = ReplicatedSuperMatrix(S, grid)     # every rank passes the same matrix
x, F = pgssvx!(A, copy(b); options = Options{Int32}(; PrintStat = SuperLUDIST.Common.NO))
y = F \ (2b)                           # reuse the factorization

MPI.Comm_rank(MPI.COMM_WORLD) == 0 && @show norm(x - xtrue) norm(y - 2xtrue)
MPI.Finalize()
```

Then run it on 4 ranks:

```sh
mpiexecjl -n 4 julia --project solve.jl
```

See [Installation](@ref) for setting up MPI and [Usage](@ref) for distributed matrices.
