using Dictionaries, StatsBase

include("functions/structs.jl")
include("functions/population.jl")
include("functions/mutations.jl")
include("functions/utilities.jl")

function differential_evolution(n_epoch, n_parameters, function_name)

    # get generic function
    f = getfield(Main, Symbol(function_name))

    # first generate structs and vectors
    single, vectors = generate_structs(n_epoch, n_parameters)
    # generate first population
    vectors.population = initialize_population(single, vectors.parameter_names)
    # evaluate its fitness
    evaluate_fitness(vectors, f)
    base_sd = standard_deviation(single, vectors)

    # iterate over number of epoch
    for epoch in 1:single.n_epoch

        # generate a new population from the initial one
        mutate_population(single, vectors, f)
        # and evaluate the new fitness
        evaluate_fitness(vectors, f)

        current_sd = standard_deviation(single, vectors)

        # stopping criterion
        if current_sd < single.m
            break
        end

    end

    best_individual = argmin(vectors.fitness)
    sd = standard_deviation(single, vectors)

    vectors.fitness[best_individual], sd

end

function evaluate_fitness(vectors, f)

    for i in eachindex(vectors.population)
        vectors.fitness[i] = f(vectors.population[i])
    end

    nothing

end

function standard_deviation(single, vectors)

    radius = zeros(single.population_size)
    for i in 1:single.population_size
        for key in keys(vectors.population[i])
            radius[i] += vectors.population[i][key].value^2.0
        end
        radius[i] = sqrt(radius[i])
    end

    sum((radius .- mean(radius)) .^ 2.0) / (single.population_size - 1)

end
