# # Mapeos

# ## Mapeos como sistemas dinámicos

# Los mapeos son aplicaciones (funciones) $F_\mu : \mathbb{R}^N \rightarrow \mathbb{R}^N$,
# donde $N$ es la dimensionalidad del espacio fase que representa el espacio
# de variables *dinámicas* de interés. (Aquí, escribí que $x\in\mathbb{R}^N$
# para ser concretos; uno puede considerar otros conjuntos como dominios
# del mapeo, como por ejemplo los complejos).
# La idea es definir la dinámica de $x\in\mathbb{R}^N$ a través de la función
# $F_\mu$ y sus iterados, o aplicaciones repetidas, es decir,
# $$
# x_{n+1} = F_\mu (x_n).\tag{1}
# $$

# En (1), $\mu$ representa uno o varios parámetros que uno puede variar,
# y $x_n$ representa
# el estado del sistema al "tiempo discreto" $n$. La idea de introducir mapeos es evitar las
# complicaciones que surgen al resolver ecuaciones diferenciales, lo que involucraría un
# "tiempo continuo", pudiendo aislar los aspectos importantes que definen las
# propiedades dinámicas del sistema.

# Una suposición *importante* que haremos sobre $F_\mu$ es que es una función que **no**
# involucra ningún tipo de variable estocástica o aleatoria. Partiendo de esta suposición,
# diremos que el sistema es determinista: el estado al "tiempo" $n+1$ sólo depende del
# estado al tiempo $n$ y de los parámetros $\mu$ del mapeo, que consideraremos constantes
# respecto al tiempo.

# Entonces, *iterar* la función $F_\mu(x_0)$ significa evaluarla, una y otra vez, de
# manera repetida, a partir de un valor $x_0$ que llamaremos *condición inicial*.
# De manera concisa, escribiremos $x_n = F^n_\mu(x_0) = F_\mu(F_\mu(...(F_\mu(x_0))...))$.
# Otra manera de escribir esto mismo es escribiendo explícitamente cada iterado, es decir,
# $x_1=F_\mu(x_0)$ representa al primer iterado, $x_2=F_\mu(x_1)=F^2_\mu(x_0)$ al segundo,
# y en general el $n$-ésimo iterado lo escribiremos $x_n=F_\mu(x_{n-1})=F^n_\mu(x_0)$.

# Como ejemplo, consideraremos $F(x)=x^2+1$, y tendremos que
# $$
# \begin{align*}
# x_1 & = F(x_0) = x_0^2+1, \\
# x_2 & = F^2(x_0) = (x_0^2+1)^2+1,\\
# x_3 & = F^3(x_0) = ((x_0^2+1)^2+1)^2+1,\\
# x_4 & = F^4(x_0) = (((x_0^2+1)^2+1)^2+1)^2+1,\\
# \vdots
# \end{align*}
# $$


# Es claro que la notación $F^n(x)$ no significa la potencia $n$ del mapeo, si no el
# $n$-ésimo iterado del mapeo, a partir de la condición inicial $x$.

# ## Órbitas

# A la secuencia (¡ordenada!) de los iterados la llamaremos *órbita*, esto es,
# la órbita viene dada por la secuencia $x_0, x_1, x_2, \dots$.
# Así, para el ejemplo anterior con $x_0=0$ tendremos
# $x_1=1$, $x_2 = 2$, $x_3 = 5$, $x_4 = 26$, etc. Intuitivamente podemos decir que
# esta órbita tiende a infinito, ya que el valor del $n$-ésimo iterado aumenta,
# y el siguiente involucrará elevarlo al cuadrado y sumarle 1.

# Hay varios tipos de órbitas. Algunas, como vimos antes, pueden diverger;
# eso depende no sólo del el mapeo (y del valor del parámetro), sino también
# de la condición inicial.
# Otras órbitas no cambian: son los puntos fijos del mapeo, o soluciones
# estacionarias. Los puntos fijos, evidentemente, satisfacen la ecuación
# $$
# F_\mu(x) = x.\tag{2}
# $$
# En otras palabras, cada iterado coincide consigo mismo.

# Por ejemplo, para el mapeo $G(x)=x^2-x-4$, los puntos fijos satisfacen $x^2-2x-4=0$, de
# donde concluímos que hay dos soluciones, $x_\pm = 1\pm\sqrt{5}$.
# Por otra parte, para $F(x) = x^2+1$ ($x\in\mathbb{R}$), la ecuación (2)
# lleva a $x^2+1=x$ que no tiene solución (en los reales), por lo que no hay puntos fijos.
# De hecho, esta es la razón por la que todas las
# órbitas divergen a $+\infty$. (Otra manera de formular esto último, menos rigurosa, es
# que el único punto fijo *atractivo* es $+\infty$; es una formulación menos rigurosa ya
# que $\infty\not\in\mathbb{R}$.)

# Numéricamente, verificar si cierta condición inicial es un punto fijo de un mapeo es
# sencillo, pero también delicado. Concretamente, para $G(x)$ definido arriba debemos
# verificar, por ejemplo, si el iterado $G(x_+)$ es $x_+$, y lo mismo para $x_-$.

