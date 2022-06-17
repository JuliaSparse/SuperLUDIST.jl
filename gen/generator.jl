#! /bin/bash julia --project generator.jl
using Pkg
using Pkg.Artifacts
using Clang.Generators
using Clang.Generators.JLLEnvs
using SuperLU_DIST_jll

cd(@__DIR__)

# headers
SuperLU_DIST_toml = joinpath(dirname(pathof(SuperLU_DIST_jll)), "..", "StdlibArtifacts.toml")
SuperLU_DIST_dir = Pkg.Artifacts.ensure_artifact_installed("SuperLU_DIST", SuperLU_DIST_toml)

include_dir = joinpath(SuperLU_DIST_dir, "include") |> normpath

superlu_ddefs_h = joinpath(include_dir, "superlu_ddefs.h") # Int64 vs Int32
@assert isfile(superlu_ddefs_h)
# Which other header files do we need?

options = load_options(joinpath(@__DIR__, "generator.toml"))

for target in JLLEnvs.JLL_ENV_TRIPLES
    @info "processing $target"

    options["general"]["output_file_path"] = joinpath(@__DIR__, "..", "lib", "$target.jl")

    args = get_default_args(target)
    push!(args, "-I$include_dir")
    if startswith(target, "x86_64") || startswith(target, "powerpc64le") || startswith(target, "aarch64")
        #Do we need any compiler flags?
        #push!(args, "-DSUN64 -DLONGBLAS='long long' -D'SuiteSparse_long_max=9223372036854775801'")
    end

    header_files = [superlu_ddefs_h]

    ctx = create_context(header_files, args, options)

    build!(ctx)
end