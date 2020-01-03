% similar to example 9.5
load glomar.txt 

D = glomar(:,1);
I = glomar(:,2);

alpha = 0.95;
n = length(x)

x = cosd(D).*cosd(I);
y = sind(D).*cosd(I);
z = sind(I);
[x y z]

R1 = sqrt(sum(x.^2) + sum(y.^2) + sum(z.^2))/n % Get mean resultant length
xb = mean(x);
yb = mean(y);
zb = mean(z);


I1 = asin(zb);       %radians
I1d = (180/pi)*I1   %degrees
D1 = atan(yb/xb);
D1d = (180/pi)*D1

k = (n-1)/(n-R1);


% part B 
theta = 354.3;
s = 46.4;
n2 = 1;                 %unsure of 

x2 = cos(theta)*cos(s);
y2 = sin(theta)*cos(s);
z2 = sin(s);

R2 = sqrt(sum(x2^2) + sum(y2^2) + sum(z2^2))/n2; % Get mean resultant length
xb2 = mean(x2);
yb2 = mean(y2);
zb2 = mean(z2);

% Finding Rp 
n3 = n + n2;
D2 = [D; theta];
I2 = [I; s];
x3 = cos(D2).*cos(I2);
y3 = sin(D2).*cos(I2);
z3 = sin(I2);
Rp = sqrt(sum(x3.^2) + sum(y3.^2) + sum(z3.^2))/n3; % Get mean resultant length


F = ((n3-2)*(R1 + R2 - Rp))/(n3 - R1 - R2)
Fs = (1 + (3/8)*k)*F
% Use table A.5 to look up critical F 

