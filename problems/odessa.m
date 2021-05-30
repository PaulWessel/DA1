load odessa_north.txt;
load odessa_northwest.txt;
load odessa_west.txt;

% North odessa
n_n = length (odessa_north);
a2 = 2*odessa_north; % Double angles
xr = sum (cosd(a2));
yr = sum (sind(a2));
D_n = (atan2d (yr,xr)/2);
R_n = sqrt (xr.^2 + yr.^2);
Rmean_n = R_n / n_n;
k_n = 1.1441104;    % Interpolated from Table A.16
se_n2 = rad2deg (1/sqrt(n_n*Rmean_n*k_n));
se_n = se_n2 / 2;
conf_n = se_n * 1.96;   % 95% confidence band
disp (['North Odessa fractures contained in ' num2str(D_n-conf_n) ' to ' num2str(D_n+conf_n) ' with mean strike at ' num2str(D_n)])

% Northwest odessa
n_nw = length (odessa_northwest);
a2 = 2*odessa_northwest; % Double angles
xr = sum (cosd(a2));
yr = sum (sind(a2));
D_nw = (atan2d (yr,xr)/2);
R_nw = sqrt (xr.^2 + yr.^2);
Rmean_nw = R_nw / n_nw;
k_nw = 1.0931152;    % Interpolated from Table A.16
se_nw2 = rad2deg (1/sqrt(n_nw*Rmean_nw*k_nw));
se_nw = se_nw2 / 2;
conf_nw = se_nw * 1.96;   % 95% confidence band
disp (['Northwest Odessa fractures contained in ' num2str(D_nw-conf_nw) ' to ' num2str(D_nw+conf_nw) ' with mean strike at ' num2str(D_nw)])

% Wwest odessa
n_w = length (odessa_west);
a2 = 2*odessa_west; % Double angles
xr = sum (cosd(a2));
yr = sum (sind(a2));
D_w = (atan2d (yr,xr)/2);
R_w = sqrt (xr.^2 + yr.^2);
Rmean_w = R_w / n_w;
k_w = 1.2754475;    % Interpolated from Table A.16
se_w2 = rad2deg (1/sqrt(n_w*Rmean_w*k_w));
se_w = se_w2 / 2;
conf_w = se_w * 1.96;   % 95% confidence band
disp (['West Odessa fractures contained in ' num2str(D_w-conf_w) ' to ' num2str(D_w+conf_w) ' with mean strike at ' num2str(D_w)])
