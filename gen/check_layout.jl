# Check that every struct in the generated bindings has the same size as in C:
#
#     julia --project=gen gen/check_layout.jl
#
# Needs a C compiler (`cc`). MPI types are taken from MPICH, matching generate.jl.
using MPICH_jll
using SuperLU_DIST_jll
using MPI: MPI

module SuperLUDIST
using SuperLU_DIST_jll
include(joinpath(@__DIR__, "..", "lib", "common.jl"))
include(joinpath(@__DIR__, "..", "lib", "libsuperlu_dist32.jl"))
include(joinpath(@__DIR__, "..", "lib", "libsuperlu_dist64.jl"))
end

const INCLUDE_DIR = joinpath(SuperLU_DIST_jll.artifact_dir, "include")
const MPI_INCLUDE_DIR = joinpath(MPICH_jll.artifact_dir, "include")
# Structs that are only declared with a tag in C.
const TAGGED = (:e_node, :superlu_pair)

function check(width)
    L = getfield(SuperLUDIST, Symbol(:SuperLU_Int, width))
    structs = sort([n for n in names(L; all = true)
                    if isdefined(L, n) && (T = getfield(L, n)) isa DataType && isstructtype(T) &&
                       parentmodule(T) === L && isconcretetype(T) && !startswith(string(n), '#')])
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
        run(`cc -w -I$(joinpath(INCLUDE_DIR, "superlu_dist_Int$width")) -I$INCLUDE_DIR -I$MPI_INCLUDE_DIR -o $exe $src`)
        csizes = parse.(Int, readlines(`$exe`))
        bad = [(n, sizeof(getfield(L, n)), c) for (n, c) in zip(structs, csizes) if sizeof(getfield(L, n)) != c]
        for (n, j, c) in bad
            println("Int$width: $n is $j bytes in Julia but $c bytes in C")
        end
        println("Int$width: $(length(structs) - length(bad)) of $(length(structs)) struct sizes match C")
        return isempty(bad)
    end
end

all(check, (32, 64)) || exit(1)
