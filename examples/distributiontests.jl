using MPI
using SuperLUDIST
using SparseBase
using SparseBase: CoordinateStore, CSRStore
using SparseBase.Communication
using SparseBase.Communication: DistributedSparseStore
using CIndices
MPI.Init()

comm = MPI.COMM_WORLD
println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")
MPI.Barrier(comm)

rank = MPI.Comm_rank(comm)
comm_size = MPI.Comm_size(comm)
x = rank == 0 ?
    CoordinateStore((rand(1:10, 12), rand(1:10, 12)), collect(1:12)) :
    CoordinateStore{Int64, Int64, 2}()

Communication.bcaststore!(x, 0, comm)
if rank == 0
    println("Bcast COO - Original: ")
    println("================")
    @show x
    println()
    println("Each rank")
    println("================")
end
MPI.Barrier(comm)

for i = 0:comm_size-1
    if rank == i
        @show rank x
    end
    MPI.Barrier(comm)
end

x = rank == 0 ?
    SparseBase.sortcoalesce(CoordinateStore((rand(1:10, 12), rand(1:10, 12)), collect(1:12), (10, 10); sortorder = RowMajor())) :
    nothing

if rank == 0
    println("\n================")
    println("Scatter COO - Original: ")
    println("================")
    @show x
    println()
    println("================")
end
MPI.Barrier(comm)

y = DistributedSparseStore(CoordinateStore{Int64, Int64, 2}(), ([6, 4], 10), comm)

if rank == 1
    println("\n================")
    println("Scatter COO - Original y: ")
    println("================")
    @show y
    println()
    println("Each rank")
    println("================")
end

y = Communication.scatterstore!(y, x)


for i = 0:comm_size-1
    if rank == i
        @show rank y
    end
    MPI.Barrier(comm)
end

x = rank == 0 ?
    convert(SparseBase.CSRStore, SparseBase.CoordinateStore((rand(1:5, 10), rand(1:5, 10)), collect(1:10), (10, 10))) :
    SparseBase.CSRStore{Int, Int}()

Communication.bcaststore!(x, 0, comm)
if rank == 0
    println("\n================")
    println("Bcast CSR - Original: ")
    println("================")
    @show x
    println()
    println("Each rank")
    println("================")
end
MPI.Barrier(comm)
for i = 0:comm_size-1
    if rank == i
        @show rank x
    end
    MPI.Barrier(comm)
end

x = rank == 0 ?
    convert(SparseBase.CSRStore, SparseBase.CoordinateStore((CIndex.(rand(1:5, 10)), CIndex.(rand(1:5, 10))), collect(1:10), (5, 5))) :
    nothing
y = SparseBase.CSRStore{Int, CIndex{Int}}()

if rank == 0
    println("\n================")
    println("Scatter CSR - Original: ")
    println("================")
    @show x
    println()
    println("Each rank")
    println("================")
end
MPI.Barrier(comm)
y, globalnrows, first_row = Communication.scatterstore!(y, x, [3, 2])

for i = 0:comm_size-1
    if rank == i
        @show rank globalnrows first_row y
    end
    MPI.Barrier(comm)
end

x = rank == 0 ?
    convert(SparseBase.CSRStore, SparseBase.CoordinateStore((CIndex.(rand(1:5, 10)), CIndex.(rand(1:5, 10))), rand(10), (5, 5))) :
    nothing
y = SuperLUDIST.DistributedSuperMatrix{Float64, Int}()

if rank == 0
    println("\n================")
    println("Scatter CSR - Original: ")
    println("================")
    @show x
    println()
    println("Each rank")
    println("================")
end
MPI.Barrier(comm)
y = Communication.scatterstore!(y, x, [3, 2])

for i = 0:comm_size-1
    if rank == i
        @show rank
        dump(y)
    end
    MPI.Barrier(comm)
end