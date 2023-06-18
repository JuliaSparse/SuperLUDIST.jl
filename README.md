# SuperLU_DIST.jl

SuperLU_DIST.jl is Julia wrapper around the [superlu_dist](https://github.com/xiaoyeli/superlu_dist) distributed sparse factorization library. superlu_dist contains a set of subroutines to solve a sparse linear system A*X=B.

SuperLU_DIST is a parallel extension to the serial SuperLU library. It is targeted for the distributed memory parallel machines. SuperLU_DIST is implemented in ANSI C, with OpenMP for on-node parallelism and MPI for off-node communications. We are actively developing GPU acceleration capabilities.

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://aa25desh.github.io/SuperLU_DIST.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://aa25desh.github.io/SuperLU_DIST.jl/dev/)
[![Build Status](https://github.com/aa25desh/SuperLU_DIST.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/aa25desh/SuperLU_DIST.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/aa25desh/SuperLU_DIST.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/aa25desh/SuperLU_DIST.jl)


## Installation
To install SuperLU_DIST.jl on your local machine:
```julia
]add https://github.com/Wimmerer/SuperLU_DIST.jl
```
SuperLU_DIST.jl requires Julia version 1.8 or greater.

Examples for running in replicated and distributed mode are provided in the examples directory. To run these examples
follow the instructions provided [here](https://juliaparallel.org/MPI.jl/latest/configuration/) to set up your MPI correctly.

Then you can invoke a driver example:
```
mpiexecjl -n <nprocs> julia --project examples/pdrive.jl
```

## Known Issues
- CUDA support is currently disabled.
- LBT is not yet a dependency, so the library uses OpenBLAS32_jll for now.
- OpenBLAS32_jll has a known issue with threading. Currently being investigated.

## About the project
This is summer a project at the [Berkeley National Lab](https://www.lbl.gov) with scalable solvers group Led by [Dr. Xiaoye Sherry Li](https://crd.lbl.gov/divisions/amcr/applied-mathematics-dept/scalable-solvers/members/staff-members/xiaoye-li/).