A = load ('Tumblagooda.txt');
D = A(:,1);
I = A(:,2);
n = length(D);
x = cosd (D) .* cosd (I);
y = sind (D) .* cosd (I);
z = sind (I);
xm = sum(x) / n;
ym = sum(y)  /n;
zm = sum(z) / n;
R = sqrt (sum(x.^2) + sum(y.^2) + sum(z.^2));
Imean = asind (zm);
Dmean = atan2d (ym, xm);
Rmean = R / n;
disp (['a) The mean declination, inclination is ' num2str(Dmean) ', ' num2str(Imean)])
k = 0.7547; % Interpolated from Table A.18 [k = ((0.77990-0.74632)/0.01)*(0.2425-0.24)+0.74632]
delta_95 = 140 / sqrt (k * n);
disp (['b) The radius of the 95% confidence cone is ' num2str(delta_95) ' degrees'])
k_crit = 0.388; % From Table A.19
disp (['c) Since k = ' num2str(k) ' exceeds critical kappa of 0.388 then the mean direction is significant at the 95% level of confidence'])
