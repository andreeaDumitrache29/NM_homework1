function [w] = learn(X, t)
[n m] = size(X);
M = zeros(n, m + 1); %construiesc o noua matrice care va fi egala cu X + o coloana de 1
M(:, 1 : m) = X;
M(:, m + 1) = 1;
A = M'*M; %am facut aceaste notatii pentru a putea aplica QR 
b = M'*t;
[Q R w] = Householder (A, b);   %aflu vectorul w aplicand Householder
endfunction