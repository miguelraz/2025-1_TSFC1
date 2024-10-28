# # Universalidad del mapeo cuadrático

# Hasta ahora, lo que hemos visto es que al variar el parámetro $c$ para
# el mapeo cuadrático $Q_c(x)=x^2-c$, el mapeo
# exhibe una familia de bifurcaciones de doblamiento de periodo.
# Esto lo vimos, inicialmente de forma analítica, y después de manera numérica.
# Sin embargo, la resolución numérica eventualmente se vuelve insuficiente y
# es complicado visualizar las cosas y entender qué pasa.
# La pregunta que buscaremos resolver es si uno *puede* llegar a
# *periodo infinito* para un valor finito $c_\infty$,
# de hecho mayor a $-2$, para el mapeo cuadrático.
# Periodo infinito en este caso equivale a no tener periodo, y entonces uno se
# pregunta si hay una noción de estabilidad para órbitas genéricas en el régimen de órbitas aperiódicas; como
# veremos, no lo hay tal estabilidad sino inestabilidad (excepto por
# un conjunto de medida cero), y esta dinámica refleja lo que llamaremos
# *caos*. Abordaremos estas cuestiones, y además abordaremos la
# *universalidad* de este escenario.

# ## Exponent de Lyapunov

# ### Definición

using Pkg
Pkg.activate(".")
# Pkg.instantiate()

# Una manera de caracterizar el caos, en el sentido de *sensibilidad a condiciones
# iniciales*, es a través de los **exponentes de Lyapunov**. La idea es sencilla:
# evaluaremos si la evolución
# de la separación de condiciones iniciales infinitesimalmente cercanas exhibe una dependencia *exponencial* en el tiempo. Si éste es el caso entonces
# diremos que hay sensibilidad a las condiciones iniciales, es decir, caos.

# Para esto, simplemente monitoreamos la evolución de dos condiciones iniciales
# muy cercanas, $x_0$ y $x_0+\epsilon$, donde $\epsilon>0$ es muy pequeño.
# Considerando mapeos en una dimensión, la distancia entre los $n$-ésimos
# iterados es
# $$
# d_n = \big|\, f^{n}(x_0+\epsilon)-f^{n}(x_0) \big|\,.
# \tag{1}
# $$

# Entonces, suponiendo que $d_n$ tiene una dependencia exponencial de $n$
# (tiempo discreto), para $n\to\infty$ y $\epsilon\to 0$, escribimos
# $d_n= d_0 \exp(\lambda n)$, con $d_0 = \epsilon$, de donde obtenemos
# $$
# \lambda(x_0) \equiv \lim_{n\to\infty} \;\lim_{\epsilon\to 0} \;
# \frac{1}{n}\log\Big| \frac{f^{n}(x_0+\epsilon)-f^{n}(x_0)}{\epsilon}\Big|.
# \tag{2}
# $$

# A $\lambda(x_0)$ le llamamos el exponente de Lyapunov. Si $\lambda(x_0)>0$
# diremos que hay caos, mientras que si $\lambda(x_0)\leq 0$ diremos
# que no lo hay.
# El que no haya caos debe interpretarse como que el movimiento es periódico
# (o quizás cuasi-periódico). En cambio, que haya
# caos significa que hay regiones del espacio $x$ cuya dinámica es no periódica,
# aunque pueden existir condiciones iniciales que tengan órbitas periódicas.

# Observaciones:

# - El exponente de Lyapunov, estrictamente hablando, depende de la condición inicial $x_0$.
# - En la definición del exponente de Lyapunov se require la evaluación de **dos** límites, uno que involucra al tiempo ($n\to\infty$), y otro que representa la distancia entre las condiciones iniciales ($\epsilon\to 0$).
# - La definición del exponente de Lyapunov es sutil, ya que en muchas ocasiones *sabemos* que el rango de $f(x)$ es acotado cuando $x$ está en cierto dominio, lo que entonces podría llevar erróneamente a concluir que $\lambda(x_0)=0$. La sutileza está evidentemente en el órden de los límites, que no necesariamente conmuta.
# - Las unidades del exponente de Lyapunov corresponden al inverso del tiempo, es decir, $\lambda^{-1}$ describe una escala relevante del tiempo en que condiciones iniciales se separan una distancia del orden de $e$ ($\exp(1)$).