G(x) = x^2 - x - 4  # definimos G(x)

#-
x₊ = 1 + sqrt(5)    # condición inicial, x\_+<TAB>

G(x₊) - x₊ == 0

#-
x₋ = 1 - sqrt(5)    # condición inicial, x\_-<TAB>

G(x₋) - x₋ == 0

# El resultado anterior parece indicar que el iterado $G(x_-)$ no es $x_-$, lo
# que entonces implica que $x_-$ no es un punto fijo, lo que es incorrecto,
# como demostramos arriba; esto simplemente muestra que la verificación
# numérica es delicada. La razón por la que no
# obtenemos el resultado "esperado" son los errores numéricos
# asociados al truncamiento y redondeo: los *números de punto flotante*
# simulan los números reales, pero no son los números reales.
# Usando números de precisión extendida vemos que usando más bits de precisión,
# $G(x_-) - x_-$ se acerca más a cero.

G(x₋) - x₋ # Resultado con números de punto flotante de 64 bits

#-
precision(BigFloat)  # Bits de precisión default de `BigFloat`

#-
bx₋ = 1-sqrt(BigInt(5))
G(bx₋) - bx₋

# Otro tipo de órbitas que son importantes y de interés
# son las órbitas periódicas. En este caso tenemos
# que una secuencia *finita* de iterados se repite a partir de cierta iteración:
# $x_0, x_1, \dots, x_{n-1}, x_0, x_1, \dots$, i.e., $x_n = x_0$.
# El menor número *positivo* de iterados de una órbita periódica,
# tal que se hace aparente su periodicidad, se llama *periodo*.
# Entonces, cada punto de dicha órbita (periódica) es periódico con periodo $n$,
# ya que $x_r=x_{r+n}$. Vale la pena notar que los puntos fijos son órbitas periódicas
# de periodo 1.

# Un punto que pertenece a una órbita de periodo $n$ satisface la ecuación
# $$
# F^n(x_0) = x_0.\tag{3}
# $$
# Claramente, de la ecuación (3) concluimos que un punto de periodo
# $n$ del mapeo $F$ es un punto fijo (de periodo 1) del mapeo definido por la función $F^n$.
# Además, la ecuación (3) tiene *al menos* $n$ soluciones distintas.

# Un punto $x_0$ se llama *eventualmente periódico* cuando sin ser punto fijo o periódico,
# después de un cierto número *finito* de iteraciones, los iterados pertenecen a
# una órbita periódica.
# Un ejemplo, nuevamente para el mapeo $G(x)=x^2-1$, es $x_0=1$: $G(1)=0$, $G(0)=G^2(1)=-1$,
# $G(-1)=G^3(1)=0$, etc. Es decir, $x_0=1$ en sí no pertenece a la órbita periódica, aunque
# sus iterados, a partir de $x_1$, sí y forman una órbita de periodo 2.

# En sistemas dinámicos típicos, la mayoría de los puntos no son fijos, ni periódicos,
# ni eventualmente periódicos. Por ejemplo, el mapeo $T(x)=2x$ tiene como punto fijo
# único, $x^*=0$. Cualquier otra órbita tiende a $\;\pm\infty$, ya que
# $T^n(x_0) = 2^n x_0$ y entonces $|T^n(x_0)|\to\infty$.

# En general, la situación es aún más compleja... e interesante.


# ## Análisis gráfico

# En lo que sigue ilustraremos una manera gráfica de visualizar la
# dinámica de mapeos en 1 dimensión, usando la paquetería `Plots.jl` de Julia.

using Pkg
Pkg.activate(".")

using Plots


# La idea del análisis gráfico es poder visualizar los iterados de una órbita. En el eje
# de las abscisas (eje "x") dibujaremos $x_n$ y en el de las ordenadas dibujaremos a su
# iterado, es decir, $F(x_n)$. Entonces, para localizar $x_{n+1}$ simplemente
# necesitamos la gráfica de $y=F(x)$.

# Usaremos como ejemplo: $F(x) = \sqrt{x}$, con la condición inicial
# $x_0=3.8$, y calcularemos su iterado.

x0 = 3.8 #5.0*rand()
x1 = sqrt(x0)
x0, x1

#-
#Dominio (en x) para la gráfica
domx = 0.0:1/32:5.2


#Dibuja F(x) y define escalas, etc. Usa `domx` para generar
#puntos que se usan para pintar la función `sqrt`
plot(domx, sqrt,
    xaxis=("x", (0.0, 5.0), 0:5.0),
    yaxis=((0.0, 3.0), "F(x)"),
    legend=false, title="F(x)=sqrt(x)", grid=false)

#Lo siguiente une los puntos (x_0, 0), (x0, x1=F(x0))
#y (0, x1) con rectas entre ellos, en la misma gráfica!
plot!([x0, x0, 0.0], [0.0, x1, x1], color=:orange)

