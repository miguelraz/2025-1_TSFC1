# Tarea 4 - Miguel Raz

# --- Ejercicio 1 ---

import Pkg
Pkg.activate("..")

using Plots
N = 500_000
zs = [ComplexF64(2rand()-1, 2rand()-1) for i in 1:N];

function Newton(z_n, f, f′, n)
    for i in 1:n
        z_n -= f(z_n)/f′(z_n)
    end
    z_n
end

f(z) = z^3 - 1
f′(z) = 3z^2

iter_f = Newton.(zs, f, f′, 60)
convs = unique(iter_f)

categorias = indexin(iter_f, convs[1:3])

primeros = zs[categorias .== 1]
segundos = zs[categorias .== 2]
terceros = zs[categorias .== 3]

p = scatter(primeros, label = "", title = "Convergencias del Mapeo de Newton", markersize = 1, markerstrokewidth = 0, color = RGB(0.255,0.412,0.847));
scatter!(p, segundos, label = "", markersize = 1, markerstrokewidth = 0, color = RGB(0.584, 0.345, 0.698));
scatter!(p, terceros, label = "", markersize = 1, markerstrokewidth = 0, color = RGB(0.133, 0.596, 0.149))

# --- Ejercicio 2 ---
using Plots

p1((x, y)) = (0.0, 0.16y)
p2((x, y)) = (0.85x + 0.04y, -0.04x + 0.85y + 1.6)
p3((x, y)) = (0.2x - 0.26y, 0.23x + 0.22y + 1.6)
p4((x, y)) = (-0.15x + 0.28y, 0.26x + 0.24y + 0.44)
[p1((0.1, 0.1)), p2((0.1, 0.1)), p3((0.1, 0.1)), p4((0.1, 0.1))]

function B(t)
    p = rand() 
    if p < 0.01
        p1(t)
    elseif p < 0.08
        p4(t)
    elseif p < 0.15
        p3(t)
    elseif p < 1.0 
        p2(t)
    end
end



n = 20_000
bs = [(20rand()-10, 20rand()-10) for _ in 1:n]
for _ in 1:50
    bs .= B.(bs)
end

scatter(first.(bs), last.(bs), 
    title = "Puntos fijos de B(x,y)",
    label = "", xlabel = "x", ylabel = "y",
    markerstrokecolor = :green,
    markerstrokewidth=1,
    markersize = 1.5,
    markerstrokesize=1)

