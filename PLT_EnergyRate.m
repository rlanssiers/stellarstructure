%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%

clc;
close all;
clear variables;

DEF_Constants;

X = 0.70;
Z = 0.02;
rho = 1;

T = linspace (5, 30);

fig = figure ('PaperType', 'a5', 'PaperOrientation', 'landscape');

[eps_pp, eps_cno] = FCT_EnergyRate (rho, T .* 1E6, X, Z);
semilogy (T, eps_pp ./ (rho .* 1E-3 .* X.^2), 'LineWidth', 1.5, 'DisplayName', 'pp chains');
hold on;
semilogy (T, eps_cno ./ (rho .* 1E-3 .* X .* Z), 'LineWidth', 1.5, 'DisplayName', 'CNO cycles');

grid on;
legend ('show', 'Location', 'northwest');
xlabel ('T [10^6 K]');
ylim ([1E-10 1E2]);
ylabel ('\epsilon / \rho X^2');

print (fig, 'figures/energyrate', '-dpdf', '-r300', '-bestfit');
