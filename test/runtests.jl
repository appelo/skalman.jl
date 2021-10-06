using skalman
using Test

@testset "skalman.jl" begin
    # Write your tests here.
    @test legendrepoly(0.0,0) == [1.0]

end
