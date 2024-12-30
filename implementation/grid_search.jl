using Plots, Dictionaries
include("used_functions.jl")

mutable struct Parameters

    value::Float64
    lb::Float64
    ub::Float64
    to_fit::Bool

end

function plot_function()

    parameter_names = "x" .* string.(1:2)

    # pre-allocate current individual
    individual = Dictionary{String, Parameters}()
    # iterate over keys
    for key in parameter_names
        # insert standard individual
        insert!(individual, key, Parameters(0.0, -5.12, 5.12, true))
    end

    rng = (-5.12):0.01:5.12

    errors = zeros(length(rng), length(rng))

    for i in eachindex(rng)
        for j in eachindex(rng)

            individual[parameter_names[1]].value = rng[i]
            individual[parameter_names[2]].value = rng[j]

            errors[i,j] = rastrigin(individual)

        end
    end

    p = heatmap(rng,
                rng,
                errors,
                xlabel = "x",
                ylabel = "y",
                title = "Rastrigin",
                c = :viridis,
                size = (500, 450))

    savefig(p, "plots/grid_search.svg")

    p1 = plot(rng,
              rng,
              errors, 
              camera = (30, 30),
              c = :viridis,
              t = :surface, legend = false)

    p2 = plot(rng,
              rng,
              errors, 
              camera = (10, 30),
              c = :viridis,
              t = :surface, legend = false)

    p3 = plot(rng,
              rng,
              errors, 
              camera = (30, 10),
              c = :viridis,
              t = :surface, legend = false)

    p4 = plot(rng,
              rng,
              errors, 
              camera = (40, 70),
              c = :viridis,
              t = :surface, legend = false)

    p = plot(p1, p2, p3, p4, layout = (2,2), size = (700, 650))
    display(p)

    # savefig(p, "plots/3D.svg")

    nothing

end

plot_function()
