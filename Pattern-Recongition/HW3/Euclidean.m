function [dist] = Euclidean(x1,x2)
dist=sqrt(sum((x1-x2).^2));
disp(dist);
%� �� norm(x1-x2)
end

