using InvertedIndices

function lagrange(X,F)
    function poly(x)
        P = 0.0
        for i in eachindex(X)
            L = 1.0
            for xj in X[Not(i)]
                L *= (x-xj)/(X[i]-xj)
            end
            P += F[i] * L
        end
        return P
    end
    return poly
end

using Plots
using LaTeXStrings
using Printf

T = LinRange(-5.1, 5.1,200)
plot(T, exp.(-T.^2), label=L"$\exp(-x^2)$", lw=2)
for nPts in 5:2:11
    local X = LinRange(-5.0, 5.0, nPts)
    local F = exp.(-X.^2)
    plot!(T, lagrange(X,F).(T), label=@sprintf("nPts=%d", nPts), lw=1, ls=:dash)
end
plot!(legend=:bottom)
title!(L"Lagrange interpolation for $f(x) = \exp(-x^2)$")
xlabel!(L"x")
ylabel!(L"y")
current()