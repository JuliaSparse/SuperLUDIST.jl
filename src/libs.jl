using Libdl: dlopen, dlclose, dllist, dlpath, dlsym, RTLD_DEEPBIND, RTLD_LAZY
using Preferences

const _PREFERENCE_SLUINT32 = @load_preference("libsuperlu_dist_Int32", nothing)
const _PREFERENCE_SLUINT64 = @load_preference("libsuperlu_dist_Int64", nothing)
const _PREFERENCE_GPU = @load_preference("gpu", "auto")

_PREFERENCE_GPU in ("auto", "cuda", "none") ||
    error("SuperLUDIST: invalid `gpu` preference $(repr(_PREFERENCE_GPU)), see `SuperLUDIST.set_gpu!`.")

const flags = RTLD_DEEPBIND | RTLD_LAZY
const CUSTOM_LIBRARIES = _PREFERENCE_SLUINT32 !== nothing || _PREFERENCE_SLUINT64 !== nothing
if CUSTOM_LIBRARIES
    const libsuperlu_dist_Int32 = _PREFERENCE_SLUINT32
    const libsuperlu_dist_Int64 = _PREFERENCE_SLUINT64
    # Only the CUDA build exports `nv_init_wrapper`.
    const HAVE_CUDA = any((libsuperlu_dist_Int32, libsuperlu_dist_Int64)) do lib
        lib === nothing && return false
        dlsym(dlopen(lib, flags; throw_error=true), :nv_init_wrapper; throw_error=false) !== nothing
    end
elseif _PREFERENCE_GPU != "none"
    # The CUDA build is only available on x86_64 Linux with an NVIDIA GPU and MPI.jl set
    # up with MPItrampoline. Its artifacts, and those of CUDA_Runtime_jll, are lazy, so
    # nothing is downloaded where it is unavailable.
    using SuperLU_DIST_CUDA_jll: SuperLU_DIST_CUDA_jll
    if SuperLU_DIST_CUDA_jll.is_available()
        using SuperLU_DIST_CUDA_jll: libsuperlu_dist_Int32, libsuperlu_dist_Int64
        const HAVE_CUDA = true
    elseif _PREFERENCE_GPU == "cuda"
        error("""
            SuperLUDIST: the `gpu` preference is "cuda", but SuperLU_DIST_CUDA_jll is not available.
            It needs x86_64 Linux, an NVIDIA GPU and driver, and MPI.jl configured with
            MPItrampoline (`MPIPreferences.use_jll_binary("MPItrampoline_jll")`).
            Call `SuperLUDIST.set_gpu!(:auto)` to fall back to the CPU build.""")
    else
        using SuperLU_DIST_jll
        const HAVE_CUDA = false
    end
else
    using SuperLU_DIST_jll
    const HAVE_CUDA = false
end

@doc """
    HAVE_CUDA

Whether SuperLUDIST is using a CUDA build of SuperLU_DIST. With it, factorizations and
solves are offloaded to the GPU unless `options.superlu_acc_offload` is set to 0. See
[`set_gpu!`](@ref).
""" HAVE_CUDA

function _configure_gpu()
    # With several ranks, the GPU 3D factorization of SuperLU_DIST 9.3 (`GPU3DVERSION=1`,
    # the default of the CUDA build) passes device buffers to MPI, which segfaults unless
    # MPI is CUDA-aware. The earlier one (`GPU3DVERSION=0`) also runs on the GPU and
    # works with any MPI, so use it unless MPI.jl knows MPI to be CUDA-aware (set
    # `JULIA_MPI_HAS_CUDA=true` if it is but MPI.jl can't tell).
    if HAVE_CUDA && !haskey(ENV, "GPU3DVERSION") && !MPI.has_cuda()
        ENV["GPU3DVERSION"] = "0"
    end
end

function _check_libraries()
    # The library is chosen when SuperLUDIST is precompiled. If the CUDA build was chosen
    # but is not available now, for example when the package was precompiled on a node
    # with a GPU and is loaded on one without, the bindings would be wrong.
    if HAVE_CUDA && !CUSTOM_LIBRARIES && !SuperLU_DIST_CUDA_jll.is_available()
        error("""
            SuperLUDIST was precompiled for the CUDA build of SuperLU_DIST, which is not
            available here. Precompile SuperLUDIST on a node like this one, or call
            `SuperLUDIST.set_gpu!(:none)` and restart Julia to use the CPU build.""")
    end
end

"""
    set_gpu!(gpu::Symbol)

Choose which build of SuperLU_DIST to use:

- `:auto` (the default) uses the CUDA build from `SuperLU_DIST_CUDA_jll` where it is
  available, which needs x86_64 Linux, an NVIDIA GPU and MPI.jl configured with
  MPItrampoline, and the CPU build from `SuperLU_DIST_jll` everywhere else.
- `:cuda` requires the CUDA build, and loading SuperLUDIST fails where it is unavailable.
- `:none` always uses the CPU build.

Libraries set with [`set_libraries!`](@ref) take precedence. [`HAVE_CUDA`](@ref) tells
which build is in use.

The choice is stored with Preferences.jl and takes effect after restarting Julia.
"""
function set_gpu!(gpu::Symbol)
    gpu in (:auto, :cuda, :none) || throw(ArgumentError("gpu must be :auto, :cuda or :none, got :$gpu"))
    if gpu === :auto
        @delete_preferences!("gpu")
    else
        @set_preferences!("gpu" => String(gpu))
    end
    @info "Please restart Julia and reload SuperLUDIST.jl for the library changes to take effect."
end

"""
    set_libraries!(; libsuperlu_dist_Int32 = nothing, libsuperlu_dist_Int64 = nothing)

Use your own builds of SuperLU_DIST instead of the ones from `SuperLU_DIST_jll` or
`SuperLU_DIST_CUDA_jll`, for example to link against a system MPI on an HPC cluster. The
libraries must be SuperLU_DIST 9.3.x, built with 32-bit and 64-bit `int_t` respectively,
and linked against the same MPI that MPI.jl uses. They may be CPU or CUDA builds, but
both must be the same kind. Either may be omitted, in which case matrices with that
index type are unavailable. Calling `set_libraries!()` with no arguments reverts to the
jll builds.

The choice is stored with Preferences.jl and takes effect after restarting Julia.
"""
function set_libraries!(;libsuperlu_dist_Int32 = nothing, libsuperlu_dist_Int64 = nothing)
    if isnothing(libsuperlu_dist_Int32)
        @delete_preferences!("libsuperlu_dist_Int32")
    else
        isfile(libsuperlu_dist_Int32) || throw(ArgumentError("$libsuperlu_dist_Int32 is not a file that exists."))
        @set_preferences!("libsuperlu_dist_Int32" => libsuperlu_dist_Int32)
    end
    if isnothing(libsuperlu_dist_Int64)
        @delete_preferences!("libsuperlu_dist_Int64")
    else
        isfile(libsuperlu_dist_Int64) || throw(ArgumentError("$libsuperlu_dist_Int64 is not a file that exists."))
        @set_preferences!("libsuperlu_dist_Int64" => libsuperlu_dist_Int64)
    end
    @info "Please restart Julia and reload SuperLUDIST.jl for the library changes to take effect."
end
