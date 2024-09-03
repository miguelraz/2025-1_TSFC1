# # Tarea 1

# ---
#
# ## 1. Triángulo de Pascal
#
# a. Generen el triángulo de Pascal, hasta cierto orden `ord`,
# usando una matriz de enteros, en la que cada renglón representa un orden
# distinto. Hagan que la apariencia de este renglón sea lo más simétrico posible.
#
# b. Usen la matriz creada para generar *otra*, en que todos los números
# pares aparezcan como `false` y los impares como `true`, o alternativamente
# como 0 y 1, respectivamente. Las funciones `isodd` o `iseven` pueden serles útiles.
#
# c. Dibujen (con puntos) todos los valores impares del triángulo de Pascal
# para `ord=256`. Repitan el ejercicio para `ord=1024`.
#
# NOTA: La parte `a` y `b` la pueden lograr con una función; si bien esto es cómodo
# pueden ir paso a paso.
function pascal(n)
           mat = zeros(Int, n+1,2n+1)
           mat[1, n + 1] = 1
           for i in 2:n+1
               for j in 2:2n
                   mat[i, j] = mat[i-1, j - 1] + mat[i - 1, j + 1]
               end
           end
           mat[n+1, 1] = 1
           mat[n+1, 2n + 1] = 1
           mat
       end

respuesta_b(n) = isodd.(pascal(n))

respuesta_b(256)
using UnicodePlots

spy(respuesta_b(256))

spy(respuesta_b(1024))

# ---
#
#  ## 2.
#
# Sean $X_1$, $X_2$ y $X_3$ los vértices de un triángulo equilátero.
# Implementen el siguiente algoritmo:
#
# a. Elijan al azar uno de los vértices $X_1$, $X_2$ y $X_3$, que llamaré $Y_0$.
# Guarden $Y_0$.
#
# b. En la iteración $r$, elijan al azar un vértice del triángulo $X_r$ (diferente a
# $Y_0$ en la primer iteración), y obtengan el punto medio de $Y_{r-1}$ y la $X_r$;
# el resultado lo etiquetaremos $Y_r$.
#
# c. Guarden el valor de $Y_r$.
#
# d. Repitan los pasos (b) y (c) del algoritmo usando como nuevo valor
# $Y_r$, guardando cada uno de los iterados.
#
# e. Grafiquen todos los iterados $Y_n$ que guardaron, considerando muuuuchos puntos.
distance(p1, p2) = sqrt((p1[1]-p2[1])^2 + (p1[2] - p2[2])^2)
midpoint(p1, p2) = ((p1[1] + p2[1])/2, (p1[2] + p2[2])/2)

function triangles(n, f)
    p1 = (-1.0, 0.0)
    p2 = (1.0, 0.0)
    p3 = (0.0, sqrt(3))
    tripoints = (p1, p2, p3)
    Y_n = Vector{Tuple{Float64, Float64}}(undef, n)

    # n == 1
    Y_n[1] = f(p1, p3)

    # n == 2
    Y_n[2] = f(p2, Y_n[1])

    @inbounds for i in 3:n
        temp_point = rand(tripoints)
        Y_n[i] = f(temp_point, Y_n[i-1])
    end
    Y_n
end

Y_ns = triangles(10_000, midpoint)

scatterplot(first.(Y_ns), last.(Y_ns))
# ---
#
# ## 3.
#
# Repitan el ejercicio anterior usando ahora, no el punto medio,
# sino 1/3 de la distancia entre el vértice elegido al azar y el iterado
# $Y_n$.
#
tripoint(p1, p2) = ((p1[1] + p2[1])/3, (p1[2] + p2[2])/3)

Y_ns_tripoints = triangles(10_000, tripoint)

scatterplot(first.(Y_ns_tripoints), last.(Y_ns_tripoints))