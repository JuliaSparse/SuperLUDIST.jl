# Development

## Running the tests

```julia
julia> using Pkg; Pkg.test("SuperLUDIST")
```

The solvers need an MPI job, so `test/runtests.jl` runs `test/mpi_solve.jl` under `mpiexec`
on 1 rank (a 1×1 grid) and on 4 ranks (a 2×2 grid), with `OMP_NUM_THREADS=1`. It covers
every element type (`Float32`, `Float64`, `ComplexF64`) and index type (`Int32`, `Int64`),
replicated and distributed matrices, 3D process grids (1×1×1 on 1 rank; 1×2×2, 2×1×2 and
1×1×4 on 4 ranks), reusing factorizations with different numbers of right-hand sides, the
Matrix Market readers and the test problem helpers. The script can
also be run directly:

```sh
mpiexecjl -n 4 julia --project=test test/mpi_solve.jl
```

The tests call `GC.gc()` after the replicated solves, which catches writes past the end of
Julia-owned buffers. This is how
[xiaoyeli/superlu_dist#237](https://github.com/xiaoyeli/superlu_dist/issues/237) was found.
When debugging memory problems, also run them with forced garbage collection and with glibc's
`MALLOC_CHECK_=3`.

[Aqua.jl](https://github.com/JuliaTesting/Aqua.jl) checks (method ambiguities, stale
dependencies, compat bounds, piracy, …) run in their own CI workflow, `.github/workflows/Aqua.yml`.

## Coverage

CI uploads coverage of `src/` and `ext/` to [Codecov](https://codecov.io/gh/JuliaSparse/SuperLUDIST.jl).
The generated bindings in `lib/` and the generator in `gen/` are excluded (see `codecov.yml`).
The coverage of the MPI runs is collected too, since `mpiexec` launches Julia with the flags of
the test process (`Base.julia_cmd()`). To measure it locally:

```julia
julia> using Pkg; Pkg.test("SuperLUDIST"; coverage = true)

julia> using CoverageTools
julia> cov = vcat(process_folder("src"), process_folder("ext"));
julia> covered, total = get_summary(cov)
```

## Regenerating the bindings

The low-level bindings in `lib/` are generated from the `SuperLU_DIST_jll` headers with
Clang.jl, and are not edited by hand:

```sh
julia --project=gen -e 'using Pkg; Pkg.instantiate()'
julia --project=gen gen/generate.jl
julia --project=gen gen/check_layout.jl   # compare the struct layouts against C
```

See `gen/README.md` for details.
