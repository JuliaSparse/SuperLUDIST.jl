# The SuperLU_DIST builds that get their own bindings, shared by generate.jl and
# check_layout.jl.
#
# - `:cpu` is `SuperLU_DIST_jll`.
# - `:cuda` is `SuperLU_DIST_CUDA_jll`, built with `HAVE_CUDA`, which adds device pointers
#   to several structs (e.g. `dScalePermstruct_t`, `dSOLVEstruct_t`), so its layouts differ.
#
# The CUDA build's headers are the same for every CUDA version, so take them from one
# artifact picked with an explicit platform: the jll only selects an artifact on a machine
# with a GPU and MPItrampoline.
using Artifacts: artifact_meta, artifact_path
using Base.BinaryPlatforms: Platform
using Pkg.Artifacts: ensure_artifact_installed
using SuperLU_DIST_CUDA_jll
using SuperLU_DIST_jll

const BUILDS = (:cpu, :cuda)
const LIB_DIR = normpath(joinpath(@__DIR__, "..", "lib"))

# Stand-ins for the GPU headers that `superlu_defs.h` includes under `GPU_ACC`. They only
# declare GPU helpers that need the CUDA SDK headers; no struct we wrap uses them.
const STUB_INCLUDE_DIR = joinpath(@__DIR__, "cuda_stubs")

function include_dir(build)
    build === :cpu && return normpath(joinpath(SuperLU_DIST_jll.artifact_dir, "include"))
    toml = joinpath(pkgdir(SuperLU_DIST_CUDA_jll), "Artifacts.toml")
    platform = Platform("x86_64", "linux"; libc = "glibc", cuda = "12.0", mpi = "mpitrampoline")
    meta = artifact_meta("SuperLU_DIST_CUDA", toml; platform)
    meta === nothing && error("SuperLU_DIST_CUDA_jll has no artifact for $platform")
    hash = Base.SHA1(meta["git-tree-sha1"])
    ensure_artifact_installed("SuperLU_DIST_CUDA", meta, toml)
    return normpath(joinpath(artifact_path(hash), "include"))
end

# `-I` flags that put the stubs ahead of the CUDA build's own GPU headers.
extra_include_args(build) = build === :cuda ? ["-I$STUB_INCLUDE_DIR"] : String[]

binding_file(build, width) =
    build === :cpu ? "libsuperlu_dist$width.jl" : "libsuperlu_dist_$(build)$width.jl"