#Dibuja el punto (x0, x1)
scatter!([x0], [x1], color=:orange, markersize=2)

# Como se trata de *iterar* de manera repetida, lo que ahora
# requerimos es, en algún sentido, tener a $x_1$ (como nueva condición
# inicial) en el eje `x`. Para esto usamos la identidad, i.e., la
# recta $y=x$. Noten el ligero cambio para que los ejes y el título
# aparezcan más agradables.

#Dibuja F(x) y define escalas, etc
plot(domx, sqrt,
    xaxis=("x", (0.0, 5.0), 0:5.0),
    yaxis=((0.0, 3.0), "F(x)"),
    legend=false, title="F(x)=sqrt(x)", grid=false)

#Dibuja la identidad; en este caso, usamos la función anónima `x->x`
plot!(domx, x->x, color=:purple)

#Dibuja, y une por rectas, los puntos: (x0,0), (x0,x1), (0,x1)
plot!([x0, x0, 0.0], [0.0, x1, x1], color=:orange, lw=2.0)

#A partir del último punto (0,x1), dibuja (x1,x1) y (x1,0)
plot!([0.0, x1, x1], [x1, x1, 0.0], line=(:green, :dash, 2.0, 0.4))

#Dibuja los puntos (x0, x1) y (x1, x1) con un marcador más grande
scatter!([x0, x1], [x1, x1], color=:orange, markersize=2)

# Dado que tenemos $x_1$ en el eje $x$, el mismo proceso de antes
# puede ser implementado para obtener $x_2$, o cualquier otro iterado $x_n$.
# Vale la pena notar que, una vez que estamos en la diagonal, podemos ir
# *directamente* a la función $F(x)$ para obtener $x_2$, y nuevamente a la
# diagonal y a la función para tener $x_3$, etc.

x2 = sqrt(x1)

#Dibuja F(x) y define escalas, etc
plot(domx, sqrt,
    xaxis=("x", (0.0, 5.0), 0:5.0),
    yaxis=((0.0, 3.0), "F(x)"),
    legend=false, title="F(x)=sqrt(x)", grid=false)

#Dibuja la identidad
plot!(domx, x->x, color=:red)

#Dibuja (x0,0), (x0,x1), (x1,x1), (x1,x2), (x2,x2)
plot!([x0, x0, x1, x1, x2], [0.0, x1, x1, x2, x2],
    line=(:orange, :dash, 2.0))

#Dibuja los puntos (x0, x1), (x1, x1), (x1, x2), (x2, x2)
scatter!([x0, x1, x1, x2], [x1, x1, x2, x2],
    color=:orange, markersize=2)

# Seremos ahora un poco más sistemáticos, y definiremos una función,
# `itera_mapeo`, cuyos argumentos son la función `f`, la condición
# inicial `x0` y el *entero* `n` de iteraciones del mapeo.
# La función regresa un vector que describe la secuencia de iterados
# (y la condición inicial). Incluímos *docstrings*
# para documentar cada función.

"""
    itera_mapeo(f, x0, n)

Itera la función \$x->f(x)\$ (de una dimensión) `n` veces a partir de la
condición inicial `x0`. Regresa un vector que contiene los
iterados de manera sucesiva.
"""
function itera_mapeo(f, x0, n::Int)
    #Defino el vector de salida (de `Float64`s)
    its = Float64[x0]
    #Obtengo los iterados
    for i=1:n
        x1 = f(x0)
        push!(its, x1)
        x0 = x1
    end
    return its
end

# Definimos unos tests, muy sencillos, útiles para checar que las cosas
# hacen lo que queremos que hagan.

using Test
let
    nits = 2
    xs = itera_mapeo(x->sqrt(x), 16.0, 2)
    @test xs == [16.0, 4.0, 2.0]
    @test typeof(xs) == Vector{Float64}
end

# Ahora definimos la función `analisis_grafico` de tal manera que usándola
# se obtenga el tipo de gráficas que generamos arriba. Esto es, que se grafique
# el mapeo `F` y la identidad, como hicimos antes, y los `n` siguientes
# iterados a partir de la condición inicial `x0`. El argumento (opcional)
# `domx` debe especificar la región (en $x$) que se grafica.

"""
    analisis_grafico(F::Function, x0::Float64, n::Int)

Implementa el análisis gráfico para la función \$x->F(x)\$,
usando la condición inicial `x0` y `n` iteraciones.
Internamente se llama a `analisis_grafico!`
"""
function analisis_grafico(f, x0::Float64, n::Int, domx=0.0:1/128:1.0)
    #Graficamos x->F(x) y x->x
    Plt1 = plot(domx, x->f(x),
        xaxis=("x", (domx[1], domx[end])),
        yaxis=("f(x)", (f(domx[1]), f(domx[end]))),
        color=:blue, legend=false, grid=false)

    plot!(Plt1,
        domx, identity, color=:blue, linestyle=:dash)

    #Se grafican los iterados
    analisis_grafico!(Plt1, f, x0, n, domx)

    return Plt1
