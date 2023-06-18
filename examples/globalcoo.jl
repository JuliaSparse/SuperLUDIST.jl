using MPI
using SuperLU_DIST
using MatrixMarket
MPI.Init()

comm = MPI.COMM_WORLD
println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")
MPI.Barrier(comm)

rank = MPI.Comm_rank(comm)
comm_size = MPI.Comm_size(comm)
x = MatrixMarket.mmread(
    SuperLU_DIST.GlobalSuperMatrix{Float64, Int32},
    joinpath(@__DIR__, "add32.mtx")
)

if rank == 0
    println("Original array")
    println("================")
    @show getindex.(x.indices, lastindex(x.indices[1])) => x.v[end]
    println()
    println("Each rank")
    println("================")
end
MPI.Barrier(comm)

for i = 0:comm_size-1
    if rank == i
        @show rank getindex.(x.indices, lastindex(x.indices[1])) => x.v[end]
    end
    MPI.Barrier(comm)
end