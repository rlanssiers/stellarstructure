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

T = logspace (4, 9);

fig = figure ('PaperType', 'a5', 'PaperOrientation', 'landscape');

loglog (T, FCT_Opacity (1E4, T, X, Z), 'LineWidth', 1.5, 'DisplayName', '\rho = 10^4 kg/m^3');
hold on;
loglog (T, FCT_Opacity (1E2, T, X, Z), 'LineWidth', 1.5, 'DisplayName', '\rho = 10^2 kg/m^3');
loglog (T, FCT_Opacity (1, T, X, Z), 'LineWidth', 1.5, 'DisplayName', '\rho = 1 kg/m^3');
loglog (T, FCT_Opacity (1E-2, T, X, Z), 'LineWidth', 1.5, 'DisplayName', '\rho = 10^{-2} kg/m^3');
loglog (T, FCT_Opacity (1E-4, T, X, Z), 'LineWidth', 1.5, 'DisplayName', '\rho = 10^{-4} kg/m^3');

grid on;
legend ('show');
xlabel ('T [K]');
xlim ([1E4 1E9]);
ylabel ('\kappa [m^2/kg]');
ylim ([1E-2 1E2]);

print (fig, 'figures/opacity', '-dpdf', '-r300', '-bestfit');
