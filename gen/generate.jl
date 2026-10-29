# Regenerate the Clang.jl bindings in `../lib` from the SuperLU_DIST_jll headers:
#
#     julia --project=gen gen/generate.jl
#
# SuperLU_DIST is built twice, once with 32-bit and once with 64-bit `int_t`, and the
# jll ships a self-contained copy of the headers for each width. Every width gets its
# own module (`SuperLU_Int32`, `SuperLU_Int64`) since most struct layouts depend on
# `int_t`. The enums do not, so they are emitted once into `SuperLUDIST_Common`.
using Clang.Generators
using MPICH_jll
using SuperLU_DIST_jll

cd(@__DIR__)

const INCLUDE_DIR = normpath(joinpath(SuperLU_DIST_jll.artifact_dir, "include"))
const MPI_INCLUDE_DIR = normpath(joinpath(MPICH_jll.artifact_dir, "include"))
const LIB_DIR = normpath(joinpath(@__DIR__, "..", "lib"))
const HEADERS = ["superlu_defs.h", "superlu_sdefs.h", "superlu_ddefs.h", "superlu_zdefs.h"]

isdir(MPI_INCLUDE_DIR) || error("$MPI_INCLUDE_DIR does not exist")

@add_def MPI_Comm
@add_def MPI_Request
@add_def MPI_Datatype
@add_def MPI_Errhandler

function make_context(width; ignorelist = String[], exclusivelist = nothing,
                      module_name, output_file, prologue, epilogue = "")
    width_dir = joinpath(INCLUDE_DIR, "superlu_dist_Int$width")
    config = read(joinpath(width_dir, "superlu_dist_config.h"), String)
    occursin("#define XSDK_INDEX_SIZE $width", config) ||
        error("$width_dir does not contain a $width-bit superlu_dist_config.h")

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
    append!(args, ["-I$width_dir", "-I$INCLUDE_DIR", "-isystem$MPI_INCLUDE_DIR"])
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

# Build both DAGs first so that we can check the enums really are width-independent.
ctxs = Dict(width => make_context(width; module_name = "SuperLU_Int$width",
                                  output_file = "libsuperlu_dist$width.jl",
                                  prologue = width_prologue(width))
            for width in (32, 64))
foreach(ctx -> build!(ctx, BUILDSTAGE_NO_PRINTING), values(ctxs))
enums = enum_ids(ctxs[64])
Set(enums) == Set(enum_ids(ctxs[32])) || error("enum definitions differ between Int32 and Int64")

const COMMON_EPILOGUE = """
    # Export the enum types and their values for the width modules and `src/`.
    for name in names(@__MODULE__; all = true)
        name in (:eval, :include, nameof(@__MODULE__)) || startswith(string(name), '#') ||
            @eval export \$name
    end
    """

common = make_context(64; exclusivelist = enums, module_name = "SuperLUDIST_Common",
                      output_file = "common.jl", prologue = "", epilogue = COMMON_EPILOGUE)
build!(common)

for ctx in values(ctxs)
    append!(ctx.options["general"]["output_ignorelist"], enums, fc_global_ids(ctx))
    build!(ctx, BUILDSTAGE_PRINTING_ONLY)
end
