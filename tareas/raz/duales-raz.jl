module NumDual

struct Dual
    fun::Float64
    der::Float64
end

Base.:+(x::Dual, y::Dual) = Dual(fun(x) + fun(y), der(x) + der(y))
Base.:-(x::Dual, y::Dual) = Dual(fun(x) - fun(y), der(x) - der(y))
Base.:*(x::Dual, y::Dual) = Dual(fun(x) * fun(y), der(x) * fun(y) + fun(x) * der(y))
Base.:/(x::Dual, y::Dual) = Dual(fun(x) / fun(y), (der(x) - (fun(x) / fun(y)) * der(y)) / fun(y))
Base.:^(x::Dual, y::Real) = Dual(fun(x) ^ y, y*fun(x)^(y-1)*der(x))

Base.:+(x::Dual, y::Real) = x + Dual(y)
Base.:+(x::Real, y::Dual) = Dual(x) + y
Base.:-(x::Dual, y::Real) = x - Dual(y)
Base.:-(x::Real, y::Dual) = Dual(x) - y
Base.:-(x::Dual) = Dual(-fun(x), -der(x))
Base.:+(x::Dual) = Dual(fun(x), der(x))
Base.:*(x::Dual, y::Real) = x * Dual(y)
Base.:*(x::Real, y::Dual) = Dual(x) * y
Base.:/(x::Dual, y::Real) = x / Dual(y)
Base.:/(x::Real, y::Dual) = Dual(x) / y

dual(x::Real) = Dual(x, 1.0)
Dual(x::Real) = Dual(x, 0.0)
fun(x::Dual) = x.fun
der(x::Dual) = x.der
fun(x::Real) = x
der(x::Real) = x

Base.isapprox(x::Dual, y::Dual) = fun(x) ≈ fun(y) && der(x) ≈ der(y)

import Base: sin, cos, tan, sqrt, exp, log
Base.sin(x::Dual) = Dual(sin(x.fun), cos(fun(x)) * der(x))
Base.cos(x::Dual) = Dual(cos(x.fun), -sin(fun(x)) * der(x))
Base.tan(x::Dual) = Dual(tan(x.fun), -sec(fun(x))^2 * der(x))
Base.sqrt(x::Dual) = Dual(sqrt(x.fun), .5/sqrt(fun(x)) * der(x))
Base.exp(x::Dual) = Dual(exp(x.fun), fun(x) * der(x))
Base.log(x::Dual) = Dual(log(x.fun), 1/fun(x) * der(x))

export Dual, dual, fun, der

end #module 
