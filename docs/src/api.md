# API

```@meta
CurrentModule = SuperLUDIST
```

## Matrices

```@docs
ReplicatedSuperMatrix
DistributedSuperMatrix
cscstore
coostore
```

## Solvers

```@docs
pgssvx!
LinearAlgebra.lu!(::SuperLUDIST.AbstractSuperMatrix)
SuperLUFactorization
isfactored
```

## Configuration

```@docs
Grid
Grid3D
AbstractGrid
Options
set_gpu!
HAVE_CUDA
set_libraries!
superlu_set_num_threads
```

## Test problems and diagnostics

```@docs
mmread_and_generatesolution
GenXtrue_dist!
FillRHS_dist!
inf_norm_error_dist
PStatPrint
```

## Everything else

This includes the constructors and the Matrix Market readers.

```@autodocs
Modules = [SuperLUDIST]
Filter = t -> !(t in (SuperLUDIST.ReplicatedSuperMatrix, SuperLUDIST.DistributedSuperMatrix,
                      SuperLUDIST.pgssvx!, SuperLUDIST.Grid, SuperLUDIST.Grid3D,
                      SuperLUDIST.AbstractGrid, SuperLUDIST.Options,
                      SuperLUDIST.set_gpu!, SuperLUDIST.HAVE_CUDA,
                      SuperLUDIST.set_libraries!, SuperLUDIST.superlu_set_num_threads,
                      SuperLUDIST.cscstore, SuperLUDIST.coostore,
                      SuperLUDIST.SuperLUFactorization, SuperLUDIST.isfactored,
                      SuperLUDIST.mmread_and_generatesolution, SuperLUDIST.GenXtrue_dist!,
                      SuperLUDIST.FillRHS_dist!, SuperLUDIST.inf_norm_error_dist,
                      SuperLUDIST.PStatPrint))
```