# Si el mapeo $f(x)$ es suficientemente suave, entonces podemos escribir (2) como
# $$
# \lambda(x_0) = \lim_{n\to\infty} \frac{1}{n}\log\Big| \frac{{\rm d} }{{\rm d}x}f^{n}(x_0)\Big|,
# \tag{3}
# $$
# donde literalmente hemos usado la definición de la derivada de la función
# $f^{n}$, el $n$-ésimo iterado de $f(x)$. Para mapeos en una dimensión
# se cumple
# $$
# \frac{{\rm d}f^n}{{\rm d}x}(x_0) = f'(x_0) f'(x_1)\dots f'(x_{n-1}) = \prod_{i=0}^{n-1} f'(x_i),
# $$
# donde $x_i=f^i(x_0)$, es decir, $x_i$ es el i-ésimo iterado de $x_0$, obtenemos
# $$
# \lambda(x_0) = \lim_{n\to\infty} \frac{1}{n} \sum_{i=0}^{n-1} \log\Big| \, f'(x_i)\, \Big|.
# \tag{4}
# $$
# La ecuación (4) establece una forma de calcular los exponentes
# de Lyapunov que es muy conveniente (¡rápida!) para mapeos en una dimensión.


# ### Exponente de Lyapunov del mapeo cuadrático

# Ahora obtendremos la dependencia del exponente
# de Lyapunov del parámetro $c$, para el mapeo cuadrático $Q_c(x) = x^2+c$.
# Volveremos a generar aquí el diagrama de bifurcaciones, ya que ambos diagramas
# permiten entender muchas cosas.

# Definimos primero varias funciones para hacer la vida más sencilla.

Q(x, c) = x^2 + c # mapeo cuadrático

#n-ésimo iterado del mapeo Q(x,c)
function Qn(x, c, n)
    for i = 1:n
        x = Q(x, c)
    end
    return x
end

Qprime(x, c) = 2*x # derivada

#Posición del punto fijo `x_+`
pplus(c) = 0.5*(1+sqrt(1-4*c))

#-

"""
    rand_dominio_Q(c)

Regresa un número aleatorio en el dominio de `Q(x, c)`.
"""
function rand_dominio_Q(c)
    xplus = pplus(c)
    return 2*xplus*rand()-xplus
end

# Generamos primero los datos para el diagrama de bifurcaciones, como lo
# hicimos anteriormente.
#=
Las siguiente función la definimos en alguna clase anterior, y la
usaremos para regenerar el diagrama de bifurcaciones; se modificó aquí
para explotar lo que tenemos aquí.
=#
function diag_bifurc(f, nit, nout, crange)
    ff = Array{Float64}(undef, nout, length(crange))

    for ic in eachindex(crange)
        c = crange[ic]
        x = rand_dominio_Q(c) # condición inicial aleatoria
        x = Qn(x, c, nit)
        @inbounds for i = 1:nout
            x = Q(x, c)
            ff[i, ic] = x
        end
    end

    return ff
end

#-
#Rango de interés para los parámetros
crange = range(0.25, stop=-2, length=2^10)

#-
ff = diag_bifurc(Q, 10_000, 256, crange);
cc = ones(size(ff, 1)) * crange';

#-
#Lo siguiente cambia las matrices en vectores, y se usa para la gráfica
ff = reshape(ff, size(ff, 1)*size(ff, 2));
cc = reshape(cc, size(ff));

# Aquí calculamos el exponente de Lyapunov, usando la Ec. (3).
"""
    expon_Lyap(f, funprime, x0, c, nit=1_000_000)

Regresa el exponente de Lyapunov para el mapeo `x->fun(x,c)`, utilizando
la función `funprime(x, c)` que representa la derivada del mapeo (respecto
a la variable dependiente `x`); `c` representa el parámetro del mapeo
y `nit` el número de iteraciones que se consideran.
"""
function expon_Lyap(fun, funprime, x, c, nit=10_000)
    sum_log = 0.0
    for i = 1:nit
        fprim = funprime(x, c)
        sum_log += log(abs(funprime(x, c)))
        x = fun(x, c)
    end
    return sum_log/nit
end

#-
#Vector con resultados del exponente de Lyapunov
λv = expon_Lyap.(Q, Qprime, rand_dominio_Q.(crange), crange);

