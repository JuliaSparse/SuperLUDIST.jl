# Check that every struct in the generated bindings has the same size as in C, for both
# the CPU and the CUDA build of SuperLU_DIST:
#
#     julia --project=gen gen/check_layout.jl
#
# Needs a C compiler (`cc`). MPI types are taken from MPICH, matching generate.jl.
using MPICH_jll
using MPI: MPI

include("builds.jl")

const MPI_INCLUDE_DIR = joinpath(MPICH_jll.artifact_dir, "include")
# Structs that are only declared with a tag in C.
const TAGGED = (:e_node, :superlu_pair)
# Opaque structs, only used behind pointers, have no size in C.
const OPAQUE = (:CUevent_st,)

# Load each build's bindings into its own `SuperLUDIST` module, which is what they import
# the library names from. Only the struct sizes are used, so the libraries are not loaded.
const Bindings = Dict{Symbol, Module}()
for build in BUILDS
    Bindings[build] = @eval module $(Symbol(:Build_, build))
        module SuperLUDIST
        const libsuperlu_dist_Int32 = "unused"
        const libsuperlu_dist_Int64 = "unused"
        include(joinpath($LIB_DIR, "common.jl"))
        include(joinpath($LIB_DIR, $(binding_file(build, 32))))
        include(joinpath($LIB_DIR, $(binding_file(build, 64))))
        end
    end
end

function check(build, width)
    L = getfield(Bindings[build].SuperLUDIST, Symbol(:SuperLU_Int, width))
    structs = sort([n for n in names(L; all = true)
                    if isdefined(L, n) && (T = getfield(L, n)) isa DataType && isstructtype(T) &&
                       parentmodule(T) === L && isconcretetype(T) && !startswith(string(n), '#') &&
                       n ∉ OPAQUE])
    include_root = include_dir(build)
    mktempdir() do dir
        src = joinpath(dir, "layout.c")
        open(src, "w") do io
            println(io, """
                #include <stdio.h>
                #include "superlu_ddefs.h"
                #include "superlu_sdefs.h"
                #include "superlu_zdefs.h"
                int main(void) {""")
            for n in structs
                ctype = n in TAGGED ? "struct $n" : string(n)
                println(io, "    printf(\"%zu\\n\", sizeof($ctype));")
            end
            println(io, "    return 0;\n}")
        end
        exe = joinpath(dir, "layout")
        includes = ["-I$(joinpath(include_root, "superlu_dist_Int$width"))",
                    extra_include_args(build)..., "-I$include_root", "-I$MPI_INCLUDE_DIR"]
        run(`cc -w $includes -o $exe $src`)
        csizes = parse.(Int, readlines(`$exe`))
        bad = [(n, sizeof(getfield(L, n)), c) for (n, c) in zip(structs, csizes) if sizeof(getfield(L, n)) != c]
        for (n, j, c) in bad
            println("$build Int$width: $n is $j bytes in Julia but $c bytes in C")
        end
        println("$build Int$width: $(length(structs) - length(bad)) of $(length(structs)) struct sizes match C")
        return isempty(bad)
    end
end

all([check(build, width) for build in BUILDS for width in (32, 64)]) || exit(1)