end

#-
"""
    analisis_grafico!(Plt1, f::Function, x0::Float64, n::Int)

Modifica la gráfica `Plt1` iterando el mapeo \$x->f(x)\$,
a partir de la condición inicial `x0`, usando `n` iterados.
La gráfica se hace considerando `domx` como el dominio.
"""
function analisis_grafico!(Plt1, f::F, x0::Float64, n::Int,
        domx=0.0:1/128:1.0; color=:orange) where {F}
    #Calculamos los iterados
    its = itera_mapeo(x->f(x), x0, n)

    # Se crean los vectores que se usarán para la gráfica
    vx = Array{Float64}(undef, 2*length(its) + 1)
    vy = Array{Float64}(undef, 2*length(its) + 1)
    vx[1] = its[1]
    vy[1] = 0.0

    for (i, x0) in enumerate(its)
        i == lastindex(its) && break
        ii = 2*i
        vx[ii] = its[i]
        vx[ii+1] = its[i+1]
        vy[ii] = its[i+1]
        vy[ii+1] = its[i+1]
    end

    #Graficamos los iterados
    plot!(Plt1, vx, vy, line=(color, :dash, 2.0),
        markershape=:circle, markercolor=color,
        markerstrokecolor=color)

    return Plt1
end

# Ejemplificamos las funciones con $F(x)=\sqrt{x}$, con tres condiciones iniciales.

Plt1 = analisis_grafico(x->sqrt(x), 5.0, 4, 0.0:1/32:5.2);
analisis_grafico!(Plt1, x->sqrt(x), 0.1, 4, 0.0:1/32:5.2,
    color=:red)
analisis_grafico!(Plt1, x->sqrt(x), 3.6, 4, 0.0:1/32:5.2,
    color=:green)

# Claramente, del análisis gráfico, podemos ver que el punto $x=1$ es un punto
# (linealmente) estable, atractivo; por otra parte, y aunque esto es menos
# obvio, el punto $x=0$ es un punto (linealmente) inestable, repulsivo.

# ## Puntos fijos

# El análisis gráfico es útil pero definitivamente no es riguroso. Esto se puede
# deber a cuestiones de precisión numérica o simplemente a que el número de
# iteraciones es finito y podría ser insuficiente.

# Un resultado riguroso (¡teorema!) que es útil para encontrar puntos fijos es el
# **teorema del valor intermedio**: Supongamos que $F:[a,b]\to\mathbb{R}$ es
# una función *continua*, y que $y_0$ se encuentra entre $F(a)$ y $F(b)$.
# Entonces, existe un punto en $x_0\in[a,b]$ tal que $F(x_0)=y_0$.

# Una consecuencia de este teorema es el teorema del punto fijo.

# **Teorema del punto fijo:** Supongamos que $F:[a,b]\to[a,b]$ es una función
# *continua*. Entonces, existe un punto fijo de $F(x)$ en $[a,b]$.

# Algunos comentarios:

# - El teorema asienta la *existencia* de un punto fijo; puede haber más.

# - El teorema asume que $F$ es *continua* y que mapea el intervalo $[a,b]$ en si mismo.

# - El intervalo $[a,b]$ es *cerrado*.

# - El teorema **no** dice cómo encontrar a los puntos fijos.

# La *demostración* se basa en aplicar el teorema del valor medio para la
# función $H(x)=F(x)-x$, y mostrar que existe un valor $x_0$ tal que $H(x_0)=0$.
# $H(x)$ es continua en el intervalo $[a,b]$ (así que se satisfacen las hipótesis
# del teorema del punto intermedio) y satisface $H(a) = F(a)-a \ge 0$ y
# $H(b)=F(b)-b\le 0$. (Estas propiedades se satisfacen ya que $F:[a,b]\to[a,b]$.)
# $\Box$

# ## Estabilidad

# A fin de entender el comportamiento *cerca* de un punto fijo, estudiaremos
# ahora mapeos lineales. La idea de estudiar un mapeo lineal es que éste constituye
# la primer aproximación en una series de Taylor (la linearización de algo más
# complicado), cerca de un punto fijo. Para hacer las cosas más sencillas,
# consideraremos que el punto fijo es el cero, y el mapeo tiene la forma:

# $$
# F_\alpha(x) = \alpha x.\tag{4}
# $$


# ### (a) $0<\alpha <1$.

#=
Definición del mapeo; noten que incluimos a la pendiente como
argumento de la función
=#
f(x, α) = α * x

#-
plt2 = analisis_grafico(x->f(x, 0.6), 0.8, 20, -1:1/32:1)
analisis_grafico!(plt2, x->f(x, 0.6), -0.8, 20, -1:1/32:1,
    color=:green)

# Como se puede observar, los iterados de ambas condiciones iniciales
# convergen a 0, que es el punto fijo;
# en algún sentido, para $0<\alpha<1$ el punto fijo los *atrae*.

x1 = itera_mapeo(x->f(x, 0.6), 0.8, 20)
x2 = itera_mapeo(x->f(x, 0.6), -0.8, 20)
x1[end], x2[end]


