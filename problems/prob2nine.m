% Problem 2.9
xb = 252000;   dxb = 10000;
rhom = 3300;    drhom = 50;
nu = 0.25; dnu = 0.01;
E = 70e9;   dE = 7e9;
g = 9.81;
rhow = 1027;

h = ((3*xb^4*(rhom-rhow)*g*(1-nu^2))/(pi^4*E))^(1/3)
d_err_xb = 4*dxb/(3*xb)
d_err_rhom = drhom/(3*(rhom-rhow))
d_err_nu = 2*nu*dnu / (3*(1 - nu^2))
d_err_E = dE/(3*E)

err_xb = d_err_xb * h
err_rhom = d_err_rhom * h
err_nu = d_err_nu * h
err_E = d_err_E * h

indep_d_err = sqrt (d_err_xb^2 + d_err_rhom^2 + d_err_nu^2 + d_err_E^2)
dep_d_err = d_err_xb + d_err_rhom + d_err_nu + d_err_E
indep_err = sqrt (err_xb^2 + err_rhom^2 + err_nu^2 + err_E^2)
dep_err = err_xb + err_rhom + err_nu + err_E

D = E 