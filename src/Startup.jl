module Startup

using Reexport

#### Stdlibs

@reexport using LinearAlgebra
@reexport using Pkg
@reexport using Statistics

#### Other packages

@reexport using BenchmarkTools
@reexport using Chairmarks
@reexport using Revise

using OhMyREPL
# using PrecompileTools
# using UnicodePlots

function startup()
    #### Environment variables

    # ENV["JULIA_PKG_DEVDIR"] = ENV["HOME"] * "/.julia/dev" # this is the default
    # ENV["PLOTS_DEFAULT_BACKEND"] = "PyPlot"
    # ENV["JULIA_STACKTRACE_MINIMAL"] = true # minimal stack trace with AbbreviatedStackTraces.jl

    #### LinearAlgebra

    # LinearAlgebra.BLAS.set_num_threads(Threads.nthreads())

    #### AbbreviatedStackTraces

    #### Revise

    #### OhMyREPL

    if !Sys.iswindows()
        # Causes huge lag on v1.3?
        # OhMyREPL.colorscheme!("Monokai16") # windows default
        # OhMyREPL.colorscheme!("Monokai256") # linux default
        OhMyREPL.colorscheme!("BoxyMonokai256")
    end
    OhMyREPL.enable_autocomplete_brackets(false)
    OhMyREPL.enable_pass!("RainbowBrackets", false)
    OhMyREPL.input_prompt!("julia-" * string(VERSION) * "> ", :green)
    #OhMyREPL.output_prompt!(">", :red)

    #### UnicodePlots

    # lineplot(rand(10), rand(10), title = "Lineplot")
    # scatterplot(rand(10), rand(10), title = "Scatterplot")
    # heatmap(rand(10, 10), title = "Heatmap")

    #### Pkg

    if isfile("Project.toml")
        Pkg.activate(".")
    end

    #### Load project environment file, if it exists

    env_file = joinpath(dirname(Base.active_project()), ".env.jl")
    if isfile(env_file)
        Main.include(env_file)
    end

    return nothing
end

#### Precompilation

# @compile_workload startup()

end # module Startup
