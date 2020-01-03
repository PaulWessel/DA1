function stat = regress_ls (x, y, w)
%
% REGRESS_LS Least-squares Regression
%	REGRESS_LS (x, y)
%	REGRESS_LS (x, y, w)
%	Performs simple regression of y on x and returns
%	slope, intercept, sigma_slope, sigma_intercept
%	Optionally, a third vector with weights may be passed.
stat = zeros (4,1);
if nargin == 2
	w = ones (size (y));
else
	w = w .* w;
end
S = sum (w);
S_x = sum (x .* w);
S_y = sum (y .* w);
S_xx = sum (x .* x .* w);
S_xy = sum (x .* y .* w);
D = 1.0 / (S * S_xx - S_x * S_x);
stat(1) = (S * S_xy - S_x * S_y) * D;
stat(2) = (S_xx * S_y - S_x * S_xy) * D;
stat(3) = sqrt (S * D);
stat(4) = sqrt (S_xx * D);
end