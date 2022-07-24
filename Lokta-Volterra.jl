begin  # imports
    using DifferentialEquations
    using Plots
    using GLMakie
    using ParameterizedFunctions
end

# Phase portrait of L-V equations
begin
    α, β, γ, δ = 1.5, 1.0, 3.0, 1.0  # defining our parameters
    x_dot(R, F) = Point2(α * R - β * R * F, -γ * F + δ * R * F)  #ode definition
    fig = Figure(resolution = (600, 400)) # create the figure
    ax = Axis(
        fig[1, 1],
        xlabel = "Rabbits",
        ylabel = "Foxes",
        backgroundcolor = :white,
    )  # define the axis
    xrange, yrange = -1:8, -1:3
    streamplot!(
        ax,
        x_dot,
        xrange,
        yrange,
        gridsize = (30, 20),
        arrow_size = 10,
        colormap = :linear_ternary_green_0_46_c42_n256,
    )  # populating the Figure
    #gridsize is density, (30,20) means start points along x 20 along y
    #arrow_size = 10 is a good size for the arrows at this scale
    display(fig)
    save("foxes_vs_rabbits_phase.png", fig)
end
