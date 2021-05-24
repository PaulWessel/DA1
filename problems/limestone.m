% Solve problem 7.6
d = load ('limestone.txt');
% Get median thickness
dm = median (d);
dt = d - dm
s = sign (dt);
% Replace zeros with -1
k = find (s == 0);
s(k) = -1
% manual inspection gives number of runs U = 12
% n1 (-1) = 11 and n2 (+1) = 8
% We find U critical = 13 at alpha = 0.05
% We therefore reject the null hypothesis
% that there is no trend .
