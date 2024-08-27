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

# ---
#
# ## 3.
#
# Repitan el ejercicio anterior usando ahora, no el punto medio,
# sino 1/3 de la distancia entre el vértice elegido al azar y el iterado
# $Y_n$.
#