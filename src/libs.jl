using Libdl: dlopen, dlclose, dllist, dlpath, dlsym, RTLD_DEEPBIND, RTLD_LAZY
using Preferences

const _PREFERENCE_SLUINT32 = @load_preference("libsuperlu_dist_Int32", nothing)
const _PREFERENCE_SLUINT64 = @load_preference("libsuperlu_dist_Int64", nothing)
const _PREFERENCE_GPU = @load_preference("gpu", "none")

_PREFERENCE_GPU in ("cuda", "none") ||
    error("SuperLUDIST: invalid `gpu` preference $(repr(_PREFERENCE_GPU)), see `SuperLUDIST.set_gpu!`.")

const flags = RTLD_DEEPBIND | RTLD_LAZY
const _CUDA_JLL = Base.PkgId(Base.UUID("32712609-44d4-5b88-8647-7f032361c66d"), "SuperLU_DIST_CUDA_jll")
const CUSTOM_LIBRARIES = _PREFERENCE_SLUINT32 !== nothing || _PREFERENCE_SLUINT64 !== nothing
if CUSTOM_LIBRARIES
    const libsuperlu_dist_Int32 = _PREFERENCE_SLUINT32
    const libsuperlu_dist_Int64 = _PREFERENCE_SLUINT64
    # Only the CUDA build exports `nv_init_wrapper`.
    const HAVE_CUDA = any((libsuperlu_dist_Int32, libsuperlu_dist_Int64)) do lib
        lib === nothing && return false
        dlsym(dlopen(lib, flags; throw_error=true), :nv_init_wrapper; throw_error=false) !== nothing
    end
elseif _PREFERENCE_GPU == "cuda"
    # SuperLU_DIST_CUDA_jll is a weak dependency, which users add themselves, so that its
    # artifacts and the CUDA runtime (about 2.5 GB) are only downloaded by those who want
    # them. A package can't load a weak dependency while it is precompiled, so the CUDA
    # bindings are chosen from the preference alone, and `__init__` loads the jll and sets
    # the library paths.
    global libsuperlu_dist_Int32::Union{Nothing, String} = nothing
    global libsuperlu_dist_Int64::Union{Nothing, String} = nothing
    const HAVE_CUDA = true
else
    using SuperLU_DIST_jll
    const HAVE_CUDA = false
end

@doc """
    HAVE_CUDA

Whether SuperLUDIST is set up for a CUDA build of SuperLU_DIST. With it, factorizations
and solves are offloaded to the GPU unless `options.superlu_acc_offload` is set to 0. If
the CUDA build can't be used where SuperLUDIST is loaded, an error is logged and the
libraries are not set. See [`set_gpu!`](@ref).
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

function _load_libraries()
    (HAVE_CUDA && !CUSTOM_LIBRARIES) || return
    # Packages that depend on SuperLUDIST load it while they are precompiled, when the jll
    # can't be loaded either. Nothing can be called then.
    ccall(:jl_generating_output, Cint, ()) == 1 && return
    # Report problems rather than throw, so that SuperLUDIST still loads and
    # `set_gpu!(:none)` can be called. Calls into SuperLU_DIST then fail, since the
    # libraries are not set.
    if Base.locate_package(_CUDA_JLL) === nothing
        @error """
            SuperLUDIST is set up to use the CUDA build of SuperLU_DIST, but
            SuperLU_DIST_CUDA_jll is not installed. Add it to your environment
            (`import Pkg; Pkg.add("SuperLU_DIST_CUDA_jll")`), or call
            `SuperLUDIST.set_gpu!(:none)` and restart Julia to use the CPU build."""
        return
    end
    jll = Base.require(_CUDA_JLL)
    # The jll was loaded after this function was compiled, so call into it with
    # `invokelatest`.
    if !Base.invokelatest(jll.is_available)
        @error """
            SuperLUDIST is set up to use the CUDA build of SuperLU_DIST, which is not
            available here. It needs x86_64 Linux, an NVIDIA GPU and driver, and MPI.jl
            configured with MPItrampoline (`MPIPreferences.use_jll_binary("MPItrampoline_jll")`).
            Call `SuperLUDIST.set_gpu!(:none)` and restart Julia to use the CPU build."""
        return
    end
    # The jll is available wherever the NVIDIA driver library is installed, even without
    # a GPU, and SuperLU_DIST aborts on its first GPU call if there is none.
    if !_have_gpu()
        @error """
            SuperLUDIST is set up to use the CUDA build of SuperLU_DIST, but no NVIDIA GPU
            was found. Call `SuperLUDIST.set_gpu!(:none)` and restart Julia to use the CPU
            build."""
        return
    end
    # `setglobal!` rather than `global`, which would declare these names in the CPU build
    # too, hiding the ones from SuperLU_DIST_jll.
    for name in (:libsuperlu_dist_Int32, :libsuperlu_dist_Int64)
        setglobal!(@__MODULE__, name, Base.invokelatest(getglobal, jll, name))
    end
    return
end

# Whether the CUDA driver finds a GPU. SuperLU_DIST_CUDA_jll has loaded libcuda by now.
function _have_gpu()
    lib = dlopen("libcuda.so.1"; throw_error=false)
    lib === nothing && return false
    ccall(dlsym(lib, :cuInit), Cint, (Cuint,), 0) == 0 || return false
    count = Ref{Cint}(0)
    ccall(dlsym(lib, :cuDeviceGetCount), Cint, (Ptr{Cint},), count) == 0 || return false
    return count[] > 0
end

"""
    set_gpu!(gpu::Symbol)

Choose which build of SuperLU_DIST to use:

- `:none` (the default) uses the CPU build from `SuperLU_DIST_jll`.
- `:cuda` uses the CUDA build from `SuperLU_DIST_CUDA_jll`. That package is not
  installed with SuperLUDIST, so add it to your environment first. The CUDA build needs
  x86_64 Linux, an NVIDIA GPU and driver, and MPI.jl configured with MPItrampoline, and
  SuperLUDIST reports an error when it is loaded where it can't be used.

Libraries set with [`set_libraries!`](@ref) take precedence. [`HAVE_CUDA`](@ref) tells
which build is in use.

The choice is stored with Preferences.jl and takes effect after restarting Julia.
"""
function set_gpu!(gpu::Symbol)
    gpu in (:cuda, :none) || throw(ArgumentError("gpu must be :cuda or :none, got :$gpu"))
    if gpu === :cuda
        Base.locate_package(_CUDA_JLL) === nothing && throw(ArgumentError("""
            SuperLU_DIST_CUDA_jll is not installed. Add it to your environment first with
            `import Pkg; Pkg.add("SuperLU_DIST_CUDA_jll")`."""))
        @set_preferences!("gpu" => "cuda")
    else
        @delete_preferences!("gpu")
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
