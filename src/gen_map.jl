export gen_map, shift

"""
gen_map(filename::String, mcol::Symbol, n::Int, plotfun::Function, msize::Number, fa::Number)

Generates a figure using `plotfun` using `n` random events in USGS earthquake data `filename`.

# INPUTS
filename: Path to USGS data
mcol: Color of marker in plot
n: Number of random data points plotted
plotfun: Function used to plot data
msize: Marker size
fa: Marker alpha

# EXAMPLE


"""
function gen_map(filename::String, mcol::Symbol, n::Int, plotfun::Function, msize::Number, fa::Number)

    d = DataFrames.readtable(filename)
    data = convert(Array, d[:,[2,3,4,5]]); N = randperm(size(d)[1])[1:min(size(d)[1], n)]

    plotfun(map(shift,data[N,2]), data[N,1],markersize = msize, 
                                            markercolor = mcol, 
                                            markerstrokecolor = mcol, 
                                            markeralpha = fa,
                                            background_color = :black,
                                            legend = false)

end

function shift(x)
    if x < 20;
        return x+360
    else
        return x
    end
end