# ### (b) $\alpha>1$.

# De igual forma que lo hicimos antes:

x3 = itera_mapeo(x->f(x, 1.6), 0.08, 8)
x4 = itera_mapeo(x->f(x, 1.6), -0.08, 8)

plt3 = analisis_grafico(x->f(x, 1.6), 0.08, 8, -1:1/32:1)
analisis_grafico!(plt3, x->f(x, 1.6), -0.08, 8, -1:1/32:1, color=:green)

# En este caso, con $\alpha > 1$, observamos que los iterados *se alejan* del
# punto fijo; uno dice que el punto fijo los *repele*.

x3[end], x4[end]

# ### Caso general

# Para un mapeo lineal $x_{n+1}=\alpha x_n$, el mapeo define una sucesión
# geométrica. Entonces, el $n$-ésimo iterado vendrá dado por:

# $$
# x_n = \alpha x_{n-1} = \dots = x_0 \alpha^n.\tag{5}
# $$

# De aquí es claro que, si $|\alpha|<1$, el límite cuando $n\to\infty$ es 0,
# el punto fijo. En este caso decimos que el punto fijo es **linealmente
# estable**.
# La diferencia entre el caso con $\alpha$ positiva o negativa radica en la
# *forma* en la que los iterados se acercan al punto fijo: si $\alpha>0$ los
# iterados se acercan de un mismo lado, mientras que si $\alpha<0$, los iterados
# se acercan a 0, alternando el signo.

# Por otra parte, si $|\alpha|>1$, el límite cuando $n\to\infty$ es $\infty$,
# es decir, los iterados se alejan del punto fijo. En este caso diremos
# que el punto es **linealmente inestable**.

# El análisis que hemos desarrollado aquí lo hicimos para mapeos lineales
# de la forma $x_{n+1} = F_\alpha(x_n)=\alpha x_n$, pero es útil más
# allá de los mapeos lineales.
# Como dijimos arriba, cualquier mapeo $F(x)$, alrededor de su punto
# fijo, lo podemos escribir a primer orden como

# $$
# F(x_* + \delta) = x_* + \delta F'(x_*) + \cal{O}(\delta^2),\tag{6}
# $$

# que precisamente es un mapeo lineal en $\delta$, donde el equivalente
# de la pendiente $\alpha$, utilizada arriba, es $F'(x_*)$. Esto es,
# las propiedades de estabilidad *lineal* están dadas por el valor de
# la derivada del mapeo, evaluada en el punto fijo.

# ## Puntos periódicos

# De la misma manera que para los puntos fijos, los puntos periódicos se pueden
# clasificar en atractivos, repulsivos o neutros. Básicamente, esto es consecuencia de
# que cada punto periódico $\tilde{x}$, de periodo $p$, del mapeo $F(x)$, es un
# *punto fijo* del mapeo $\tilde{x} = F^p(\tilde{x})$, como mostramos anteriormente.

# Un ejemplo sencillo e ilustrativo de esto es el mapeo $F(x)=x^2-1$, definido
# en el intervalo $[-1,1]$. Claramente, este mapeo tiene tiene una órbita de periodo 2
# dada por $0, -1, 0, -1, \dots$. Cada uno de estos puntos, son puntos fijos de

# $$
# F^2(x) = F(F(x)) = x^2-1)^2-1 = x^2 (x^2-2),\tag{7}
# $$

# esto es, ambos puntos (¡y sólo ellos!) satisfacen la ecuación

# $$
# F^2(x) - x = x(x^3-2x-1) = x(x+1)(x^2-x-1) = 0.\tag{8}
# $$

f1 = x -> x^2-1        # Primer iterado
f2 = x -> f1(f1(x))    # Segundo iterado

#-
plot(-1:1/32:1, f1,
    xaxis=("x", (-1.1, 1.1)),
    yaxis=("F(x), F^2(x)", (-1.03,0.28)),
    label="F(x)", grid=:false, legend=(0.78, 0.94), background_color_legend=:transparent,
    color=:blue)

plot!(-1:1/32:1, f2, xaxis=("x", (-1.1, 1.1)),
    label="F^2(x)", color=:red)

plot!(-1:1/16:1, identity, xaxis=("x", (-1.1, 1.1)), label="Id(x)",
    color=:green)

# Es claro de las gráficas que $(F^2)'(0)=(F^2)'(-1)=0$. Ambos puntos son
# puntos fijos atractivos para el mapeo $F^2(x)$; el otro punto fijo
# del mapeo $F^2(x)$, $x_* = (1-\sqrt{5})/2$, es repulsivo, ya que su
# pendiente es mayor a 1, que es la pendiente de la identidad.
# Vale la pena notar que $x_*$ es el único punto fijo de periodo 1,
# dado que satisface $F(x_*)-x_* = x_*^2-x_*-1 = 0$.

