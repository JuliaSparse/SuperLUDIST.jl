# SuperLU_DIST.jl

SuperLU_DIST.jl is Julia wrapper around the [superlu_dist](https://github.com/xiaoyeli/superlu_dist). superlu_dist contains a set of subroutines to solve a sparse linear system A*X=B. It uses Gaussian elimination with static pivoting (GESP). Static pivoting is a technique that combines the numerical stability of partial pivoting with the scalability of Cholesky (no pivoting), to run accurately and efficiently on large numbers of processors.

SuperLU_DIST is a parallel extension to the serial SuperLU library. It is targeted for the distributed memory parallel machines. SuperLU_DIST is implemented in ANSI C, with OpenMP for on-node parallelism and MPI for off-node communications. We are actively developing GPU acceleration capabilities.

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://aa25desh.github.io/SuperLU_DIST.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://aa25desh.github.io/SuperLU_DIST.jl/dev/)
[![Build Status](https://github.com/aa25desh/SuperLU_DIST.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/aa25desh/SuperLU_DIST.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/aa25desh/SuperLU_DIST.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/aa25desh/SuperLU_DIST.jl)


## Installation
To install SuperLU_DIST.jl on Cori:
```julia
salloc --exclusive  --nodes 1 --qos interactive --time 00:20:00 --constraint haswell

module swap PrgEnv-intel/6.0.10 PrgEnv-gnu
module load cmake/3.22.1
module load gcc
module load julia

julia

]add Clang
]dev https://github.com/JuliaBinaryWrappers/LLVMOpenMP_jll.jl.git
]dev https://github.com/JuliaBinaryWrappers/SuperLU_DIST_jll.jl.git

]dev https://github.com/aa25desh/SuperLU_DIST.jl.git
```
SuperLU_DIST.jl requires Julia version 1.7 or greater.

## Quickstart 
```julia
using SuperLU_DIST
const LSLU = SuperLU_DIST.Libsuperlu_dist

# use any function from superlu_dist

LUstruct = LSLU.dLUstruct_t()
```

## How contribute
* If you are interested, please raise an issue or get in touch with me on Julia slack. 

## About the project
This is summer a project at the [Berkeley National Lab](https://www.lbl.gov) with scalable solvers group Led by [Dr. Xiaoye Sherry Li](https://crd.lbl.gov/divisions/amcr/applied-mathematics-dept/scalable-solvers/members/staff-members/xiaoye-li/).

Active maintainers: 
* [Aadesh Deshmukh](https://github.com/aa25desh)
