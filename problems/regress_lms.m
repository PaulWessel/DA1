function [stat, angle, e] = regress_lms (x, y, d_angle, limit)
% REGRESS_LMS Least Median of Squares (robust) Regression
%	stat = REGRESS_LMS (x, y)
%	or
%	[stat, angle, misfit] = REGRESS_LMS (x, y, d_angle, limit)
%
%	Performs simple regression of y on x and returns
%	slope, intercept, and median squared misfit
%	Optionally, two arguments fine-tuning the regression
%	may be given:
%	  d_angle	Search for slope in increments of this angle [1]
%	  limit		Keep iterating until change in misfit < limit [0.1]
%	Also optionally, you may give three output arguments; the last two will
%	contain the slope angles and the corresponding misfit for all angles searched.

if nargin == 2
	d_angle = 4.0;
	limit = 0.1;
end

n_angle = round ((180.0 - 2 * d_angle) / d_angle) + 1;
[stat, angle, e] = regresslms_sub (x, y, -90.0 + d_angle, 90.0 - d_angle, n_angle);
old_error = stat(3);
d_error = stat(3);

while d_error > limit
	d_angle = 0.1 * d_angle;
	a = atan (stat(1)) * 180 / pi;
	angle_0 = floor (a / d_angle) * d_angle - d_angle;
	angle_1 = angle_0 + 2.0 * d_angle;
	stat = regresslms_sub (x, y, angle_0, angle_1, 21);
	d_error = abs(stat(3) - old_error);
	old_error = stat(3);
end

function [stat, angle, e] = regresslms_sub (x, y, angle0, angle1, n_angle)
%
stat = zeros (4,1);
da = (angle1 - angle0) / (n_angle - 1);
slp = zeros(n_angle, 1);
icept = zeros(size(slp));
angle = zeros(size(slp));
e = zeros(size(slp));

for i = 0 : n_angle-1
	j = i + 1;
	angle(j) = angle0 + i * da;
	slp(j) = tan (angle(j) * pi / 180.0);
	z = y - slp(j) * x;
	icept(j) = lms (z);
	e(j) = median ((z - icept(j)) .^ 2);
end
i = min(find (e == min (e)));
stat(1) = slp(i);
stat(2) = icept(i);
stat(3) = e(i);