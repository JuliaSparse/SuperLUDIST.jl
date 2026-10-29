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
        @test SuperLUDIST.Options() isa SuperLUDIST.Options{Int}
        @test :ColPerm in propertynames(SuperLUDIST.Options())
        @test_throws ArgumentError SuperLUDIST.Options{Int64}(; NotAnOption = 1)
        @test_throws ArgumentError SuperLUDIST.Options{Int64}().NotAnOption = 1
    end

    @testset "Names" begin
        @test SuperLUDIST.prefixname(Float32, :gssvx) === :sgssvx
        @test SuperLUDIST.prefixname(Float64, :gssvx) === :dgssvx
        @test SuperLUDIST.prefixname(ComplexF32, :gssvx) === :cgssvx
        @test SuperLUDIST.prefixname(ComplexF64, :gssvx) === :zgssvx
        @test SuperLUDIST.toslutype(ComplexF64) == SuperLUDIST.Common.SLU_Z
    end

    @testset "set_libraries!" begin
        # Only the error path: setting libraries writes LocalPreferences.toml.
        missing_lib = joinpath(tempdir(), "no-such-libsuperlu_dist.so")
        @test_throws ArgumentError SuperLUDIST.set_libraries!(; libsuperlu_dist_Int32 = missing_lib)
    end

    # The solvers need an MPI job, so run them under mpiexec on a 1×1 and a 2×2 grid.
    @testset "MPI solves on $nprocs rank(s)" for nprocs in (1, 4)
        script = joinpath(@__DIR__, "mpi_solve.jl")
        cmd = `$(MPI.mpiexec()) -n $nprocs $(Base.julia_cmd()) --startup-file=no --project=$(Base.active_project()) $script`
        @test success(pipeline(addenv(cmd, "OMP_NUM_THREADS" => "1"); stdout, stderr))
    end
end