# Entonces, puntos que inician suficientemente cerca de 0 o de -1 serán atraídos
# a estos puntos bajo el mapeo $F^2(x)$. Bajo el mapeo $F$, puntos
# suficientemente cerca de 0 o -1, se acercarán paulativamente a ellos,
# al considerar cada segundo iterado.

# Es claro que el concepto de estabilidad se puede extender a los puntos de
# periodo $n$. Cuantitativamente, debemos evaluar la derivada de $F^n(x)$ en
# algún punto de la órbita periódica. Entonces, debemos calcular la derivada del
# mapeo $F^n(x)$. Consideremos como ejemplo el caso $F^2(x)$ primero. En este
# caso, tenemos $F^2(x)=F(F(x))$, y denotaremos a los puntos de periodo 2 como
# $x_0$ y $x_1$. Entonces, usando la regla de la cadena obtenemos:

# $$
# \frac{\textrm{d}F^2(x_0)}{\textrm{d}x} = \frac{\textrm{d}F(F(x_0))}{\textrm{d}x} = F'(F(x_0)) F'(x_0) = F'(x_1) F'(x_0).\tag{9}
# $$

# De igual manera, considerando los puntos de periodo 3 tenemos,
# $F^3(x)=F(F^2(x))$ y obtenemos:

# $$
# \frac{\textrm{d}F^3(x_0)}{\textrm{d}x} =
# F'(F^2(x_0)) (F^2)'(x_0) = F'(x_2) F'(x_1) F'(x_0).\tag{10}
# $$

# Esto se generaliza de manera evidente, y es fácil demostrar que se cumple

# $$
# \frac{\textrm{d}F^n(x_0)}{\textrm{d}x} = (F^n)'(x_0) =
# F'(x_{n-1})\cdots F'(x_1)F'(x_0).\tag{11}
# $$

# De esta última relación vemos que **todos** los iterados de una órbita periódica de
# periodo $n$ tienen la misma derivada *respecto* al mapeo $F^n$, i.e.,
# $(F^n)'(x_0)=(F^n)'(x_1)=\dots=(F^n)'(x_{n-1})$.
# Por lo tanto, todos los puntos ligados por una órbita periódica
# son atractivos o repulsivos.


# ## Un anti-ejemplo

# El mapeo de desplazamiento (o doblamiento) de Bernoulli, es el mapeo
# definido en $[0,1]\to[0,1]$ por
# $$
# x_{n+1} = \sigma(x_n) = 2x_n\mod 1.\tag{12}
# $$
# La gráfica de este mapeo es muy sencilla: consiste en las dos rectas
# paralelas de pendiente 2, $y=2x$ si $x\in [0,0.5)$ y,
# $y=2x-1$ si $x\in [0.5,1]$, como se ilustra en la gráfica.

plot(0:1/32:1/2, x->2*x, linewidth=3, color=:blue, label="y=2x")
plot!(1/2:1/32:1, x->2*x-1, linewidth=3, color=:blue, label="y=2x-1")
plot!(0:1/32:1, x->x, linewidth=1, linestyle=:dash, color=:red, label="y=x")
scatter!([0.5, 1.0], [0.0, 0.0], color=:blue,
    markerstrokecolor=:blue, marker=:circle,markersize=3, label="")
scatter!([0.5, 1.0], [1.0, 1.0], color=:white,
    markerstrokecolor=:blue, marker=:circle,markersize=3, label=:none)


# En este apartado analizaremos la dinámica del mapeo (12), ilustrando las
# nociones que hemos visto aquí, como los puntos de equilibrio (o de periodo 1) del mapeo,
# su estabilidad local, algunas órbitas periódicas y no periódicas. Estudiaremos además su implementación en la computadora.


# ### Puntos de equilibrio y su estabilidad

# De la figura anterior, o al resolver $\sigma(x_n) = x_n$, claramente tenemos que el único
# punto de equilibrio en $[0,1]$ es $x_*=0$; $x=1$ no es punto fijo ya que, como lo hemos
# definido aquí, se mapea en $\sigma(1)=0$.
# Tomando la derivada del mapeo y evaluándola en
# $x_*$ obtenemos 2, obviamente; dado que este valor es en valor absoluto mayor que 1,
# tenemos que $x_*=0$ es linealmente inestable.

# Este resultado lo podemos también ilustrar inspeccionando algunos iterados que
# inician cerca del punto de equilibrio, como se ilustra a continuación.

σ(x) = mod(2*x, 1) # definición del mapeo de Bernoulli
                   # σ se obtiene con \sigma[TAB]

x0 = 1/1024
println("n = ", 0, "   x_n = ", x0)
for n = 1:4
    xn = σ(x0)
    x0 = xn
    println("n = ", n, "   x_n = ", xn)
end

# ### Órbitas periódicas

# Uno puede verificar que el mapeo $\sigma(x)$ tiene muchas órbitas periódicas.
# Por ejemplo, $\sigma(1/3)=2/3$ y $\sigma(2/3)=1/3$, lo que constituye una órbita de
# periodo 2.
# De manera similar $\sigma(1/5) = 2/5$, $\sigma(2/5) = 4/5$, $\sigma(4/5) = 3/5$,
# $\sigma(3/5)=1/5$ ilustra un ciclo de periodo 4.

