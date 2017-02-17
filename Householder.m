function [Q R x] = Householder (A, b)
%aplicam Householder pentru a rexolva un sistem de tipul Ax = b
[n m] = size(A);
Q = eye(n);
for p = 1:m
s = norm(A(p:n,p));
if A(p,p) < 0
  s = -s;
end
beta = s*(s + A(p,p));
%calculam u
u(1:p-1) = 0;
u(p) = A(p,p) + s;
u(p+1:n) = A(p+1:n, p);
%Hp*x
A(p,p) = -s;
A(p+1:n,p) = 0;
%Hp*y
for j = p+1:m
ro = u*A(:,j)/beta;
A(:,j) = A(:,j) - ro*u';
end
%Hp*Q
for j = p+1:m
ro = u*Q(:,j)/beta;
Q(:,j) = Q(:,j) - ro*u';
end
%Hp*b
ro = u*b/beta;
b = b - ro*u';
end
Q = Q';
R = A;
x = sst(R,b);  %functie pentru rezolvarea unui sistem triangular superior
endfunction
