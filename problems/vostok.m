% Problem 7.7
data = importdata ('vostok.txt', '\t', 1);
x = data.data(:,2); %time (yr)
y = data.data(:,3); %change in temp (C)
z = data.data(:,1); %depth (m)

%Autocorrelation of change in temp
figure(1)
subplot (3,1,1)
plot (z,y) %Look at the data
xlabel ('Depth (m)')
ylabel ('Change in Temp (C)')

subplot (3,1,2)
s = regress_ls (z, y); % Fit a LS trend trend
dy = y - s(1)*z - s(2); % Remove this trend
plot (z,dy); % Plot residuals
xlabel ('Depth (m)')
ylabel ('Residual Change in Temp (C)')

subplot (3,1,3)
[r, lag] = xcorr(dy,'coeff'); % Calculate autocorrelation
k = (lag >= 0); % Focus on positive lags
lag = lag(k);
r = r(k);
plot (lag',r) % Plot them
grid on
A = [lag' r];
save vostok_lag_z.txt A -ascii -tabs
k = (lag >= 1000); % Focus on large lags
lag = lag(k);
r = r(k);
q = 1000+ find (r == max(r),1);
disp (['Max correlation for lag ', int2str(q) ' which is ' num2str(x(q)) ' years'])

figure(2)
subplot (4,1,1)
plot (x,y) %Look at the data
xlabel ('Time (years)')
ylabel ('Change in Temp (C)')
subplot (4,1,2)
xx = (0:25:max(x))';
yy = spline(x,y, xx); 
plot(xx, yy)
xlabel ('Time (years)')
ylabel ('Change in Temp (C)')

subplot (4,1,3)
dt=25;
s = regress_ls (xx, yy); % Fit a LS regerssion trend
dy = yy - s(1)*xx - s(2); % Remove this trend
plot (xx,dy); % Plot residuals
xlabel ('Years')
ylabel ('Change in Temp (C)')

subplot (4,1,4)
[r, lag] = xcorr(dy,'coeff'); % Calculate autocorrelation
k = (lag >= 0); % Focus on positive lags
tt = 25*(lag');
plot (tt(k),r(k)) % Plot them
A = [tt(k) r(k)];
save vostok_lag_t.txt A -ascii -tabs
grid on
k = (lag >= 1000); % Focus on large lags
lag = lag(k);
r = r(k);
q = 1000 + find (r == max(r),1);
disp (['Max correlation for lag ', int2str(q) ' which is ' num2str(q*25/2) ' years'])

% Now do periodogramn
[a, b] = dft (dy)
figure (2)
clf
T = max(xx)-min(xx);
F = 1/T;
m = length (a);
j = (0:(m-1))';
ff = j * F;
p = 1./ ff;
A2 = (a.^2 + b.^2)';
plot (p, A2)
D = [j ff p A2];
size (D)
save vostok_dft.txt D -ascii -tabs

