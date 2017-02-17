function [y] = hsvHistogram(adr,count_bins) 
%extrag R,G,B din matricea tri-dimensionala returnata de functia imread
X = imread(adr);
R = X(:,:,1);
G = X(:,:,2);
B = X(:,:,3);
 
%le convertesc la numere reale
R1 = double(R);
G1 = double(G);
B1 = double(B);

R1 = R1/255;
G1 = G1/255;
B1 = B1/255;

[n m] = size(R1);
H = zeros(n,m);
S = zeros(n,m);
V = zeros(n,m);

%calculez maximul, minimul si diferenta pentru matricele normate
    m1 = max(R1, G1);
    Cmax = max(m1, B1);
    n1 = min(R1, G1);
    Cmin = min(n1, B1);
    D = Cmax - Cmin;   
    
%construiesc H,S,V dupa algoritmul indicat in enunt
%Pe pozitiile din H, S si V care indelpinesc conditiile pun valoareile indicate in algoritm   

    if D(Cmax == B1) == 0   
    H(Cmax == B1) = 0;
    else      
    H(Cmax == B1) = 60*((R1(Cmax == B1) - G1(Cmax == B1))./D(Cmax == B1) + 4);
    end    
    if D(Cmax == R1) == 0
    H(Cmax == R1) = 0;       %pentru a evita cazurile de impartire la 0
    else
    H(Cmax == R1) = 60*mod(((G1(Cmax == R1) - B1(Cmax == R1))./D(Cmax == R1)),6);
    end
    if D(Cmax == G1) == 0
    H(Cmax == G1) = 0;
    else
    H(Cmax == G1) = 60*((B1(Cmax == G1) - R1(Cmax == G1))./D(Cmax == G1) + 2);
    end
    H(D == 0) = 0;
    
    S(Cmax == 0) = 0;  
    S(Cmax != 0) = D(Cmax != 0)./Cmax(Cmax != 0);
    V = Cmax;
    
H = H/360;

%1.01 deoarece S si V iau valori in [0,100] => 101 valori in total; impart la 100 pentru a le aduce in [0.1], la fel ca si H
z = 1.01/count_bins;
for i = 1:count_bins
%numar pixelii din fiecare matrice pe intervalede forma ceruta in enunt
h1 = find(H(1:n, 1:m) >= (i-1)*z);
h2 = find(H(h1) < i*z);

s1 = find(S(1:n,1:m) >= (i-1)*z);
s2 = find(S(s1) < i*z);

v1 = find(V(1:n, 1:m) >= (i-1)*z);
v2 = find(V(v1) < i*z);

y(i) = length(h2);
y(count_bins + i) = length(s2);
y(count_bins*2 + i) = length(v2);
endfor