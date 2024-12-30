function initialize_population(single, parameter_names)

    # pre-allocate population
    population = Vector{Dictionary{String, Parameters}}(undef, single.population_size)
    # iterate over it and fill it with random individuals
    for i in 1:single.population_size
        population[i] = generate_individual(parameter_names)
    end

    population

end

function generate_individual(parameter_names)

    # pre-allocate current individual
    individual = Dictionary{String, Parameters}()
    # iterate over keys
    for key in parameter_names
        # insert standard individual
        insert!(individual, key, Parameters(0.0, -5.12, 5.12, true))
        # define the range of values for the default
        rng = individual[key].ub - individual[key].lb
        # generate random default - within bound
        individual[key].value = rand() * rng - rng/2.0
    end

    individual

end
