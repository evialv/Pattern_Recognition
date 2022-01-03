function [mah_dist] = Mahalanobis(m,S,x)

mah_dist=sqrt((transpose(x-m)*inv(S)*(x-m));
end

