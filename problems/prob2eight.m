% Solving 2.8 sea floor depth
rhom = 3.30;    d_rhom = 0.01;
rhow = 1.027;   d_rhow = 0.001;
kappa = 1.00;   d_kappa = 0.04;
alpha = 3e-5;   d_alpha = 0.02e-5;
zr = 2500;  d_zr = 200;
Tm = 1300;  d_Tm = 25;
t = 29.7;   d_t = 0.5;
% First do independenty uncertainty in rhoc = rhom - rhow:
rhoc = rhom - rhow; d_rhoc = sqrt (d_rhom^2 + d_rhow^2);
% Get fractional uncertainties of each term
f_rhom = d_rhom/rhom
f_alpha = d_alpha/alpha
f_Tm = d_Tm/Tm
f_kappa = d_kappa/kappa
f_t = d_t/t
f_rhoc = d_rhoc/rhoc
% Get fractional uncertainty in cooling term:
f_dzc = sqrt (f_rhom^2 + f_alpha^2 + f_Tm^2 + ...
    (0.5*f_kappa)^2 + (0.5*f_t)^2 + f_rhoc^2)
% Compute zc
zc = 2 * rhom * alpha * Tm * sqrt (kappa * 1e-6 * t * 1e6 * 365.25 * 86400/pi)/ rhoc
% Final uncertainties in zc
d_zc = f_dzc * zc
% Total uncertainty
dz = sqrt (d_zr^2 + d_zc^2);
% Print final answer
z = zr + zc;
disp (['Sea floor depth is ' num2str(z) ' ± ' num2str(dz)])
% INdividual contributions
disp (['Error from rhom = ' num2str(f_rhom*zc)])
disp (['Error from rhod = ' num2str(f_rhoc*zc)])
disp (['Error from alpha = ' num2str(f_alpha*zc)])
disp (['Error from kappa = ' num2str(0.5*f_kappa*zc)])
disp (['Error from Tm = ' num2str(f_Tm*zc)])
disp (['Error from time = ' num2str(0.5*f_t*zc)])

% Do it as a function
disp ('DOing it via a function')
dz = sqrt (zc*zc*((rhow*d_rhom/(rhoc * rhom))^2 + (d_rhow/rhoc)^2 + (d_alpha/alpha)^2 + (d_Tm/Tm)^2 + (0.5*d_kappa/kappa)^2 + (0.5 * d_t/t)^2) + d_zr^2)
disp (['Error from rhom = ' num2str(zc*(rhow*d_rhom/(rhoc * rhom)))])
disp (['Error from rhow = ' num2str(d_rhow/rhoc*zc)])
disp (['Error from alpha = ' num2str(f_alpha*zc)])
disp (['Error from kappa = ' num2str(0.5*f_kappa*zc)])
disp (['Error from Tm = ' num2str(f_Tm*zc)])
disp (['Error from time = ' num2str(0.5*f_t*zc)])
dzlinear = zc*((rhow*d_rhom/(rhoc * rhom)) + (d_rhow/rhoc) + (d_alpha/alpha) + (d_Tm/Tm) + (0.5*d_kappa/kappa) + (0.5 * d_t/t)) + d_zr

% Do it widh dependent errors
% f_dzc = (d_rhom/rhom) + (d_alpha/alpha) + (d_Tm/Tm) + ...
%     (0.5*d_kappa/kappa) + (0.5*d_t/t) + (d_rhoc/rhoc)
% % Compute zc
% zc = 2 * rhom * alpha * Tm * sqrt (kappa * 1e-6 * t * 1e6 * 365.25 * 86400/pi)/ rhoc
% % Final uncertainties in zc
% d_zc = f_dzc * zc
% % Total uncertainty
% dz = sqrt (d_zr^2 + d_zc^2);
% % Print final answer
% z = zr + zc;
% disp (['Sea floor depth is ' num2str(z) ' ± ' num2str(dz)])
