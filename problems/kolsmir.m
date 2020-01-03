% KOLSMIR prepares a Kolmogorov-Smirnov test
%	D = KOLSMIR (x, y)
%
%	x and y		Two  distributions to compare
%
%	On output,
%	D	= Observed K-S statistic
%
%	KOLSMIR will help you determine whether the two distributions
%	x and y are drawn from the same population.  It returns the
%	KS-statistic D and generates the cumulative plot.
%   You will need to look up critical values and compare to D

function D = kolsmir (x, y)
nx = length (x);
ny = length (y);
x = sort (x);
y = sort (y);
% Determine D
jx = 1;
jy = 1;
D = 0.0;
fnx = 0.0;
fny = 0.0;
while (jx <= nx & jy <= ny)
	dx = x(jx);
	dy = y(jy);
	if dx <= dy
		xc = x(jx);
		fnx = jx / nx;
		jx = jx + 1;
	end
	if dy <= dx
		yc = y(jy);
		fny = jy / ny;
		jy = jy + 1;
	end
	dt = abs (fny - fnx);
	if (dt > D)
		D = dt;
		xy = 0.5 * (dx + dy);
	end
end
% Build the two cumulative distributions
dx = 1.0/nx;
xx = zeros (2*nx,1);
cx = zeros (2*nx,1);
for i=1:nx
	xx(2*i-1) = x(i);
	xx(2*i) = x(i);
	cx(2*i-1) = (i-1)*dx;
	cx(2*i) = i*dx;
end
dy = 1.0/ny;
yy = zeros (2*ny,1);
cy = zeros (2*ny,1);
for i=1:ny
	yy(2*i-1) = y(i);
	yy(2*i) = y(i);
	cy(2*i-1) = (i-1)*dy;
	cy(2*i) = i*dy;
end
clf
plot (xx, cx, 'r-')
hold on
plot (yy, cy, 'g-')
grid
plot ([xy xy], [0 1], '--')
title (['D = ' num2str(D)])
