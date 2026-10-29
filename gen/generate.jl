# Regenerate the Clang.jl bindings in `../lib` from the SuperLU_DIST headers:
#
#     julia --project=gen gen/generate.jl
#
# SuperLU_DIST is built twice, once with 32-bit and once with 64-bit `int_t`, and each jll
# ships a self-contained copy of the headers for each width. Every width gets its own
# module (`SuperLU_Int32`, `SuperLU_Int64`) since most struct layouts depend on `int_t`.
# The enums do not, so they are emitted once into `SuperLUDIST_Common`.
#
# This is done for both the CPU build (`SuperLU_DIST_jll`) and the CUDA build
# (`SuperLU_DIST_CUDA_jll`), whose struct layouts differ; see builds.jl. The two sets of
# width modules have the same names, and SuperLUDIST includes the set for the library it
# loads.
using Clang.Generators
using MPICH_jll

cd(@__DIR__)
include("builds.jl")

const MPI_INCLUDE_DIR = normpath(joinpath(MPICH_jll.artifact_dir, "include"))
const HEADERS = ["superlu_defs.h", "superlu_sdefs.h", "superlu_ddefs.h", "superlu_zdefs.h"]

isdir(MPI_INCLUDE_DIR) || error("$MPI_INCLUDE_DIR does not exist")

@add_def MPI_Comm
@add_def MPI_Request
@add_def MPI_Datatype
@add_def MPI_Errhandler

function make_context(build, width; ignorelist = String[], exclusivelist = nothing,
                      module_name, output_file, prologue, epilogue = "")
    include_root = include_dir(build)
    width_dir = joinpath(include_root, "superlu_dist_Int$width")
    config = read(joinpath(width_dir, "superlu_dist_config.h"), String)
    occursin("#define XSDK_INDEX_SIZE $width", config) ||
        error("$width_dir does not contain a $width-bit superlu_dist_config.h")
    occursin("#define HAVE_CUDA", config) == (build === :cuda) ||
        error("$width_dir is not the $build build of SuperLU_DIST")

    options = load_options(joinpath(@__DIR__, "generator.toml"))
    general = options["general"]
    general["library_name"] = "libsuperlu_dist_Int$width"
    general["module_name"] = module_name
    general["output_file_path"] = joinpath(LIB_DIR, output_file)
    prologue_file = tempname()
    write(prologue_file, prologue)
    general["prologue_file_path"] = prologue_file
    epilogue_file = tempname()
    write(epilogue_file, epilogue)
    general["epilogue_file_path"] = epilogue_file
    append!(general["output_ignorelist"], ignorelist)
    exclusivelist === nothing || (general["output_exclusivelist"] = exclusivelist)

    # The per-width directory must come first so that `superlu_dist_config.h` (and thus
    # `int_t`) is taken from it; everything else comes from the top-level include dir.
    args = get_default_args()
    append!(args, ["-I$width_dir", extra_include_args(build)...,
                   "-I$include_root", "-isystem$MPI_INCLUDE_DIR"])
    return create_context(joinpath.(width_dir, HEADERS), args, options)
end

enum_ids(ctx) = [string(node.id) for node in ctx.dag.nodes
                 if node.type isa Generators.AbstractEnumNodeType && !isempty(node.exprs)]

# Fortran name-mangling macros (`#define dgemm_ FC_GLOBAL(dgemm, DGEMM)`) are of no use
# from Julia, and `FC_GLOBAL` itself is a function-like macro we don't translate.
mentions(ex, s) = ex === s || (ex isa Expr && any(a -> mentions(a, s), ex.args))
fc_global_ids(ctx) = [string(node.id) for node in ctx.dag.nodes
                      if any(ex -> mentions(ex, :FC_GLOBAL), node.exprs)]

width_prologue(width) = """
    $(read(joinpath(@__DIR__, "prologue.jl"), String))
    using ..SuperLUDIST_Common
    import ..SuperLUDIST: libsuperlu_dist_Int$width
    """

# Build all DAGs first so that we can check the enums really are the same for every
# width and build: they all share `SuperLUDIST_Common`.
ctxs = Dict((build, width) => make_context(build, width;
                                           module_name = "SuperLU_Int$width",
                                           output_file = binding_file(build, width),
                                           prologue = width_prologue(width))
            for build in BUILDS for width in (32, 64))
foreach(ctx -> build!(ctx, BUILDSTAGE_NO_PRINTING), values(ctxs))
enums = enum_ids(ctxs[(:cpu, 64)])
for (key, ctx) in ctxs
    Set(enums) == Set(enum_ids(ctx)) || error("enum definitions of $key differ from (:cpu, 64)")
end

const COMMON_EPILOGUE = """
    # Export the enum types and their values for the width modules and `src/`.
    for name in names(@__MODULE__; all = true)
        name in (:eval, :include, nameof(@__MODULE__)) || startswith(string(name), '#') ||
            @eval export \$name
    end
    """

common = make_context(:cpu, 64; exclusivelist = enums, module_name = "SuperLUDIST_Common",
                      output_file = "common.jl", prologue = "", epilogue = COMMON_EPILOGUE)
build!(common)

for ctx in values(ctxs)
    append!(ctx.options["general"]["output_ignorelist"], enums, fc_global_ids(ctx))
    build!(ctx, BUILDSTAGE_PRINTING_ONLY)
end
