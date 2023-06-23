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

For users that need additional help with installation see the documentation.

## Usage
Examples for running in replicated and distributed mode are provided in the examples directory. To run these examples
follow the instructions provided [here](https://juliaparallel.org/MPI.jl/latest/configuration/) to set up your MPI correctly.

Then you can invoke a driver example:
```
mpiexecjl -n <nprocs> julia --project examples/pdrive.jl
```

## Known Issues
- CUDA support is currently disabled.

## About the project
This is summer a project at [Lawrence Berkeley National Lab](https://www.lbl.gov) with scalable solvers group Led by [Dr. Xiaoye Sherry Li](https://crd.lbl.gov/divisions/amcr/applied-mathematics-dept/scalable-solvers/members/staff-members/xiaoye-li/).
