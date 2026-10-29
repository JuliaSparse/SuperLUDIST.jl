# Installation

SuperLUDIST.jl is registered in the General registry:

```julia
pkg> add SuperLUDIST
```

You will normally also want `MPI`, `SparseArrays` and, to read Matrix Market files, `MatrixMarket`:

```julia
pkg> add MPI SparseArrays MatrixMarket
```

The default installation uses SuperLU_DIST 9.3.1 from `SuperLU_DIST_jll`, which is available on
Linux, macOS, FreeBSD and Windows, or its CUDA build from `SuperLU_DIST_CUDA_jll` on Linux machines
with NVIDIA GPUs (see [GPUs](@ref)).

## MPI

SuperLUDIST.jl uses whichever MPI library MPI.jl is configured for, and `SuperLU_DIST_jll`
automatically provides a build that matches it. By default this is the MPICH binary that comes
with MPI.jl (Microsoft MPI on Windows). To launch programs, install the `mpiexecjl` wrapper:

```julia
julia> using MPI; MPI.install_mpiexecjl()
```

It is installed in `~/.julia/bin`, which should be on your `PATH`. On a cluster you will usually
want the system MPI instead: configure it with
[MPIPreferences.jl](https://juliaparallel.org/MPI.jl/stable/configuration/) before loading
SuperLUDIST.jl.

## GPUs

SuperLUDIST.jl uses the CUDA build of SuperLU_DIST from `SuperLU_DIST_CUDA_jll` wherever it is
available, which needs:

- x86_64 Linux with an NVIDIA GPU and driver, for CUDA 12 or later, and
- MPI.jl configured with MPItrampoline, which can forward to MPICH or to your system MPI:

```julia
julia> using MPIPreferences; MPIPreferences.use_jll_binary("MPItrampoline_jll")
```

Everywhere else it uses the CPU build from `SuperLU_DIST_jll`. `SuperLUDIST.HAVE_CUDA` tells which
build is in use. The CUDA libraries are only downloaded where the CUDA build is used: about 25 MB
for SuperLU_DIST, and about 1 GB for the CUDA runtime from `CUDA_Runtime_jll`, which is shared with
CUDA.jl. To choose explicitly:

```julia
SuperLUDIST.set_gpu!(:none)   # always use the CPU build
SuperLUDIST.set_gpu!(:cuda)   # require the CUDA build
SuperLUDIST.set_gpu!(:auto)   # the default
```

The setting is stored with Preferences.jl and takes effect after restarting Julia. The build is
chosen when SuperLUDIST.jl is precompiled, so on a cluster precompile it on a node with a GPU.

With the CUDA build, both the 2D and the 3D drivers factorize and solve on the GPU. Set
`superlu_acc_offload = 0` in the [`Options`](@ref) to keep a factorization on the CPU. Some
environment variables control the GPU:

- `SUPERLU_BIND_MPI_GPU`: if set, rank `r` uses GPU `r % ngpus` on its node. Otherwise all ranks
  use the default GPU, so set it when several ranks share a node with several GPUs.
- `SUPERLU_MPI_PROCESS_PER_GPU`: ranks per GPU when binding (default 1).
- `GPU3DVERSION`: which GPU 3D factorization to use. The newer one (`1`) passes GPU memory to MPI,
  so with several ranks it needs a CUDA-aware MPI. SuperLUDIST.jl sets `GPU3DVERSION=0` when
  loaded unless MPI.jl reports CUDA support (`MPI.has_cuda()`) or the variable is already set. If
  your MPI is CUDA-aware but MPI.jl can't tell, set `JULIA_MPI_HAS_CUDA=true`.
- `SUPERLU_NUM_GPU_STREAMS`, `SUPERLU_MAX_BUFFER_SIZE` and `SUPERLU_N_GEMM` tune the GPU
  factorization; see the SuperLU_DIST documentation.

## Using your own SuperLU_DIST

If the `SuperLU_DIST_jll` binaries don't work on your machine (this has been the case on NERSC
Perlmutter, for example), you can use your own builds of SuperLU_DIST 9.3.x:

```julia
using SuperLUDIST
SuperLUDIST.set_libraries!(;
    libsuperlu_dist_Int32 = "/path/to/libsuperlu_dist_Int32.so",
    libsuperlu_dist_Int64 = "/path/to/libsuperlu_dist_Int64.so",
)
```

The libraries must be built with 32-bit and 64-bit `int_t` respectively (`XSDK_INDEX_SIZE`), and
linked against the same MPI that MPI.jl uses. They may be CUDA builds, in which case
SuperLUDIST.jl uses its CUDA bindings. You may provide just one of them, in which case
only that index type is available. The setting is stored with Preferences.jl and takes effect
after restarting Julia. Call `SuperLUDIST.set_libraries!()` with no arguments to go back to
the jll builds.

## Threads

SuperLU_DIST uses OpenMP within each rank. When several ranks share a node this easily
oversubscribes the cores, so set the number of threads per rank with the `OMP_NUM_THREADS`
environment variable, or from Julia:

```julia
SuperLUDIST.superlu_set_num_threads(Int64, 1)
```
