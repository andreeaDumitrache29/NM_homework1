function [X, t] = preprocess(dir_path, s, count_beans)
dir_cats = strcat(dir_path,'/cats/');
dir_notcats = strcat(dir_path,'/not_cats/');
y1 = getImgNames(dir_cats);
y2 = getImgNames(dir_notcats);
[n1 m1] = size(y1);
[n2 m2] = size(y2);
%creez vectorul t in functie de cele 2 posibilitati: cats si not_cats
t = ones(n1+n2, 1);
t(n1 + 1 : n1 + n2, 1) = -1;
y1 = strcat(dir_cats, y1);
y2 = strcat(dir_notcats, y2);
%am obtinut matricele cu calea completa catre imaginile din cele 2 subdirectoare
X = zeros(n1+n2, 3*count_beans);
if(strcmp(s,'RGB') == 1)  %pun in matricea X valorile histogramelor rgb pentru subdirectorul cats
  for i = 1:n1
  X(i,1:3*count_beans) = rgbHistogram(y1(i,:), count_beans);
  end
  for i = 1:n2 %pun in matricea X valorile histogramelor R,G,B pentru subdirectorul not_cats
  X(i + n1, 1:3*count_beans) = rgbHistogram(y2(i, :), count_beans);
  end
end

if(strcmp(s,'HSV') == 1) %pun in matricea X valorile histogramelor hsv pentru subdirectorul cats
  for i = 1:n1
  X(i,1:3*count_beans) = hsvHistogram(y1(i,:), count_beans);
  end
  for i = 1:n2     %pun in matricea X valorile histogramelor hsv pentru subdirectorul not_cats
  X(i + n1, 1:3*count_beans) = hsvHistogram(y2(i, :), count_beans);
  end
end
endfunction