# Ahora graficamos, primero, el diagrama de bifurcaciones, y después el resultado obtenido para el exponente de Lyapunov. (Las gráficas son
# particularmente pesadas, por la que es mejor guardarlas en formato `png`
# y después cargarlas.)

using Plots

#Dibujamos el diagrama de bifurcaciones
p1 = scatter(cc, ff, markersize=0.5, markerstrokestyle=:solid,
    legend=false, title="Fig. 1")
xaxis!(p1, "c")
yaxis!(p1, "x_n")
xlims!(p1, -2.0, 0.5)
ylims!(p1, -2.0, 2.0)
plot!(p1, [-2, 0.5], [0.0, 0.0], color=:red)
savefig("diag_bif1-1.png");

# ![Fig 1](./diag_bif1-1.png)

#Dibujamos el diagrama para el exponente de Lyapunov
p2 = scatter(crange, λv, markersize=0.5, markerstrokestyle=:solid,
    legend=false, title="Fig. 2")
xaxis!(p2, "c")
yaxis!(p2, "L")
xlims!(p2, -2.0, 0.5)
ylims!(p2, -1.5, 1.0)
plot!(p2, [-2, 0.5], [0.0, 0.0], color=:red)
savefig("diag_lyap1.png");

# ![Fig 2](./diag_lyap1.png)

# Hay varias observaciones interesantes que se pueden se desprenden de
# estas figuras:
# - Cada vez que ocurre una bifurcación de doblamiento de periodo, el exponente de Lyapunov es cero. Esto es consecuencia de que en el punto de bifurcación (de doblamiento de periodo), la derivada es -1; ver ecuación (4).
# - Cada vez que ocurre un ciclo superestable, es decir, que $x=0$ es parte de la órbita periódica (de periodo $2^n$), el exponente de Lyapunov diverge a $-\infty$; esto es consecuencia de que en este caso, la derivada (en $x=0$) se anula.
# - Al disminuir $c$, en algún momento el exponente de Lyapunov se hace positivo. Esto es, todos los iterados de las órbitas son típicas son localmente inestables.

# A partir de los cálculos que hemos hecho, podemos obtener una aproximación del valor de $c$ en que el exponente de Lyapunov se vuelve positivo (al disminuir $c$) por primera vez.

n0 = findfirst(l -> l > 0.0, λv)
(crange[n0], λv[n0])

# Si bien el valor para $c_\infty = -1.40175953\dots$ que obtuvimos es una aproximación numérica burda, el punto importante es que para este valor de $c$ hay órbitas que no muestran ninguna periodicidad. Para este valor de $c$ el mapeo tiene una dinámica caótica.


# ## Universalidad

# Arriba, hemos generado el diagrama de bifurcaciones de la familia
# cuadrática, que se ilustra en la Fig. 1.
# En esta sección, daremos razones por qué ciertos aspectos de la
# dinámica de la familia cuadrática son universales, como por ejemplo
# los exponentes de Feigenbaum (Tarea 3). Es decir, por qué
# se obtienen *los mismos resultados* para una familia más amplia de
# mapeos, más allá de la cuadrática.

# El argumento que se presenta será más bien cualitativo; sin embargo, las
# observaciones que aquí se harán se pueden poner en términos rigurosos, que
# se conocen como la teoría de renormalización.

# ### Ciclos superestables

# Para la familia de mapeos cuadráticos $Q_c(x) = x^2+c$, un punto muy
# particular es $x=0$, ya que en $x=0$ se satisface $Q_c'(x=0)=0$ para todo
# valor de $c$. Si bien esta observación parece trivial, lo que implica
# es que si $x=0$ pertenece a una órbita periódica, entonces la derivada
# de la órbita periódica será $0$, y en términos de su estabilidad,
# es el caso más alejado de -1 o 1,
# que son los puntos de posibles bifurcaciones (estabilidad neutral).
# Definiremos entonces un *ciclo superestable* de periodo $n$ como aquél en
# que el punto $x_0=0$ forma parte del órbita periódica de periodo $n$ y por lo tanto el mapeo satisface $f'(x_0)=0$.

# Es fácil ver que en $c_0=0$ se tiene un ciclo superestable periódico de
# periodo 1; ver por ejemplo el diagrama de bifurcaciones.
# En este caso, uno puede sustituir $c=0$ en $Q_c(x)$, y verificar
# que $Q_{0}(x_0)=x_0$ se cumple.

