mutable struct Parameters

    value::Float64
    lb::Float64
    ub::Float64
    to_fit::Bool

end

mutable struct Single

    n_epoch::Int64
    n_parameters::Int64
    population_size::Int64
    crossover_probability::Float64
    differential_weight::Float64
    m::Float64

end

mutable struct Vectors

    parameter_names::Array{String, 1}
    population::Array{Dictionary{String, Parameters}, 1}
    fitness::Array{Float64, 1}
    candidates::Array{Int64, 1}

end


function generate_structs(n_epoch, n_parameters)

    parameter_names = "x" .* string.(1:n_parameters)

    single = Single(
                    n_epoch,
                    n_parameters,
                    15*length(parameter_names),
                    0.9,
                    0.8,
                    0.000001
                   )

    vectors = Vectors(
                      parameter_names,
                      Array{Dictionary{String, Parameters}, 1}(),
                      zeros(single.population_size),
                      [0, 0, 0]
                     )

    single, vectors

end
