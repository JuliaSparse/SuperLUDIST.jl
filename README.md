# SuperLUDIST.jl

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliasparse.github.io/SuperLUDIST.jl/dev/)
[![CI](https://github.com/JuliaSparse/SuperLUDIST.jl/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/JuliaSparse/SuperLUDIST.jl/actions/workflows/ci.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/JuliaSparse/SuperLUDIST.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/JuliaSparse/SuperLUDIST.jl)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

SuperLUDIST.jl is a Julia interface to [SuperLU_DIST](https://github.com/xiaoyeli/superlu_dist),
the distributed-memory sparse direct solver from Lawrence Berkeley National Laboratory.
SuperLU_DIST solves sparse linear systems `A*X = B` with an LU factorization, using MPI between
ranks and OpenMP within each rank. See the
[SuperLU_DIST documentation](https://portal.nersc.gov/project/sparse/superlu/) for details of the
underlying library.

SuperLUDIST.jl uses SuperLU_DIST 9.3.1 from `SuperLU_DIST_jll`, or its optional CUDA build from
`SuperLU_DIST_CUDA_jll` for Linux machines with NVIDIA GPUs (see [GPUs (CUDA)](#gpus-cuda)), and
supports `Float32`, `Float64` and `ComplexF64` matrices with either `Int32` or `Int64` indices.
Matrices can be replicated on every rank or distributed by rows, distributed matrices can also use
SuperLU_DIST's communication-avoiding 3D factorization on a 3D process grid, and factorizations can
be reused for further right-hand sides.

## Installation

SuperLUDIST.jl is in the General registry. Press `]` in the Julia REPL to enter Pkg mode, then run:

```julia
pkg> add SuperLUDIST MPI SparseArrays
```

or, equivalently:

```julia
julia> import Pkg; Pkg.add(["SuperLUDIST", "MPI", "SparseArrays"])
```

To launch MPI programs, install `mpiexecjl` (into `~/.julia/bin`, which should be on your `PATH`):

```julia
julia> using MPI; MPI.install_mpiexecjl()
```

On HPC clusters you will usually want your system MPI, see the
[MPI.jl configuration docs](https://juliaparallel.org/MPI.jl/stable/configuration/). If the
`SuperLU_DIST_jll` binaries don't work on your machine (this has been the case on NERSC
Perlmutter), you can use your own SuperLU_DIST 9.3.x libraries, built with 32-bit and 64-bit
indices and linked against the MPI used by MPI.jl:

```julia
SuperLUDIST.set_libraries!(;
    libsuperlu_dist_Int32 = "/path/to/libsuperlu_dist_Int32.so",
    libsuperlu_dist_Int64 = "/path/to/libsuperlu_dist_Int64.so",
)
```

Either library may be omitted, in which case matrices with that index type are unavailable.
Restart Julia for the change to take effect.

## Quick start

Save this as `solve.jl`:

```julia
using MPI, SuperLUDIST, SparseArrays, LinearAlgebra
using SuperLUDIST: Grid, Options, pgssvx!

MPI.Init()
grid = Grid{Int32}(1, MPI.Comm_size(MPI.COMM_WORLD))   # a 1 × nranks process grid

n = 100
S = spdiagm(-1 => fill(-1.0, n - 1), 0 => fill(4.0, n), 1 => fill(-1.0, n - 1))
b = S * ones(n)

A = ReplicatedSuperMatrix(S, grid)    # every rank holds the same matrix
options = Options{Int32}(; PrintStat = SuperLUDIST.Common.NO)
x, F = pgssvx!(A, copy(b); options)   # factorize and solve
y = F \ (2b)                          # reuse the factorization

if MPI.Comm_rank(MPI.COMM_WORLD) == 0
    println(F)
    println(x ≈ ones(n) && y ≈ 2ones(n))
end
MPI.Finalize()

# output

SuperLUFactorization{Float64, Int32}(100×100 ReplicatedSuperMatrix{Float64, Int32})
true
```

The output is from a single rank. The tests run the README's code blocks that have an
`# output` section as doctests. Run it on 4 ranks with:

```sh
mpiexecjl -n 4 julia --project solve.jl
```

For large problems, use a `DistributedSuperMatrix`, where each rank holds only a block of rows of
the matrix and right-hand side. The [`examples`](examples) directory has complete scripts for both
kinds of matrices, for example:

```sh
mpiexecjl -n 4 julia --project examples/basic_example.jl
```

This launches 4 MPI ranks running `examples/basic_example.jl`, which reads a Matrix Market file on
the root rank, distributes it over a 2×2 process grid, then factorizes and solves. `--project`
activates the environment in the current directory; omit it, or point it elsewhere (e.g.
`--project=~/MySuperLUProject`), depending on where SuperLUDIST.jl is installed.

For the 3D factorization, `examples/pdrive3d.jl` solves the same kind of problem on a
`Grid3D`, for example on 8 ranks in 2 layers of 2×2 grids:

```sh
mpiexecjl -n 8 julia --project examples/pdrive3d.jl 2
```

See the [documentation](https://juliasparse.github.io/SuperLUDIST.jl/dev/) for more.

## GPUs (CUDA)

On x86_64 Linux with an NVIDIA GPU, SuperLUDIST.jl can use the CUDA build of SuperLU_DIST, and
both the 2D and the 3D drivers then factorize and solve on the GPU. The CUDA build is in a
separate package, `SuperLU_DIST_CUDA_jll`, which is not installed with SuperLUDIST.jl since it
brings in the CUDA runtime (about 2.5 GB on disk). It needs MPI.jl to use MPItrampoline. Set
this up once in your project:

```sh
julia --project -e 'import Pkg; Pkg.add(["SuperLUDIST", "SuperLU_DIST_CUDA_jll", "MPI", "MPIPreferences", "SparseArrays", "SparseBase"])'
julia --project -e 'using SuperLUDIST; SuperLUDIST.set_gpu!(:cuda)'
julia --project -e 'using MPIPreferences; MPIPreferences.use_jll_binary("MPItrampoline_jll")'
julia --project -e 'using SuperLUDIST; println(SuperLUDIST.HAVE_CUDA)'   # true
```

Without `SuperLU_DIST_CUDA_jll`, SuperLUDIST.jl uses the CPU build from `SuperLU_DIST_jll`, and
the same code runs on the CPU.

Save this as `gpu_solve.jl`. It solves a 3D Laplacian on a 3D process grid with one rank per
2D layer:

```julia
using MPI, SuperLUDIST, SparseArrays, SparseBase, LinearAlgebra
using SparseBase.Communication: distribute_evenly, localsize, scatterstore!
using SuperLUDIST: Grid3D, DistributedSuperMatrix, Options

MPI.Init()
comm = MPI.COMM_WORLD
nprocs = MPI.Comm_size(comm)
grid = Grid3D{Int64}(1, 1, nprocs, comm)   # nprocs 2D layers of one rank each
root = 0
isroot = grid.iam == root

# A 3D Laplacian with k^3 unknowns, and a right-hand side for the solution ones(n).
k = 40
T = spdiagm(-1 => fill(-1.0, k - 1), 0 => fill(2.0, k), 1 => fill(-1.0, k - 1))
Id = sparse(1.0I, k, k)
S = kron(T, Id, Id) + kron(Id, T, Id) + kron(Id, Id, T)
n = size(S, 1)
b = S * ones(n, 1)

# Distribute the rows of S from the root over all ranks.
csr = isroot ? convert(SparseBase.CSRStore, SuperLUDIST.coostore(Float64, Int64, S)) : nothing
chunks = isroot ? distribute_evenly(n, nprocs) : nothing
A = scatterstore!(DistributedSuperMatrix{Float64, Int64}(grid), csr, chunks; root)
rows = A.first_row:(A.first_row + localsize(A, 1) - 1)

options = Options{Int64}(; PrintStat = SuperLUDIST.Common.NO, IterRefine = SuperLUDIST.Common.NOREFINE)
F = lu!(A, b[rows, :]; options)     # factorize, on the GPU with the CUDA build
x = F \ b[rows, :]                  # solve again with the factorization
err = MPI.Allreduce(maximum(abs, x .- 1), max, comm)
isroot && println("HAVE_CUDA = $(SuperLUDIST.HAVE_CUDA), max error = $err")
```

and run it on, for example, 2 ranks (a power of two, since `npdep` must be one):

```sh
SUPERLU_BIND_MPI_GPU=1 OMP_NUM_THREADS=1 mpiexecjl --project -n 2 julia gpu_solve.jl
```

`SUPERLU_BIND_MPI_GPU=1` spreads the ranks of a node over its GPUs; without it every rank uses
the first GPU. A few more things to know:

- Call `set_gpu!(:cuda)` before switching MPI.jl to MPItrampoline, as above, or run
  `Pkg.instantiate()` after switching. `SuperLUDIST.set_gpu!(:none)` goes back to the CPU
  build (run `Pkg.instantiate()` after it if MPI.jl still uses MPItrampoline); restart Julia
  after changing it. If SuperLUDIST.jl is set up for the CUDA build where it
  can't be used, such as a node without a GPU, it reports an error when loaded that says what
  to do, and calls into SuperLU_DIST fail.
- With several ranks, SuperLU_DIST's newer GPU 3D factorization needs a CUDA-aware MPI. Unless
  MPI.jl reports one (`MPI.has_cuda()`, or `JULIA_MPI_HAS_CUDA=true`), SuperLUDIST.jl selects
  the earlier GPU 3D factorization by setting `GPU3DVERSION=0`, which works with any MPI. Set
  `GPU3DVERSION` yourself to override this.
- Set `superlu_acc_offload = 0` in the `Options` to factorize on the CPU with the CUDA build.

See [GPUs](https://juliasparse.github.io/SuperLUDIST.jl/dev/gpus/) in the
documentation for all the settings.

## Known issues

- GPU acceleration is CUDA only, on x86_64 Linux, needs MPI.jl to use MPItrampoline, and needs
  `SuperLU_DIST_CUDA_jll` to be added separately.
- OpenMP will often oversubscribe single-node setups. Set `OMP_NUM_THREADS`, or call
  `SuperLUDIST.superlu_set_num_threads(Int64, n)` (or `Int32`), to choose the number of threads
  per rank.
- Because of a bug in SuperLU_DIST ([xiaoyeli/superlu_dist#238](https://github.com/xiaoyeli/superlu_dist/issues/238)),
  `Float32` solves of a `ReplicatedSuperMatrix` on more than one rank are done without
  equilibration (`Equil = NO`). Use a `DistributedSuperMatrix` if you need it.
- Some output ignores `PrintStat = NO`. The 3D drivers print each iterative refinement step on
  rank 0 (set `IterRefine = NOREFINE` to turn that off), and reading or scattering a
  `DistributedSuperMatrix` prints its row partition (`part = ...`, from SparseBase).

## Development

Run the tests with `Pkg.test("SuperLUDIST")`. They launch MPI jobs on 1 and 4 ranks, and show a
job's output only if it fails. The
low-level bindings in `lib/` are generated from the `SuperLU_DIST_jll` and `SuperLU_DIST_CUDA_jll`
headers with Clang.jl;
see [`gen/README.md`](gen/README.md) for how to regenerate and check them, and the
[Development](https://juliasparse.github.io/SuperLUDIST.jl/dev/development/) docs for testing and
coverage.

## About the project

SuperLUDIST.jl began as a summer project at [Lawrence Berkeley National Lab](https://www.lbl.gov)
with the [Scalable Solvers Group](https://crd.lbl.gov/departments/applied-mathematics/scalable-solvers/)
led by Dr. Xiaoye Sherry Li (@xiaoyeli),
by Aadesh Deshmukh (@aa25desh) and Raye Kimmerer (@rayegun). It is now maintained by
[JuliaSparse](https://github.com/JuliaSparse).

SuperLU_DIST is distributed under a BSD license, see [LICENSE](LICENSE).
