using SuperLUDIST
using Documenter

DocMeta.setdocmeta!(SuperLUDIST, :DocTestSetup, :(using SuperLUDIST); recursive=true)

makedocs(;
    modules=[SuperLUDIST],
    authors="Aadesh Deshmukh",
    repo="https://github.com/JuliaSparse/SuperLUDIST.jl/blob/{commit}{path}#{line}",
    sitename="SuperLUDIST.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://superludist.juliasparse.org",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaSparse/SuperLUDIST.jl",
    devbranch="main",
)
