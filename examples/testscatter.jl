using MPI
using SuperLUDIST
MPI.Init()

comm = MPI.COMM_WORLD
println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")
MPI.Barrier(comm)

rank = MPI.Comm_rank(comm)
comm_size = MPI.Comm_size(comm)
if rank == 0
    x = rand(1:10, 20)
else
    x = Int64[]
end

y = SuperLUDIST._scatterarray(x, [5, 5, 5, 5])

if rank == 0
    println("Original array")
    println("================")
    @show x
    println()
    println("Each rank")
    println("================")
end
MPI.Barrier(comm)

for i = 0:comm_size-1
    if rank == i
        @show rank y
    end
    MPI.Barrier(comm)
end