# Es fácil obtener en este caso la fórmula explícita del mapeo de periodo 2,
# $\sigma^2(x) = \sigma(\sigma(x))$.
# Usando la definición, Eq. (12), es fácil obtener
# $$
# \sigma^2(x) =
# \begin{cases}
# 4x,  & 0\le x < 1/4,\\
# 4x-1,& 1/4\le x < 1/2,\\
# 4x-2,& 1/2\le x < 3/4,\\
# 4x-3,& 3/4\le x < 1,\\
# \end{cases}\tag{13}
# $$
# que de manera compacta corresponde a $\sigma^2(x)=4x\mod 1$.
# A partir de $\sigma^2(x)=x$ y usando (13), obtenemos los puntos
# de periodo 2, que corresponden a 0 (que es el punto fijo) y a $1/3$ y $2/3$.
# Al igual que para el punto fijo, los puntos de periodo 2 son linealmente inestables.

# Uno puede generalizar fácilmente la Eq. (13) a cualquier periodo
# $n$, obteniendo $\sigma^n(x) = 2^n x \mod 1$.
# Claramente, esto conlleva a considerar al dominio en términos de los $2^n$
# subintervalos $[r/2^n, (r+1)/2^n)$, con $r=0, \dots,2^n-1$.
# Más allá de las fórmulas concretas, vemos que *todas* las órbitas periódicas
# son inestables, ya que su derivada es $2^n$ ($n \ge 1$). El mapeo, si bien es cerrado,
# es localmente inestable en todo su dominio.

# ### Dinámica

# Ahora, consideraremos la dinámica usando varias condiciones iniciales tomadas
# al azar, y veremos su evolución después de muchos iterados, 1000 para ser concretos.
# La idea será, a partir de los resultados obtenidos, saber a qué tipo de órbita
# (punto fijo, punto periódico, órbita aperiódica) tienden las condiciones iniciales.
# Para esto último, guardaremos los siguientes 10 iterados (después de los
# 1000 iniciales).

#| code-fold: false

it0 = Array{Float64}(undef, 10)
itn = Array{Float64}(undef, 10, 10)
for ic = 1:10
    x0 = rand()
    it0[ic] = x0
    println("ic = ", ic, "   x_0 = ", x0)
    for its = 1:1000
        xn = σ(x0)
        x0 = xn
    end
    for its = 1:10
        xn = σ(x0)
        x0 = xn
        itn[its, ic] = x0
    end
end

itn

# El resultado es incómodamente extraño. Arriba, argumentamos (con matemáticas sólidas)
# que el mapeo es localmente inestable en todo punto; por otro lado, el resultado
# anterior muestra que todas las condiciones iniciales terminan en 0, que es un punto fijo
# (localmente inestable). La contradicción es muy clara...


# ### Entendiendo a la computadora

# Para aclarar qué pasa, reharemos el mismo ejercicio usando $x=1/3$ como condición
# inicial, sabiendo que es un punto fijo de periodo 2.

#| code-fold: false

x0 = 1/3
println("   x_0 = ", x0)
for its = 1:1000
    xn = σ(x0)
    x0 = xn
end
for its = 1:10
    xn = σ(x0)
    x0 = xn
    println("n = ", its, "   x_n = ", xn)
end

# Al igual que antes, vemos que *también* $x_0=1/3$ termina en 0; esto evidentemente es
# incorrecto, lo que nos hace sospechar que quizás estamos cayendo en problemas
# de precisión numérica en los cálculos. De hecho, este es el caso, y esas inestabilidades
# numéricas hacen que la computadora de resultados sencillamente incorrectos al usar
# números flotantes.

# Para ilustrar esto, primero, repetiremos el ejercicio usando en el cálculo números racionales.

x0 = 1//3
println("   x_0 = ", x0)
for its = 1:1000
    xn = σ(x0)
    x0 = xn
end
for its = 1:10
    xn = σ(x0)
    x0 = xn
    println("n = ", its, "   x_n = ", xn)
end

# Claramente, las matemáticas son correctas, y podemos confiar en la computadora
# (si usamos números racionales), al menos en este caso. Para ilustrar qué ocurre
# al usar números de punto flotante, imprimiremos los primeros 10 iterados (de $x_0=1/3$)
# y los 10 iterados siguientes a partir de $n=46$; además, en lugar de usar la representación de número flotante de los iterados, imprimiremos su representación
# interna en la computadora.

x0 = 1/3
println("n = ", 0, "   x_n = ", bitstring(x0))
for its = 1:55
    xn = σ(x0)
    x0 = xn
    (its < 10 || its > 45) && println("n = ", its, "   x_n = ", bitstring(xn))
end

