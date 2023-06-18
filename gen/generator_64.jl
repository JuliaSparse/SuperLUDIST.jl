#! /bin/bash julia --project generator.jl
using Pkg
using Pkg.Artifacts
using Clang.Generators
using Clang.Generators.JLLEnvs
using SuperLUDIST_jll
using MPICH_jll

cd(@__DIR__)

# headers
SuperLUDIST_toml = joinpath(dirname(pathof(SuperLUDIST_jll)), "..", "Artifacts.toml")
SuperLUDIST_dir = Pkg.Artifacts.ensure_artifact_installed("SuperLUDIST", SuperLUDIST_toml)

include_dir = joinpath(SuperLUDIST_dir, "include") |> normpath

superlu_defs_h = joinpath(include_dir, "superlu_defs.h")
superlu_ddefs_h = joinpath(include_dir, "superlu_ddefs.h")
superlu_sdefs_h = joinpath(include_dir, "superlu_sdefs.h")
superlu_zdefs_h = joinpath(include_dir, "superlu_zdefs.h")
@assert isfile(superlu_defs_h)

options = load_options(joinpath(@__DIR__, "generator_64.toml"))
options["general"]["output_file_path"] = joinpath(@__DIR__, "..", "lib", "libsuperlu_dist64.jl")
mpi_header_dir = joinpath(MPICH_jll.find_artifact_dir(), "include") |> normpath
isdir(mpi_header_dir) || error("$mpi_header_dir does not exist")
args = get_default_args()
push!(args, "-isystem$mpi_header_dir")

header_files = [superlu_ddefs_h, superlu_defs_h, superlu_sdefs_h, superlu_zdefs_h]

@add_def MPI_Comm
@add_def MPI_Request
@add_def MPI_Datatype
@add_def MPI_Errhandler
ctx = create_context(header_files, args, options)

build!(ctx)