c_0 = 0.0
Q(0.0, c_0) == 0.0

# La siguiente gráfica muestra el mapeo $Q_c(x)$ para $c=c_0$.
xrange = -1:1/64:1
plot(xrange, x->Qn(x, c_0, 1))
plot!(xrange, x->x)
ylims!(-1,1)
xlabel!("x")
ylabel!("Q_c(x)")
title!("c₀ = $c_0")

# Para obtener el valor $c_1$ del ciclo superestable de periodo 2, debemos
# encontrar la $c$ tal que
# $$
# Q_c^2(0) = c^2+c = c(c+1) = 0,
# $$
# cuya solución (distinta de $c_0=0$, que corresponde al caso de periodo 1)
# es obviamente $c_1=-1$.
# La gráfica de $Q_{c_1}^2(x)$ se muestra a continuación.

c_1 = -1.0
xrange = -1:1/64:1
plot(xrange, x->Qn(x, c_1, 2))
plot!(xrange, x->x)
ylims!(-1,1)

x₁ = -0.6
plot!([x₁, -x₁, -x₁, x₁, x₁], [x₁, x₁, -x₁, -x₁, x₁])
xlabel!("x")
ylabel!("Q_c^2(x)")
title!("c₁ = $c_1")

# El recuadro en la gráfica muestra un detalle específico de $Q^2_{c_1}(x)$
# que, localmente, se *parece* a $Q_{c_0}(x)$;
# ésta precisamente es la motivación de ese recuadro.
# Aunque es obvio de la gráfica, noten que la comparación requiere de
# una reflexión respecto al eje $y$; esto reaparecerá más tarde.

# Para encontrar el valor de $c$ en que $Q_{c}^4(x=0)=0$ analíticamente,
# uno debe tener mucha habilidad analítica dado que el polinomio resultante en
# $c$ es de orden 8. Dado que el cálculo numérico de dicho parámetro
# es parte de la Tarea 3, simplemente usaré una buena
# aproximación del valor: $c_2 = -1.3107026\dots$.

c_2 = -1.3107026413368328

xrange = -1:1/64:1
plot(xrange, x->Qn(x, c_2, 4))
plot!(xrange, x->x)
ylims!(-1,1)

x₁ = -0.25
plot!([x₁, -x₁, -x₁, x₁, x₁], [x₁, x₁, -x₁, -x₁, x₁])

xlabel!("x")
ylabel!("Q_c^4(x)")
title!("c₂")

# Nuevamente, el recuadro en la gráfica de $c_2$ muestra un detalle de
# $Q_{c_2}^4(x)$ que, localmente, se *parece* a $Q_{c_0}(x)$, otra vez.
# En este caso, la comparación con el diagrama original es directa:
# una doble reflexión (respecto al eje $y$) corresponde a la identidad.

# Hacemos lo mismo para el siguiente doblamiento de periodo, es decir,
# periodo 8. En este caso, como obtendrán en la Tarea 3, usamos
# $c_3 = -1.38154748\dots$.

c_3 = -1.3815474844320617

xrange = -1:1/128:1
plot(xrange, x->Qn(x, c_3, 8))
plot!(xrange, x->x)
ylims!(-1,1)

x₁ = -0.125
plot!([x₁, -x₁, -x₁, x₁, x₁], [x₁, x₁, -x₁, -x₁, x₁])

xlabel!("x")
ylabel!("Q_c^8(x)")
title!("c₃")

# Otra vez, uno puedo mostrar un recuadro que, localmente, se parece
# en este caso al mapeo de periodo 4 con una reflexión.


# ### Constante $\alpha$ de Feigenbaum

# El punto del análisis gráfico anterior es sugerir que *localmente* los mapeos
# $Q_{c_0}(x)$ y $Q^{2^n}_{c_n}(x)$ son muy similares, si uno se enfoca en
# un dominio muy particular para $Q^{2^n}_{c_n}(x)$,
# es decir, un reescalamiento, y quizás también una reflexión.
# Vale la pena notar que la distancia al punto fijo (que cruza
# la identidad) y que define los recuadros que usamos en las
# gráficas del mapeo, es
# $d_n = Q_{c_n}^{2^{n-1}}(0) \approx -\alpha d_{n+1}$, es decir,
# la mitad de los iterados del mapeo.
# Esta observación se expresa de manera formal construyendo una función que
# localmente se comporta como $Q^{2^n}_{c_n}(x)$, esto es:
# $$
# g_1(x) = \lim_{n\to\infty} (-\alpha)^n Q_{c_{n+1}}^{2^n}\;\Big(\frac{x}{(-\alpha)^n}\Big).
# \tag{5}
# $$
# El límite $n\to\infty$ hace que todas las particularidades del mapeo $Q_c(x)$
# se pierdan y, en este sentido, que sólo resten las propiedades que son *universales*.

