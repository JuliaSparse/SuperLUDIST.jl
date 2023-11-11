using Libdl: dlopen, dlclose, dlpath, dlsym, RTLD_DEEPBIND, RTLD_LAZY
using Preferences

const _PREFERENCE_SLUINT32 = @load_preference("libsuperlu_dist_Int32", nothing)
const _PREFERENCE_SLUINT64 = @load_preference("libsuperlu_dist_Int64", nothing)

flags = RTLD_DEEPBIND | RTLD_LAZY
if _PREFERENCE_SLUINT32 === nothing && _PREFERENCE_SLUINT64 === nothing
    using SuperLU_DIST_jll
elseif _PREFERENCE_SLUINT32 === nothing
    libsuperlu_dist_Int64 = _PREFERENCE_SLUINT64
    dlopen(libsuperlu_dist_Int64, flags; throw_error=true)
    libsuperlu_dist_Int32 = nothing
elseif _PREFERENCE_SLUINT32 === nothing
    libsuperlu_dist_Int32 = _PREFERENCE_SLUINT32
    dlopen(libsuperlu_dist_Int32, flags; throw_error=true)
    libsuperlu_dist_Int64 = nothing
else
    libsuperlu_dist_Int64 = _PREFERENCE_SLUINT64
    dlopen(libsuperlu_dist_Int64, flags; throw_error=true)
    libsuperlu_dist_Int32 = _PREFERENCE_SLUINT32
    dlopen(libsuperlu_dist_Int32, flags; throw_error=true)
end

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
