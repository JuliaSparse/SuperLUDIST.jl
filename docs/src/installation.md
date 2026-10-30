# Installation

SuperLUDIST.jl is registered in the General registry:

```julia
pkg> add SuperLUDIST
```

You will normally also want `MPI`, `SparseArrays` and, to read Matrix Market files, `MatrixMarket`:

```julia
pkg> add MPI SparseArrays MatrixMarket
```

The default installation uses SuperLU\_DIST 9.3.1 from `SuperLU_DIST_jll`, which is available on
Linux, macOS, FreeBSD and Windows. A CUDA build for x86\_64 Linux machines with NVIDIA GPUs can be
added separately, see [GPUs](@ref).

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

## Using your own SuperLU_DIST

If the `SuperLU_DIST_jll` binaries don't work on your machine (this has been the case on NERSC
Perlmutter, for example), you can use your own builds of SuperLU\_DIST 9.3.x:

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

SuperLU\_DIST uses OpenMP within each rank. When several ranks share a node this easily
oversubscribes the cores, so set the number of threads per rank with the `OMP_NUM_THREADS`
environment variable, or from Julia:

```julia
SuperLUDIST.superlu_set_num_threads(Int64, 1)
```
