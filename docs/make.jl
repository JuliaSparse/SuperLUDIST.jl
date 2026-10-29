using SuperLUDIST
using Documenter

DocMeta.setdocmeta!(SuperLUDIST, :DocTestSetup, :(using SuperLUDIST); recursive=true)

makedocs(;
    modules=[SuperLUDIST],
    authors="Raye Kimmerer, Aadesh Deshmukh and contributors",
    repo=Remotes.GitHub("JuliaSparse", "SuperLUDIST.jl"),
    sitename="SuperLUDIST.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://juliasparse.github.io/SuperLUDIST.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Installation" => "installation.md",
        "Usage" => "usage.md",
        "API" => "api.md",
    ],
    checkdocs=:exports,
    # The Clang.jl-generated bindings carry the C header comments as docstrings.
    checkdocs_ignored_modules=[
        SuperLUDIST.SuperLUDIST_Common, SuperLUDIST.SuperLU_Int32, SuperLUDIST.SuperLU_Int64,
    ],
)

deploydocs(;
    repo="github.com/JuliaSparse/SuperLUDIST.jl",
    devbranch="main",
    push_preview=false,
)
