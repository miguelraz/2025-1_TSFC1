# Tarea 3 - Miguel Raz

# --- Ejercicio 1 ---

import Pkg
Pkg.activate("..")
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
# También sucede que una sóla orbita perseguida por mucho tiempo va a recorrer la totalidad del
# espacio de interés - es decir, va a reflejar un comportamiento ergódico.

# --- Ejercicio 2 ---

# (a)
include("duales-raz.jl")
using .NumDual

# (b.1)
function newton(f, x0, N)
    x_n = dual(x0)
    for i in 1:N
        x_n -= fun(f(x_n))/der(f(x_n))
    end
    x_n
end
function newton(f, x0::Dual, N)
    x_n = x0
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
f_2_fijo(x) = x^2 - 1.1 - x

raiz_fijo = newton(f_2_fijo, -0.5, 10)
p1 = f_2(raiz_fijo)
p2 = f_2(p1)

# (d)
f_2_p2(x) = f_2(f_2(x)) - x
raiz_p2_fijo = newton(f_2_p2, -1., 10)
p22 = f_2(raiz_p2_fijo)

# (e)
F(x) = x^2 - 1
F2_fijo(x) = F(F(x)) - x 
fijo_F2 = newton(F2_fijo, -1, 10)
fijo_F2_2 = F(fijo_F2)

# Estos no jalan
F(fijo_F2_2)
F(fijo_F2)

# Estos si tienen la misma derivada!
F(F(fijo_F2))
F(F(fijo_F2_2))
# ... y el valor absoluto es menor que 1, ergo es linealmente estable.

# --- Ejercicio 3 ---

# (a)
using Plots
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

# Re(a)
#=
ex = :(Q_1(c))
for i in 2:2^7
    ex = :(Q_1($ex))
    if ispow2(i)
        op = Symbol("Q_$i")
        @eval $op(c) = $ex
    end
end
=#

Q(x, c) = x^2 - c 
function Qn(c, n)
    res = Q(0, c)
    for i in 2:n
        res = Q(res, c)
    end
    res
end

Q_1(c) = -c
Q_2(c) = c^2 - c 
Q_3(c) = (c^2 - c)^2 - c
Q_4(c) = ((c^2 - c)^2 - c)^2 - c
Q_8(c) = Qn(c, 8)
Q_16(c) = Qn(c, 16)
Q_32(c) = Qn(c, 32)
Q_64(c) = Qn(c, 64)
Q_128(c) = Qn(c, 128)

# Es claro que en esta definicion me he atorado
# Algun tip?
Q_1(1.2)
 Qn(1.2, 1)
Q_2(1.2)
 Qn(1.2, 2)
Q_3(1.2)
 Qn(1.2, 3)
Q_4(1.2)
 Qn(1.2, 4)

c1   = newton(Q_1    , 0  , 10) 
c2   = newton(Q_2  , 1, 10) 
c4   = newton(Q_4  , 1.2, 10) 
c8   = newton(Q_8  , 1.36 , 10)
# Verificar que la órbita sí es del periodo adecuado
Qn(fun(c8), 8)
c16  = newton(Q_16 , 1.4, 30)
Qn(fun(c16), 16)
c32  = newton(Q_32 , 1.4005, 30)
Qn(fun(c32), 32)
c64  = newton(Q_64 , 1.401, 30) 
Qn(fun(c64), 64)
c128 = newton(Q_128, 1.40115, 30)
Qn(fun(c128), 128)

cs = fun.([c1, c2, c4, c8, c16, c32, c64, c128])
fns = [(cs[i]-cs[i+1])/(cs[i+1] - cs[i+2]) for i in 1:length(cs)-2]
# (b)
using Plots
scatter(collect(1:6), fns)

# (b).2
dn = [[fun(Qn(c2, i)) for i in 1:2], 
    [fun(Qn(c4, i)) for i in 1:4],
    [fun(Qn(c8, i)) for i in 1:8],
    [fun(Qn(c16, i)) for i in 1:16],
    [fun(Qn(c32, i)) for i in 1:32],
    [fun(Qn(c64, i)) for i in 1:64],
    [fun(Qn(c128, i)) for i in 1:128]]
dn2 =  [sort(abs.(x)) for x in dn]
fns = [dn2[i][2] for i in 1:7]
α = [-fns[i]/fns[i+1] for i in 1:5]
α

# Shortcut!
# El periodo 2^p/2 te lleva *justo* al punto que quieres!

shorts = [Qn(c2, 1)
 Qn(c4, 2)
 Qn(c8, 4)
 Qn(c16, 8)
 Qn(c32, 16)
 Qn(c64, 32)
 Qn(c128, 64)
] .|> fun .|> abs |> sort |> reverse
α2 = [-shorts[i]/shorts[i+1] for i in 1:5]
