function [ out ] = Bilinearinter( x,y,f,o )
% Example : 
% out  = bilinearinter( [1 5],[3 8],[10 15 17 2],[4 6])
Q11 = f(1);
Q12 = f(2);
Q21 = f(3);
Q22 = f(4);

xl = x(1);
xh = x(2);
yl = y(1);
yh = y(2);
x = o(1);
y = o(2);

out  = (Q11 * (xh-x) *(yh-y)) + (Q12 * (xh-x) * (y-yl)) + (Q21 * (x-xl) * (yh-y)) + (Q22 * (x-xl) * (y-yl)) ;


end

