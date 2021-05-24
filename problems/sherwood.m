% Solve problem 6.6 in the book

% Load in data and split out d as permeability and x as the four other
% observations of porosity, matrix conductivity, true formation factor, and
% induced polarization.
name = {'porosity', 'conductivity', 'formation', 'polarization'};
A = importdata ('sherwood.txt', '\t', 1);
data = A.data;
d = data(:,1);
x = data(:,2:5);
% Get the mean value of d and number of data points
md = mean (d);
n = length (d);
% Compute the total sum of squares, SST
SST = sum ((d - md).^2);
% Make array for EES values
ESS = zeros (5,1);
% Fits involving 1 parameter
np = nchoosek (4,1);    % How many such combinations are there?
P = nchoosek (1:4,1);   % List of combinations of 2 parameters
% Solve G*M = d for various parameter
best_R2 = 0;   
for k = 1:np
    G = [x(:,P(k,1)) ];
    m = G \ d;
    dhat = G * m;
    e = d - dhat;
    SSR = sum ((dhat - md).^2);
    R2 = SSR / SST;
    fprintf (1, '1 Combination %s give ESS = %g\n', name{P(k,1)}, 100*R2);
    if (R2 > best_R2)
        best_R2 = R2;
        j = k;
    end
end
fprintf (1, '\nBest 1 Combination was %s which gave ESS = %g\n\n', name{P(j,1)}, 100*best_R2);
ESS(2) = 100*best_R2;
% Fits involving 2 parameters
np = nchoosek (4,2);    % How many such combinations are there?
P = nchoosek (1:4,2);   % List of combinations of 2 parameters
% Solve G*M = d for various pairs of parameters
best_R2 = 0;   
for k = 1:np
    G = [x(:,P(k,1)) x(:,P(k,2)) ];
    m = G \ d;
    dhat = G * m;
    e = d - dhat;
    SSR = sum ((dhat - md).^2);
    R2 = SSR / SST;
    fprintf (1, '2 Combination %s and %s give ESS = %g\n', name{P(k,1)}, name{P(k,2)}, 100*R2);
    if (R2 > best_R2)
        best_R2 = R2;
        j = k;
    end
end
fprintf (1, '\nBest 2 Combination was %s and %s which gave ESS = %g\n\n', name{P(j,1)}, name{P(j,2)}, 100*best_R2);
ESS(3) = 100*best_R2;
% Fit 3
np = nchoosek (4,3);
P = nchoosek (1:4,3);
best_R2 = 0;
for k = 1:np
    G = [x(:,P(k,1)) x(:,P(k,2)) x(:,P(k,3)) ];
    m = G \ d;
    dhat = G * m;
    e = d - dhat;
    SSR = sum ((dhat - md).^2);
    R2 = SSR / SST;    fprintf (1, '3 Combination %s, %s and %s give ESS = %g\n', name{P(k,1)}, name{P(k,2)}, name{P(k,3)}, 100*R2);
    if (R2 > best_R2)
        best_R2 = R2;
        j = k;
    end
end
ESS(4) = 100*best_R2;
fprintf (1, '\nBest 3 Combination %s, %s and %s which gave ESS = %g\n\n', name{P(j,1)}, name{P(j,2)}, name{P(j,3)}, 100*best_R2);
% Fit 4
G = [ x(:,1) x(:,2) x(:,3) x(:,4) ];
m = G \ d;
dhat = G * m;
e = d - dhat;
SSR = sum ((dhat - md).^2);
best_R2 = SSR / SST;    fprintf (1, 'All parameters give ESS = %g\n',100*R2);
ESS(5) = 100*best_R2;
fprintf (1, '\nBest 4 Combination gave ESS = %g\n\n', 100*best_R2);
for k=2:5
    F = (ESS(k)-ESS(k-1)) / ((100 - ESS(k)) / (n - k - 3));
    Fcrit = finv(0.95,1,n-k-3);
    if (F > Fcrit)
        fprintf (1, 'Best combination with %d variables gave F = %g which exceeds critical F = %g. SIGNIFICANT MODEL\n\n', k-1, F, Fcrit);
    else
        fprintf (1, 'Best combination with %d variables gave F = %g which does not exceed critical F = %g. NOT SIGNIFICANT MODEL\n\n', k-1, F, Fcrit);
    end
end
