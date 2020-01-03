% Solve 5.8 drops on alien planet
D = load('drops.txt')
t = D(:,1);	h = D(:,2);
n = length(t);
G = [ ones(n,1) 0.5*t.^2 ];
s = G \ h;
disp ([' Bias is ' num2str(s(1)) ' and the g_p is ' num2str(s(2))])
