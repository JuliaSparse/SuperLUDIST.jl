using SuperLU_DIST
using Documenter

DocMeta.setdocmeta!(SuperLU_DIST, :DocTestSetup, :(using SuperLU_DIST); recursive=true)

makedocs(;
    modules=[SuperLU_DIST],
    authors="Aadesh Deshmukh",
    repo="https://github.com/aa25desh/SuperLU_DIST.jl/blob/{commit}{path}#{line}",
    sitename="SuperLU_DIST.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://aa25desh.github.io/SuperLU_DIST.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/aa25desh/SuperLU_DIST.jl",
    devbranch="main",
)
