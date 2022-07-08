#! /bin/bash julia --project generator.jl
using Pkg
using Pkg.Artifacts
using Clang.Generators
using Clang.Generators.JLLEnvs
using SuperLU_DIST_jll
using MPICH_jll

cd(@__DIR__)

# headers
SuperLU_DIST_toml = joinpath(dirname(pathof(SuperLU_DIST_jll)), "..", "Artifacts.toml")
SuperLU_DIST_dir = Pkg.Artifacts.ensure_artifact_installed("SuperLU_DIST", SuperLU_DIST_toml)

include_dir = joinpath(SuperLU_DIST_dir, "lib/superlu_dist/Int64/include/") |> normpath

superlu_ddefs_h = joinpath(include_dir, "superlu_ddefs.h") # Int64 vs Int32
@assert isfile(superlu_ddefs_h)
# Which other header files do we need?

options = load_options(joinpath(@__DIR__, "generator.toml"))
options["general"]["output_file_path"] = joinpath(@__DIR__, "..", "lib", "libsuperlu_dist.jl")
mpi_includedir = joinpath(MPICH_jll.find_artifact_dir(), "include") |> normpath
mpi_h = joinpath(mpi_includedir, "mpi.h")
args = get_default_args()
push!(args, "-isystem$mpi_includedir")

header_files = [superlu_ddefs_h, mpi_h]
ctx = create_context(header_files, args, options)

build!(ctx)
