using SuperLUDIST
using MPI
using Documenter
using Logging
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
    # SuperLU_DIST prints as it solves, so show a job's output only if it fails.
    @testset "MPI solves on $nprocs rank(s)" for nprocs in (1, 4)
        script = joinpath(@__DIR__, "mpi_solve.jl")
        cmd = `$(MPI.mpiexec()) -n $nprocs $(Base.julia_cmd()) --startup-file=no --project=$(Base.active_project()) $script`
        log = tempname()
        ok = open(log, "w") do io
            success(pipeline(addenv(cmd, "OMP_NUM_THREADS" => "1"); stdout = io, stderr = io))
        end
        ok || print(read(log, String))
        @test ok
    end

    # The README's examples, on a single rank. Last, since they finalize MPI. Its code blocks
    # are `julia` blocks so that GitHub highlights them, and those with an `# output`
    # section are doctests.
    @testset "README doctests" begin
        # Git may check the README out with CRLF line endings, as on Windows.
        readme = replace(read(joinpath(pkgdir(SuperLUDIST), "README.md"), String), "\r\n" => "\n")
        blocks = r"```julia\n((?:(?!```)[\s\S])*?\n# output\n)"
        @test occursin(blocks, readme)
        dir = mktempdir()
        write(joinpath(dir, "index.md"), replace(readme, blocks => s"```jldoctest readme\n\1"))
        # Documenter logs its build steps at Info level, and doctest failures as errors.
        with_logger(ConsoleLogger(stderr, Logging.Error)) do
            doctest(dir, [SuperLUDIST]; testset = "README")
        end
    end
end
