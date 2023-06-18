using SuperLUDIST
using Documenter

DocMeta.setdocmeta!(SuperLUDIST, :DocTestSetup, :(using SuperLUDIST); recursive=true)

makedocs(;
    modules=[SuperLUDIST],
    authors="Aadesh Deshmukh",
    repo="https://github.com/aa25desh/SuperLUDIST.jl/blob/{commit}{path}#{line}",
    sitename="SuperLUDIST.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://aa25desh.github.io/SuperLUDIST.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/aa25desh/SuperLUDIST.jl",
    devbranch="main",
)
