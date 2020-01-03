function mode = lms (x)
% LMS Mode estimator using the least median of squares
%	LMS (A) returns an estimate of the mode of a uni-
%	modal distribution.
%
x = sort(x);
n = length(x);
if n == 1
	mode = x(1);
elseif n == 2
	mode = 0.5 * (x(1) + x(2));
else
	n2 = floor (n/2);
	dist = x(n2+2:n) - x(1:n-n2-1);
	i = min(find (dist == min(dist)));
	mode = 0.5 * (x(i) + x(i+n2+1));
end