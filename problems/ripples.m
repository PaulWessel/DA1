% Solving the ripple problem in Chapter 9
A = load ('ripple_A.txt');
B = load ('ripple_B.txt');
% Analyze A:
na = length (A);
c = cosd (A);	s = sind (A);
xr = sum(c);	yr = sum(s);
thetaa = atan2d (xr, yr) + 360	% Mean direction in degrees
Ra = hypot (xr, yr)
Ra_bar = Ra / na
k=2.74;
se = 1/sqrt (Ra*k);
banda=se * 1.96 * 180/pi
should_be=200
% Analyze B:
nb = length (B);
c = cosd (B);	s = sind (B);
xr = sum(c);	yr = sum(s);
thetab = atan2d (xr, yr) + 360	% Mean direction in degrees
Rb = hypot (xr, yr)
Rb_bar = Rb / nb
% Combine
AB = [A; B];
n = length (AB) ;
c = cosd (AB);	s = sind (AB);
xr = sum(c);	yr = sum(s);
thetaab = atan2d (xr, yr) + 360	% Mean direction in degrees
Rab = hypot (xr, yr)
Rab_bar = Rab / n
k = 1.3257;
F = (1 + 3/(8*k))*((n-1)*(Ra + Rb - Ra)/(n - Ra - Rb))
