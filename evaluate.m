function [p] = evaluate(path, w, sir,count_beans)
dir_cats = strcat(path,'/cats/');
dir_notcats = strcat(path,'/not_cats/');
y1 = getImgNames(dir_cats);
y2 = getImgNames(dir_notcats);
y1 = strcat(dir_cats, y1); 
y2 = strcat(dir_notcats, y2);
[n1 m1] = size(y1);
[n2 m2] = size(y2);
%am obtinut matricele cu calea completa catre imaginile din cele 2 subdirectoare
cats = 0; not_cats = 0;
X = zeros(1, 3*count_beans + 1);
X(1, 3*count_beans + 1) = 1;
%in functie de sir aflu histograma pe fiecare imagine din subdirectoarele cats si not cats
if(strcmp(sir,'RGB') == 1)
  for i = 1:n1
    X(1, 1:3*count_beans) = rgbHistogram(y1(i,:), count_beans);
    y = dot(w', X(1, :)); %ma aflu in subdirectorul cats, deci trebuie ca produsul scalar sa fie >= 0 
    if (y >= 0)
      cats++; %numar valorile corecte
    end
  endfor  
  for i = 1:n2    %ma aflu in subdirectorul not_cats, deci trebuie ca produsul scalar sa fie < 0
  X(1, 1:3*count_beans) = rgbHistogram(y2(i, :), count_beans);
  y = dot(w', X(1, :));
    if (y < 0)
      not_cats++;  %numar valorile corecte
    end
  endfor

  else
  for i = 1:n1  %ma aflu in subdirectorul cats, deci trebuie ca produsul scalar sa fie >= 0
  X(1,1:3*count_beans) = hsvHistogram(y1(i,:), count_beans);
  y = dot(w', X(1, :));
    if (y >= 0)
      cats++; %numar valorile corecte
    end
 endfor
  
  for i = 1:n2 %ma aflu in subdirectorul not_cats, deci trebuie ca produsul scalar sa fie < 0
  X(1, 1:3*count_beans) = hsvHistogram(y2(i, :), count_beans);
  y = dot(w', X(1, :));
    if (y < 0)
      not_cats++;
    end
  endfor
 end
 p = 100*(cats + not_cats)/(n1 + n2);  %calculez acuratentea
 
endfunction
