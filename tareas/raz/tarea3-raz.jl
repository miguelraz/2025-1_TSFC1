# Tarea 3 - Miguel Raz

# --- Ejercicio 1 ---

using Plots

F(x) = x^2 - 2

# (a.1)
xs = zeros(20_000)
xs[1] = F(rand()*2-1)
for i in 2:20_000
    xs[i] = F(xs[i-1])
end

#xs[end-5:end]

# (a.2)
histogram(xs, normalize = true, title = "Frecuencias de puntos en la orbita", label = "")

# (b)
N = 20_000
ys = [2rand()-1 for i in 1:N]
for i in 1:N
    for _ in 1:50
        ys[i] = F(ys[i])
    end
end

histogram(ys, normalize = true, label = "", title = "Frecuencia de puntos en la orbita")

# (c)
# Raz: Que más bien podemos tomar muchos distintos puntos aleatorios e
# iterarlos pocas veces para que "caigan" en sus órbitas respectivas.

# --- Ejercicio 2 ---

# (a)
include("duales-raz.jl")
using .NumDual

import .NumDual: fun, der

# (b.1)
function newton(f, x0, N)
    x_n = dual(x0)
    for i in 1:N
        x_n -= fun(f(x_n))/der(f(x_n))
    end
    x_n
end

f_1(x) = x^3 - 15.625
root = newton(f_1, 2, 100) 

# (b.2)
@assert fun(f_1(root)) == 0 "Newton works!"

# (c)
f_2(x) = x^2 - 1.1

zs = dual.(rand(10_000))

for _ in 1:50
    zs .= f_2.(zs)
end

zs

# (d) 
# TODO: should be 0?
@assert count(zs .≈ f_2.(f_2.(zs))) == 0 "Deberian ser 0???"

# (e)
f_3(x) = x^2 - 1
rs = dual.(rand(10_000))

for _ in 1:50
    rs .= f_2.(rs)
end

f_3.(f_3.(rs))


# --- Ejercicio 3 ---

# (a)
Q(x, c) = x^2 - c 
cs = collect(0:1/4096:2)
n = length(cs)
vcs = [0.0 for c in cs, j in 1:2^7]

for _ in 1:200
    vcs[:, 1] .= Q.(vcs[:, 1], cs)
end

vcs

for i in 2:(2^7)
    vcs[:, i] .= Q.(vcs[:, i-1], cs)
end

plot(vcs, label = "", title = "Mapeo Q_c(x) = x^2 - c")

# (b)
v1 = cs[vcs[:, 1] .== vcs[:, 2]]
v2 = cs[vcs[:, 1] .== vcs[:, 4]]
v3 = cs[vcs[:, 1] .== vcs[:, 8]]
v4 = cs[vcs[:, 1] .== vcs[:, 16]]
v5 = cs[vcs[:, 1] .== vcs[:, 32]]
v6 = cs[vcs[:, 1] .== vcs[:, 64]]
v7 = cs[vcs[:, 1] .== vcs[:, 128]]
qcs = [vcs[:, 1] vcs[:, 2] vcs[:, 4] vcs[:, 8] vcs[:, 16] vcs[:, 32] vcs[:, 64] vcs[:, 128]]

sorted_v1 = sort(v1)
resv1 = - sorted_v1[1]/sorted_v1[2]

sorted_v2 = sort(v2)
resv2 = - sorted_v2[1]/sorted_v2[2]