function hyperbol(parameters)

    error = 0.0
    for key in keys(parameters)
        error += parameters[key].value^2.0
    end

    error

end

function rastrigin(parameters)

    error = 0.0
    for key in keys(parameters)
        error += (parameters[key].value ^ 2.0) - (10.0 * cos(2.0 * pi * parameters[key].value))
    end

    10.0 * length(parameters) + error

end
