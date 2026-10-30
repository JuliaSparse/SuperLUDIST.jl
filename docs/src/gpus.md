```@meta
CurrentModule = SuperLUDIST
```

# GPUs

On x86\_64 Linux with an NVIDIA GPU, SuperLUDIST.jl can use the CUDA build of SuperLU\_DIST.
Both the 2D and the 3D drivers then factorize and solve on the GPU, with the same code as on the
CPU.

## Setup

The CUDA build of SuperLU\_DIST is in a separate package, `SuperLU_DIST_CUDA_jll`, which is not
installed with SuperLUDIST.jl, since it brings in the CUDA runtime (about 2.5 GB on disk). It
needs:

- x86_64 Linux with an NVIDIA GPU and driver, for CUDA 12 or later, and
- MPI.jl configured with MPItrampoline, which can forward to MPICH or to your system MPI.

To use it, add it to your environment, tell SuperLUDIST.jl to use it, and then switch MPI.jl
to MPItrampoline, in that order, restarting Julia after each step:

```julia
pkg> add SuperLUDIST SuperLU_DIST_CUDA_jll MPI MPIPreferences SparseArrays SparseBase

julia> using SuperLUDIST; SuperLUDIST.set_gpu!(:cuda)

julia> using MPIPreferences; MPIPreferences.use_jll_binary("MPItrampoline_jll")
```

After that, [`HAVE_CUDA`](@ref) is `true`. (Switching MPI first also works, but then run
`Pkg.instantiate()` before loading SuperLUDIST.jl, to download the CPU build for MPItrampoline.)
`SuperLUDIST.set_gpu!(:none)` goes back to the CPU build; if MPI.jl still uses MPItrampoline,
run `Pkg.instantiate()` after it, for the same reason. The setting is stored with
Preferences.jl, takes effect after restarting Julia, and is read when SuperLUDIST.jl is
precompiled. See [`set_gpu!`](@ref) for all its values.

Installing `SuperLU_DIST_CUDA_jll` downloads the CUDA runtime on machines with an NVIDIA driver,
and only `CUDA_Driver_jll` (about 450 MB on disk) on machines without one. If SuperLUDIST.jl is
set up for the CUDA build where it can't be used, for example on a cluster node without a GPU,
it reports an error when loaded that says what to do, and calls into SuperLU\_DIST fail.

Your own CUDA builds of SuperLU\_DIST can also be used, with [`set_libraries!`](@ref) (see
[Using your own SuperLU\_DIST](@ref)).

## Example

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

Without the CUDA build, the same script runs on the CPU.

## Settings

Set `superlu_acc_offload = 0` in the [`Options`](@ref) to keep a factorization on the CPU with
the CUDA build. Some environment variables control the GPU:

- `SUPERLU_BIND_MPI_GPU`: if set, rank `r` uses GPU `r % ngpus` on its node. Otherwise all ranks
  use the default GPU, so set it when several ranks share a node with several GPUs.
- `SUPERLU_MPI_PROCESS_PER_GPU`: ranks per GPU when binding (default 1).
- `GPU3DVERSION`: which GPU 3D factorization to use. The newer one (`1`) passes GPU memory to MPI,
  so with several ranks it needs a CUDA-aware MPI. SuperLUDIST.jl sets `GPU3DVERSION=0` when
  loaded unless MPI.jl reports CUDA support (`MPI.has_cuda()`) or the variable is already set. If
  your MPI is CUDA-aware but MPI.jl can't tell, set `JULIA_MPI_HAS_CUDA=true`.
- `SUPERLU_NUM_GPU_STREAMS`, `SUPERLU_MAX_BUFFER_SIZE` and `SUPERLU_N_GEMM` tune the GPU
  factorization; see the SuperLU\_DIST documentation.

## Limitations

- Only CUDA is supported, on x86_64 Linux, and MPI.jl must use MPItrampoline.
- CI tests only the CPU build. See [Development](@ref) for how to test the CUDA build.
