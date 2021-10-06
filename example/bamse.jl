using skalman 
using Plots, LinearAlgebra, FastGaussQuadrature

n = 8
nodes, weights = gausslobatto(n)

# Broadcast and store in a matrix
P = legendrepoly.(nodes,n-1)
P = reduce(hcat,P)
P = transpose(P)

# Broadcast and store in a matrix
PX = derlegendre.(nodes,n-1)
PX = reduce(hcat,PX)
PX = transpose(PX)

M = zeros(n,n)
S = similar(M)
for i = 1:n
    for j = 1:n
    M[i,j] = sum(P[:,i].*P[:,j].*weights)
    S[i,j] = sum(P[:,i].*PX[:,j].*weights)
    end
end

f = sin.(nodes)
b = similar(f)
for i = 1:n
    b[i] = sum(P[:,i].*f.*weights)
end
umodes = M\b
uxmodes = M\(S*umodes)

zz = collect(LinRange(-1.0, 1.0, 101))
# Broadcast and store in a matrix
PP = legendrepoly.(zz,n-1)
PP = reduce(hcat,PP)
PP = transpose(PP)

unodes = PP*umodes
uxnodes = PP*uxmodes
pl = plot(zz,uxnodes)
plot!(pl,zz,cos.(zz))