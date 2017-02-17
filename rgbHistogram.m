function [y] = rgbHistogram(adr,count_bins) 
%extrag R,G,B din matricea tri-dimensionala returnata de functia imread
X = imread(adr);
R = X(:,:,1);
G = X(:,:,2);
B = X(:,:,3);

z = 256/count_bins;
[n m] = size(R);

for i = 1:count_bins
%numar pixelii din fiecare matrice pe intervale de forma ceruta in enunt

r1 = find(R(1:n, 1:m) >= (i-1)*z);
r2 = find(R(r1) < i*z);

%folosesc functia find pentru a gasi in matricele R,G si B elementele cu 
%proprietatea ceruta
g1 = find(G(1:n,1:m) >= (i-1)*z);
g2 = find(G(g1) < i*z);

b1 = find(B(1:n, 1:m) >= (i-1)*z);
b2 = find(B(b1) < i*z);

%apoi le inserez in vectorul rezultat pe pozitiile corespunzatoare
y(i) = length(r2);
y(count_bins + i ) = length(g2);
y(count_bins*2 + i) = length(b2);
endfor
endfunction