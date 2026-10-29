using Libdl: dlopen, dlclose, dlpath, dlsym, RTLD_DEEPBIND, RTLD_LAZY
using Preferences

const _PREFERENCE_SLUINT32 = @load_preference("libsuperlu_dist_Int32", nothing)
const _PREFERENCE_SLUINT64 = @load_preference("libsuperlu_dist_Int64", nothing)

const flags = RTLD_DEEPBIND | RTLD_LAZY
if _PREFERENCE_SLUINT32 === nothing && _PREFERENCE_SLUINT64 === nothing
    using SuperLU_DIST_jll
else
    const libsuperlu_dist_Int32 = _PREFERENCE_SLUINT32
    const libsuperlu_dist_Int64 = _PREFERENCE_SLUINT64
    libsuperlu_dist_Int32 === nothing || dlopen(libsuperlu_dist_Int32, flags; throw_error=true)
    libsuperlu_dist_Int64 === nothing || dlopen(libsuperlu_dist_Int64, flags; throw_error=true)
end

"""
    set_libraries!(; libsuperlu_dist_Int32 = nothing, libsuperlu_dist_Int64 = nothing)

Use your own builds of SuperLU_DIST instead of the ones from `SuperLU_DIST_jll`, for
example to link against a system MPI on an HPC cluster. The libraries must be SuperLU_DIST
9.3.x, built with 32-bit and 64-bit `int_t` respectively, and linked against the same MPI
that MPI.jl uses. Either may be omitted, in which case matrices with that index type are
unavailable. Calling `set_libraries!()` with no arguments reverts to `SuperLU_DIST_jll`.

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