# La ecuación (5) se generaliza a:
# $$
# g_i(x) = \lim_{n\to\infty} (-\alpha)^n Q_{c_{n+i}}^{2^n}\;\Big(\frac{x}{(-\alpha)^n}\Big),
# \tag{6}
# $$
# De la definición de $g_i(x)$, uno puede demostrar que las funciones $g_i(x)$
# satisfacen la ecuación
# $$
# g_{i-1}(x) = -\alpha g_i\Big( g_i\big(-\,\frac{x}{\alpha}\big)\Big) .
# $$
# Tomando el límite $i\to \infty$ nos lleva a:
# $$
# g(x) \equiv T g(x) = -\alpha g\Big( g\big(-\,\frac{x}{\alpha}\big)\Big),
# \tag{7}
# $$
# donde $T$ es el *operador de doblamiento de periodo*.

# Si una función $g(x)$ satisface la ecuación (7), entonces la función
# $\mu g(x/\mu)$, con $\mu\neq 0$, es también solución de la ecuación. Esta
# es una propiedad de escalamiento. De aquí, imponiendo que $g(0)=1$ se
# tiene $1=-\alpha g(1)$.

# Para determinar la función $g(x)$, módulo los reescalamientos descritos,
# la idea es hacer un desarrollo en serie de Taylor de $g(x)$ cerca de $x=0$
# a fin de obtener una aproximación de $\alpha$. De la ecuación de doblamiento
# de periodo, (7) uno obtiene:
# \begin{align*}
# g'(x) &= g'\Big( g\big(-\,\frac{x}{\alpha}\big) \Big) g'\big(-\,\frac{x}{\alpha}\big),\\
# g''(x) &= -g''\Big( g\big(-\,\frac{x}{\alpha}\big) \Big) \Big[ g'\big(-\,\frac{x}{\alpha}\big)\Big]^2
# -\,\frac{1}{\alpha} g'\Big( g\big(-\,\frac{x}{\alpha}\big) \Big) g''\big(-\,\frac{x}{\alpha}\big).
# \end{align*}
# De la primer ecuación podemos concluir que $g'(0)=0$. Por esto, a segundo
# orden tenemos que $g(x)\simeq 1+b x^2$. Sustituyendo esta aproximación en la
# ecuación de doblamiento de periodo y desarrollando *hasta* segundo orden,
# se obtiene:
# $$
# 1+b x^2 \simeq -\alpha\Big(1+b\big(1+b(-\frac{x}{\alpha})^2\big)^2\Big) = -\alpha\Big( 1+ b + \frac{2b^2}{\alpha^2}x^2\Big) + {\cal O}(x^4).
# $$

# Igualando término a término (potencias de $x$) tenemos que se debe satisfacer:
# \begin{align*}
# 1 &=& -\alpha(1 + b),\\
# b &=& - 2b^2/\alpha.\\
# \end{align*}
# De aquí finalmente obtenemos $b \approx -\alpha/2$ y $\alpha\approx 1+\sqrt{3}=2.73\dots$;
# el valor de esta constante es $\alpha = 2.502907\dots$.

# La otra constante de Feigenbaum, $\delta$, se obtiene estudiando las propiedades de la
# ecuación linearizada en $c$. La aproximación numérica de ambas constantes es parte de la Tarea 3.

# El punto importante es que este tipo de constantes de escalamiento
# reflejan aspectos universales en los mapeos. Dichos aspectos universales
# están además relacionados con aspectos sutiles de la dinámica: por ejemplo,
# las constantes de Feigenbaum para mapeos Hamiltonianos no son las mismas
# que en el caso no-Hamiltoniano, a pesar de que en ambos casos se puede
# observar la cascada de bifurcaciones de doblamiento de periodo.

# ## Referencia

# Heinz Georg Schuster, Wolfram Just, Deterministic Chaos, 2006.