# Los resultados muestran que, a partir de la segunda iteración, aparecen ceros en
# la cola del número de punto flotante (bits con menor precisión), como consecuencia
# del redondeo, y que paulativamente (cada segundo iterado) crece el número de ceros
# en la cola. Esto, literalmente borra un bit de precisión, hasta que todos los bits
# son cero, es el número calculado entonces es una potencia exacta de 2, y el mapeo lo
# lleva al 0.

# ### Resultados analíticos

# Ahora, haremos una descripción analítica de la dinámica del mapeo de Bernoulli.
# Como observamos antes, las potencias de 2 son importantes para definir el
# $n$-ésimo iterado del mapeo. Por esto, en esta sección, usaremos base 2 para
# entender la dinámica del mapeo.
# Así, cualquier condición inicial $x_0\in [0,1)$ la podemos representar,
# en su desarrollo *binario*, como
# $$
# x_0 = 0.a_1 a_2 a_3 \dots a_n \dots,\tag{14}
# $$
# donde, dado que estamos usando base 2, tenemos que $a_k$ es 0 o 1. Por ejemplo, si $x_0 < 1/2$ tendremos que $a_1=0$, y si $x_0 \ge 1/2$ entonces $a_1=1$.

# Ahora explotaremos la representación binaria (14) para entender la
# dinámica; ésta, para la condición inicial, corresponde a $x_0 = \sum_{k=1} a_k 2^{-k}$.
# Como explicamos anteriormente, el mapeo (12) equivale a
# $x_{n+1}=2x_n$ si $x_n\le 1/2$, o $x_{n+1}=2x_n-1$ si $x_n> 1/2$.
# Entonces, si $a_1=0$ tenemos que $x_1 = 2x_0 = 0.a_2 a_ 3 \dots a_n \dots$,
# dado que multiplicar por 2, en este caso, resulta en $\sum_{k=2} a_k 2^{-k+1}$.
# Por otro lado, si $a_1=1$ entonces
# $x_1 = 2x_0 - 1 = 1.a_2 a_ 3 \dots - 1 = 0.a_2 a_ 3 \dots $, también.
# En otras palabras, independientemente del valor de $a_1$, la representación de
# $x_1$ corresponde a mover *el punto binario* una posición hacia la derecha, y
# desechar el primer valor.
# Es por esto que el mapeo de Bernoulli se conoce como el desplazamiento de Bernoulli.

# Como consecuencia de lo anterior, la representación del $n$-ésimo
# iterado corresponde a
# $$
# x_n = \sigma^n(x_0) = 0.a_{n+1} a_{n+2} \dots.\tag{15}
# $$

# La Eq. (15) nos permite entender la dinámica de manera muy precisa,
# y también los resultados numéricos.
# El primer caso que consideraremos es si la representación de $x_0$ corresponde
# a un número racional cuya representación binaria es *finita*, es decir,
# que termina con una cola infinita de ceros; en este caso, después de un
# número $n$ de iterados, obtendremos $x_*=0$, que es el punto de equilibrio,
# por lo que cualquier número de iterados subsecuente seguirá ahí.
# El segundo caso es aquél en que $x_0$ es un número racional, pero cuya
# representación binaria muestra una cola periódica con dos o más elementos.
# En este caso, después de varios iterados (parte transiente), los iterados
# sucesivos repetirán la cola periódica; esto es, se terminará en una
# órbita periódica cuyo periodo es igual al de la cola periódica.
# De estos dos casos podemos concluir que la dinámica de cualquier número
# racional $x_0$ resulta en el punto de equilibrio, o en una órbita periódica.
# Finalmente, si consideramos una condición inicial que es irracional, su
# representación binaria no será periódica nunca, por lo que su dinámica
# reproducirá esto.
# En otras palabras, una condición inicial irracional resultará en una órbita
# aperiódica.

# Dado que la computadora trabaja con números de punto flotante con
# *precisión finita*, la representación de los números de punto flotante
# equivale a números racionales con una cola inifinita de ceros.
# Esto explica los resultados obtenidos en los ejercicios al usar números
# de punto flotante. (La aritmética con números racionales, en principio es exacta,
# siempre y cuando las funciones sean estrictamente racionales.)

# La consecuencia importante de este análisis se vuelve clara al considerar
# dos condiciones iniciales cuya diferencia es muy pequeña, e.g., $\epsilon=2^{-N}$.
# Su dinámica será similar, en términos de sus iterados, hasta la $N$-ésima
# iteración, y a partir de aquí su dinámica será esencialmente aleatoria, ya
# que con probabilidad 1, ambas condiciones iniciales serán números irracionales.
# En términos de la distancia entre los iterados de las dos condiciones iniciales,
# ésta crecerá *exponencialmente* rápido y, a partir de la $N$-ésima iteración
# será de orden 1, es decir, de orden del tamaño del sistema.
# Estas caracterísiticas, como veremos más adelante, están íntimamente r
# elacionadas con el conceto de caos.

# ---

# ## Bibliografía

# - Robert L. Devaney, A First Course In Chaotic Dynamics: Theory and Experiment, 1992.

# - Heinz Georg Schuster, Wolfram Just, Deterministic Chaos, 2006.
