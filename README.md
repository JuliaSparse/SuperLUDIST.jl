# SuperLUDIST.jl

SuperLUDIST.jl is Julia wrapper around the [superlu_dist](https://github.com/xiaoyeli/superlu_dist) distributed sparse factorization library. superlu_dist contains a set of subroutines to solve a sparse linear system A*X=B.

SuperLUDIST is a parallel extension to the serial SuperLU library. It is targeted for the distributed memory parallel machines. SuperLUDIST is implemented in ANSI C, with OpenMP for on-node parallelism and MPI for off-node communications. We are actively developing GPU acceleration capabilities.

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://aa25desh.github.io/SuperLUDIST.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://aa25desh.github.io/SuperLUDIST.jl/dev/)
[![Build Status](https://github.com/aa25desh/SuperLUDIST.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/aa25desh/SuperLUDIST.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/aa25desh/SuperLUDIST.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/aa25desh/SuperLUDIST.jl)


## Installation
`SuperLUDIST.jl` is available in the General registry through Julia's package manager. 
Enter the Pkg REPL mode by typing `]` in the Julia REPL and then run:
```julia
pkg> add SuperLUDIST
```

or equivalently via the `Pkg.jl` API:
```julia
julia> import Pkg; Pkg.add("SuperLUDIST")
```

Proper use of `SuperLUDIST.jl` will typically also require `MPI.jl`, `SparseBase.jl` and possibly `MatrixMarket.jl`. These can be installed from the Pkg REPL mode:
```julia
pkg> add MPI SparseBase MatrixMarket
```

## Usage
Examples for running in replicated and distributed mode are provided in the examples directory. To run these examples
follow the instructions provided [here](https://juliaparallel.org/MPI.jl/latest/configuration/) to set up your MPI correctly. In particular `mpiexecjl` should be in your path (it is typically found in `~/.julia/bin`)

Then you can invoke a driver example:
```
mpiexecjl -n <nprocs> julia --project examples/pdrive.jl
```

This command does a couple things. The first part launches MPI with `<nprocs>` ranks. The second part `julia --project` activates the current folder. If your installation is in the global environment you may omit `--project`, or provide a path to the environment you would like to use: `--project=~/MySuperLUProject`. Finally `examples/pdrive.jl` is the Julia script to be executed under MPI. 

Driver routine examples are found in the `examples` folder of this repository. The examples currently cover basic usage of `pgssvx` and `pgssvx_ABglobal` driver routines. These routines load matrix market files and generate right hand sides, which is not a typical use-case. Instead users will often build a submatrix on each rank, and construct a `DistributedSuperMatrix`.

More examples will be added over the coming days to illustrate:
- DistributedSuperMatrix and ReplicatedSuperMatrix construction.
- Re-using LU factorizations.
- Use of the computational routines.
- 3D distribution routines.
- Extensions for `SparseMatricesCSR.jl`, `LinearSolve.jl`, `PartitionedArrays.jl` and several other packages.

## Known Issues
- CUDA support is currently disabled.
- OpenMP will often oversubscribe single node setups. In this case you should use `SuperLUDIST.superlu_set_num_threads(Int32, <num>)` or `SuperLUDIST.superlu_set_num_threads(Int64, <num>)` to the number of OpenMP threads desired on each rank.

## About the project
This is summer a project at [Lawrence Berkeley National Lab](https://www.lbl.gov) with scalable solvers group Led by [Dr. Xiaoye Sherry Li](https://crd.lbl.gov/divisions/amcr/applied-mathematics-dept/scalable-solvers/members/staff-members/xiaoye-li/).
