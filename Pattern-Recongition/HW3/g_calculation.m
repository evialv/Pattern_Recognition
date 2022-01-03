function [g] = g_calculation(m,S,P,x)

d=length(m);
g=-0.5*(transpose(x-m))*(S^(-1))*(x-m)-d*0.5*log(2*pi)-0.5*log(det(S))+log(P);

end

