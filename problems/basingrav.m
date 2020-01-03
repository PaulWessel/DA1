% Solve 5.9 basin gravity
D = load ('basingrav.txt');
x = D(:,1); f = D(:,2); n = length (x);
clf
subplot (3,1,1)
plot (x, f, '+')
G = [ones(n,1) x g_basin(x,20,0,5,1)];
s = G \ f;
ff = s(1) + s(2)*x + s(3)*g_basin(x,20,0,5,1);
hold on
plot (x, ff)
subplot (3,1,2)
E_min = 1e100;
zz = (3:0.1:6)';
nz = length(zz);
EE = zeros(size(zz));
rho = zeros(size(zz));
for k = 1:nz
    G(:,3) = g_basin(x,20,0,zz(k),1);
    s = G \ f;
    e = G*s - f;
    E = e'*e;
    if (E < E_min)
        E_min = E;
        b = k;
        s_b = s;
    end
    rho(k) = s(3);
    EE(k) = E;
end
kk = find (zz == 4.0);
disp(['Density contrast if depth = 4 km is ' num2str(rho(kk)) ' and sediment density is ' num2str(rho(kk)+2670) ' with misfit ' num2str(EE(kk))])
disp(['Density contrast if depth = ' num2str(zz(b)) ' km is ' num2str(rho(b)) ' and sediment density is ' num2str(rho(b)+2670) ' with misfit ' num2str(EE(b))])
plot (zz, EE)
hold on
plot (zz(b), EE(b), '*')
plot (zz(kk), EE(kk), 'b*')
xlabel ('Basin depth')
ylabel ('Misfit')
subplot (3,1,3)
plot (zz, rho)
hold on
plot (zz(b), rho(b), '*')
plot (zz(kk), rho(kk), 'b*')
xlabel ('Basin depth')
ylabel ('Density contrast')
subplot (3,1,1)
ff = s_b(1) + s_b(2)*x + s_b(3)*g_basin(x,20,0,zz(b),1);
plot (x, ff, 'k--')
% A = [x ff];
% save g_basin_model.txt A -ascii -tabs
% A = [rho zz EE];
% save g_basin_fit.txt A -ascii -tabs

