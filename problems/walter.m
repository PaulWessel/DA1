% Solve 39 Walter's fever
T=[-51.32 -49.34 -42.41 -56.72 -45.92 -50.33 -47.09 -53.39 -24.23 -27.41 -44.21 -48.08 -39.08 -54.02];
mean_T = mean(T);
std_T = std(T);
med_T = median(T);
MAD_T = 1.4826 * mad (T,1);
disp (['mean = ' num2str(mean_T) 'std = ' num2str(std_T) ' median = ' num2str(med_T) ' MAD = ' num2str(MAD_T)])
z = (T - med_T)/MAD_T;
k = find (abs(z) >= 2.5);
disp (['Outlier T = ' num2str(T(k))])
k = find (abs(z) < 2.5);
mean_T = mean(T(k));
std_T = std(T(k));
med_T = median(T(k));
MAD_T = 1.4826 * mad (T(k),1);
disp (['Revised mean = ' num2str(mean_T) 'std = ' num2str(std_T) ' median = ' num2str(med_T) ' MAD = ' num2str(MAD_T)])
