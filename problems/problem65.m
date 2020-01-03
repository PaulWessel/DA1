% Solve 6.5
load bb_weights_clean.txt
x = log10(bb_weights_clean(:,1));
y = log10(bb_weights_clean(:,2));
n = length (x);
s = regress_lms (x, y);
xx = [-2 6];
yhat = s(1)*x + s(2);
yline= s(1)*xx + s(2);
figure(1); clf
plot (x, y, 'g.', 'MarkerSize', 20)
hold on
plot (xx, yline)
r = y - yhat;
s0 = 1.4826*(1 + 5/(n-2))*sqrt(median(r.^2));
z = r / s0;
w = abs(z) <= 2.5;
s2 = regress_ls (x, y, w);
k = find (w == 0);
plot (x(k), y(k), 'r.', 'MarkerSize', 20)
