#! /bin/bash julia --project generator.jl
using Pkg
using Pkg.Artifacts
using Clang.Generators
using Clang.Generators.JLLEnvs
using SuperLU_DIST_jll
using MPItrampoline_jll

cd(@__DIR__)

# headers
SuperLU_DIST_toml = joinpath(dirname(pathof(SuperLU_DIST_jll)), "..", "Artifacts.toml")
SuperLU_DIST_dir = Pkg.Artifacts.ensure_artifact_installed("SuperLU_DIST", SuperLU_DIST_toml)

include_dir = joinpath(SuperLU_DIST_dir, "lib", "superlu_dist", "Int64", "include") |> normpath

superlu_defs_h = joinpath(include_dir, "superlu_defs.h")
superlu_ddefs_h = joinpath(include_dir, "superlu_ddefs.h")
superlu_sdefs_h = joinpath(include_dir, "superlu_sdefs.h")
@assert isfile(superlu_defs_h)
# Which other header files do we need?

options = load_options(joinpath(@__DIR__, "generator_64.toml"))
options["general"]["output_file_path"] = joinpath(@__DIR__, "..", "lib", "libsuperlu_dist64.jl")
mpi_header_dir = "/home/wimmerer/spack/opt/spack/linux-ubuntu18.04-skylake_avx512/gcc-7.5.0/mpich-4.0.2-36qps5tgaihwsia73hcokarfa6b7trwa/include"
isdir(mpi_header_dir) || error("$mpi_header_dir does not exist")
mpi_h = joinpath(mpi_header_dir, "mpi.h")
args = get_default_args()
push!(args, "-isystem$mpi_header_dir")

header_files = [superlu_ddefs_h, superlu_defs_h, superlu_sdefs_h]

@add_def MPI_Comm
@add_def MPI_Request
@add_def MPI_Datatype
@add_def MPI_Errhandler
ctx = create_context(header_files, args, options)

build!(ctx)
