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
```

## Configuration

```@docs
Grid
Options
set_libraries!
superlu_set_num_threads
```

## Everything else

This includes the constructors and the Matrix Market readers.

```@autodocs
Modules = [SuperLUDIST]
Filter = t -> !(t in (SuperLUDIST.ReplicatedSuperMatrix, SuperLUDIST.DistributedSuperMatrix,
                      SuperLUDIST.pgssvx!, SuperLUDIST.Grid, SuperLUDIST.Options,
                      SuperLUDIST.set_libraries!, SuperLUDIST.superlu_set_num_threads,
                      SuperLUDIST.cscstore, SuperLUDIST.coostore))
```
