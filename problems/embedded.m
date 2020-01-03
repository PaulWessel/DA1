% Embedded.m. Solves problem 7.3 which uses embedded.txt data
% First compute the A-D letters to a transition matrix A
Q = importdata ('embedded.txt');
n = length(Q);
T = zeros(n,1);
m = 4;
A = zeros (m);
for k=1:n
    T(k) = double (Q{k} - 'A') + 1;
    if (k > 1)
        A(T(k-1),T(k)) = A(T(k-1),T(k)) + 1;
    end
end
% Try 30 iterations
% This is the test data from the lecture - commented out
% A = [0 11 36 21 52;
%     28 0 4 4 0;
%     34 2 0 45 13;
%     29 1 45 0 3;
%     28 23 9 8 0]
% m = 5;
new_diag = 1000 * ones (1,m);
for k=1:30
    A_try = A + diag(new_diag)
    rtot = sum (A_try')'    % Row totals
    tot = sum(rtot)    % Total sum
    dprob = rtot / tot % Diagonal probabilities
    new_diag = round (dprob .* rtot)   % New diagonal entries
end
P = dprob * dprob'
E = P * tot
for k = 1:m
    E(k,k) = 0;
end
A
E
q = find (A > 0);
chi2 = sum (((A(q(:)) - E(q(:))).^2)./E(q(:)))
nu = (m-1)^2
