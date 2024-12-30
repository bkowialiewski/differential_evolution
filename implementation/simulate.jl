using Plots, DelimitedFiles
include("differential_evolution.jl")
include("used_functions.jl")

function launch()

    n_sim = 1_000

    total_errors = zeros(n_sim)
    total_convergence = zeros(n_sim)
    for i in 1:n_sim

        total_errors[i], total_convergence[i] = differential_evolution(10^5, 8, "rastrigin")

        loading_bar(1, n_sim, i)

    end

    p1 = histogram(total_errors, xlabel = "error", legend = false)
    p2 = histogram(log.(total_errors), xlabel = "log(error)", legend = false)
    p3 = histogram(total_convergence, xlabel = "sd", legend = false)

    p = plot(p1, p2, p3,
             layout = (1,3),
             size = (850, 500)) 

    savefig(p, "plots/histogram.svg")

    nothing

end

launch()
