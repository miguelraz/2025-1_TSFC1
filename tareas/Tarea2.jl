# # Tarea 2: Derivación automática

# ## Ejercicio 1

# Consideraren la siguiente definición de la derivada, que podemos llamar
# *derivada de paso complejo*:
# ```math
# f^\prime(x_0) \equiv \lim_{h\to 0} \textrm{Im}\left(\frac{f(x_0+i h)}{h}\right),
# ```
# donde $i^2 = -1$, e $\textrm{Im}(z)$ es la parte imaginaria de $z$.
#
# - Estudien el comportamiento del error de la derivada de paso complejo, como
# lo hicimos en clase, simulando el límite $h\to 0$.
#
# - Expliquen analíticamente los resultados numéricos obtenidos.
#
# NOTA: En caso de que se atoren, o que el tema les interese más, ver
# [este artículo](https://epubs.siam.org/doi/epdf/10.1137/S003614459631241X)
# y/o [esta liga](https://nhigham.com/2020/10/06/what-is-the-complex-step-approximation/).


#-
# ## Ejercicio 2
#
# - Definan una estructura en Julia `Dual` que represente a los números duales;
# los nombres de los campos internos serán `fun` y `der`.
# Por sencillez, pueden considerar que los campos de `Dual` son del tipo `Float64`,
# aunque pueden *osar* y atreverse a implementar el caso paramétrico `Dual{T <: Real}`,
# donde `T` es el tipo de *ambos* campos.
#
# - Sobrecarguen las operaciones de tal manera que las cuatro operaciones aritméticas
# que involucran dos `Dual`es, den el resultado que se espera.
#
# - Definan un método específico para crear duales (constructor externo), a partir de
# un sólo valor (en lugar de los dos requeridos), y que corresponderá a
# $\mathbb{D}_{x_0}c = (c, 0)$, donde $c$ es una constante (real).
#
# - Extiendan los métodos que permitan sumar/restar y multiplicar/dividir un
# número (`::Real`) y un `::Dual`. (Recuerden que ciertas operaciones son conmutativas!).
# NOTA: Este ejercicio lo pueden hacer escribiendo todos los métodos, uno a uno. Otra
# opción es usar `promote` y `convert` para definir reglas de promoción y conversión;
# [la documentación](https://docs.julialang.org/en/v1/manual/conversion-and-promotion/)
# tiene más información, por si este camino les interesa.
#
# - Definan las funciones `fun` y `der` que, al ser aplicadas a un `Dual` devuelvan
# la parte que corresponde a la función y la parte que corresponde a la derivada
# del `Dual`, respectivamente.
#
# - Incluyan varios casos (propuestos por ustedes mismos) donde se *compruebe*
# que lo que
# implementaron da el resultado que debería ser. Para esto, pueden usar la librería
# estándard [`Test`](https://docs.julialang.org/en/v1/stdlib/Test/) de Julia.


#-
# ## Ejercicio 3
#
# Definan una nueva función `dual(x_0)` cuyo resultado sea un `Dual` que corresponde
# a la variable independiente $x$ evaluada en `x_0`. Con esta función
# obtengan $f'(2)$ para la función
# $$
# f(x) = \frac{3x^2-8x+1}{7x^3-1}.
# $$


#-
# ## Ejercicio 4
#
# - A partir de lo visto en clase, *extiendan* las funciones `sin(a::Dual)`,
# `cos(a::Dual)`, `tan(a::Dual)`, `^(a::Dual, n::Int)`, `sqrt(a::Dual)`, `exp(a::Dual)`
# y `log(a::Dual)`, al igual que `a^n` (con `a::Dual` y `n::Int`).
#
# - Al igual que antes, construyan algún conjunto de pruebas que muestre, de manera
# sencilla, que lo que hicieron da lo que uno esperaría obtener.

