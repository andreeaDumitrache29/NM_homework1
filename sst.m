%calculez solutia unui sistem superior triunghiular conform formulei din laborator
function [x] = sst(A,b)
[n,m]=size(A);
x = zeros(n,1);
for i = n:-1:1
s = 0;
s += A(i, 1+i:n)*x(1+i:n);
x(i) = (b(i) - s)/A(i,i);
endfor
endfunction