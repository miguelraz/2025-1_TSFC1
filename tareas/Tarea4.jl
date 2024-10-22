# # Tarea 4: Fractales y mapeos 2D

#-
# *NOTA**: Esta tarea incluye generar varias imágenes; **no** es
# necesario que las incluyan en su entrega, pero sí debe ser posible
# generarlas a partir de lo que entreguen (en .jl).


#-
# ## Ejercicio 1

# El método de Newton es iterativo, y en ese sentido se puede considerar como
# un mapeo dado por
# \begin{equation}
# z_{n+1} = N(z_n) = z_n - \frac{f(z_n)}{f'(z_n)}.
# \end{equation}
# Vamos a considerar la función \$f(z) = z^3-1\$, e iteraciones del mapeo
# \$N(z)\$, con \$z\in\mathbb{C}\$. Es claro que los ceros de \$f(z)\$, es decir,
# las \$z^*\$ tales que \$f(z^*)=0\$ tienen la propiedad de que \$N(z^*)=z_*\$,
# es decir, son puntos fijos del mapeo de Newton.
# En este caso concreto los ceros los podemos escribir como
# \$z^*_r = \exp(i 2\pi r/3)\$, con \$r=0, 1, 2\$.

# Vamos a considerar *muchas* condiciones iniciales
# \$z_0\in[-1,1]\times[-1,1]\subset \mathbb{C}\$, y
# para cada condición inicial iteraremos
# muchas veces el mapeo, por ejemplo, \$n=10,000\$ veces.
# (No es necesario guardar los iterados intermedios.) La idea es
# asignarle a cada condición inicial un color (azul, verde o rojo, por ejemplo)
# según el punto al que la condición inicial converge (el punto al
# que más se acerque \$z_n\$). Dibujen el mapa de colores que se obtiene.

# *Nota:* Para este ejercicio conviene guardar tres vectores (de condiciones
# iniciales), según el punto (color) al que convergen después de muchas iteraciones.
# Para graficar, dado que estamos en los complejos, se graficará la parte
# real y la parte imaginaria de cada condición inicial.

#-
# ## Ejercicio 2

# Vamos a considerar el siguiente mapeo lineal, en dos dimensiones, dado por

# \begin{equation}
# B(x_{n+1}, y_{n+1} ) =
# \left( \begin{array}{c} x_{n+1} \\ y_{n+1} \end{array} \right) =
# \left(\begin{array}{cc} a & b\\ c & d \end{array}\right)
# \left( \begin{array}{c} x_{n} \\ y_{n} \end{array} \right) +
# \left( \begin{array}{c} 0 \\ f \end{array} \right).
# \end{equation}

# Los coeficientes que aparecen en el mapeo se eligirán de manera aleatoria, con
# probabilidad $p$, de acuerdo con la siguiente tabla:

# |     p     |     a     |     b     |     c     |     d     |     f     |
# |:---------:|:---------:|:---------:|:---------:|:---------:|:---------:|
# |   0.01    |     0     |     0     |     0     |    0.16   |   0    |
# |   0.85    |  0.85     |     0.04  |   -0.04   |    0.85   |   1.6     |
# |   0.07    |  0.2      |    -0.26  |    0.23   |    0.22   |   1.6     |
# |   0.07    | -0.15     |     0.28  |    0.26   |    0.24   |   0.44    |

# Dibujen (en verde, usando `markerstrokecolor=:green`) el atractor del mapeo.


