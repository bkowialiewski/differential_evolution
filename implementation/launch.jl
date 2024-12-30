include("differential_evolution.jl")
include("used_functions.jl")

function launch()

    # maximum number of iterations to run
    n_epoch = 10^5
    # dimensionality of the problem
    n_parameters = 1
    # name of the to-be-fitted function
    function_name = "rastrigin"

    # just launch the main function
    error, convergence = differential_evolution(n_epoch, n_parameters, function_name)

    println(error)
    println(convergence)

    nothing

end

launch()
