module skalman

# Write your package code here.
export legendrepoly, derlegendre

"""
    legendrepoly(x ::Float64,k)

    Evaluate all Legendre polynomials up to degree k at x 
"""
function legendrepoly(x ::Float64,k)

    P = zeros(k+1)
    P[1] = 1.0
    if k>0 
       P[2] = x
    end
    for i = 2:k
            P[i+1]=((2.0*i-1)*x*P[i+1-1]-(i-1.0)*P[i+1-2])/Float64(i)
    end
    return P
end

"""
    legendrepoly(x ::Float64,k)

    Evaluate all derivatives of Legendre polynomials up to degree k at x 
"""
function derlegendre(x ::Float64,k)

    P = legendrepoly(x,k)
    PX = zeros(k+1)
    PX[1] = 0.0
    if k > 1 
        PX[2] = 1.0
    end
    for i=2:k
        PX[i+1] = PX[i+1-2]+(2*i-1.0)*P[i+1-1]
    end
    return PX
end

end
