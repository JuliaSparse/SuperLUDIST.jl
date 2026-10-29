# Generating the bindings

The files in `lib/` are generated with [Clang.jl](https://github.com/JuliaInterop/Clang.jl)
from the headers shipped with `SuperLU_DIST_jll` and `SuperLU_DIST_CUDA_jll`. Do not edit them
by hand: put any customization in `generator.toml`, `prologue.jl` or `generate.jl`.

```sh
julia --project=gen -e 'using Pkg; Pkg.instantiate()'
julia --project=gen gen/generate.jl      # regenerate lib/*.jl
julia --project=gen gen/check_layout.jl  # compare every struct's size with C (needs `cc`)
```

SuperLU_DIST is built twice by the jll, with 32-bit and with 64-bit `int_t`, and each build
installs a self-contained copy of its headers under `include/superlu_dist_Int32` and
`include/superlu_dist_Int64`. `generate.jl` produces:

- `lib/libsuperlu_dist32.jl` and `lib/libsuperlu_dist64.jl`: the modules `SuperLU_Int32`
  and `SuperLU_Int64` with all functions, structs and constants for each index width.
  Most struct layouts depend on `int_t`, so the structs are generated per width.
- `lib/common.jl`: the module `SuperLUDIST_Common` with the enums, which are identical
  for both widths (the generator checks this).

The CUDA build (`SuperLU_DIST_CUDA_jll`, built with `HAVE_CUDA`) adds device pointers to
several structs, such as `dScalePermstruct_t`, `dSOLVEstruct_t` and `SuperLUStat_t`, so it gets its
own `lib/libsuperlu_dist_cuda32.jl` and `lib/libsuperlu_dist_cuda64.jl`, with the same module names.
`src/SuperLUDIST.jl` includes the pair for the library it loads. Its headers include GPU headers
from the CUDA SDK, which `cuda_stubs/` stands in for, since the structs we wrap only use an opaque
event handle from them. See `builds.jl`.

When updating to a new SuperLU_DIST version, bump `SuperLU_DIST_jll` and
`SuperLU_DIST_CUDA_jll` here and in the top-level `Project.toml`, then run both scripts
above along with the test suite.
