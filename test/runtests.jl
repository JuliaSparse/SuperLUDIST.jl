using SuperLUDIST
using MPI
using Test

@testset "SuperLUDIST.jl" begin
    @testset "Options" begin
        for Ti in (Int32, Int64)
            o = SuperLUDIST.Options{Ti}(; PrintStat = SuperLUDIST.Common.NO)
            @test o.PrintStat == SuperLUDIST.Common.NO
            @test o.Fact == SuperLUDIST.Common.DOFACT
            o.Fact = SuperLUDIST.Common.FACTORED
            @test o.Fact == SuperLUDIST.Common.FACTORED
        end
    end

    # The solvers need an MPI job, so run them under mpiexec on a 1×1 and a 2×2 grid.
    @testset "MPI solves on $nprocs rank(s)" for nprocs in (1, 4)
        script = joinpath(@__DIR__, "mpi_solve.jl")
        cmd = `$(MPI.mpiexec()) -n $nprocs $(Base.julia_cmd()) --startup-file=no --project=$(Base.active_project()) $script`
        @test success(pipeline(addenv(cmd, "OMP_NUM_THREADS" => "1"); stdout, stderr))
    end
end
