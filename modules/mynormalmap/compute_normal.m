function [ n ] = compute_normal( g,p )
    scl = 1.0 / sqrt(1.0 + g(1)*g(1) + g(2)*g(2));
    n = [scl*g(1), scl*g(2), -1*scl];
    q = dot(n,[p(1,1,1) p(1,1,2) p(1,1,3)]);
    if(q <0)
        n = n.*(-1);
    end
end

