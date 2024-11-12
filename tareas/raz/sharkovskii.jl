# Sharkovskii

xs = 0:0.01:2
function Qn(x, c, n)
    res = x^2 - c
    for i in 2:n
        res = res^2 - c
    end
    res
end

res = Qn.(xs, xs', 50)