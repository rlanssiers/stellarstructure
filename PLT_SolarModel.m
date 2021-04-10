%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%

clc;
close all;
clear variables;

DEF_Constants;

if exist ('OCTAVE_VERSION', 'builtin')
  [desc, flag] = pkg ("describe", "io");
  if strcmp (flag, 'Not loaded')
    pkg load io;
  end
end

% Standard Solar Model
% SSM = readtable ('bs05_agsop_data.txt');
SSM = xlsread ('bs05_agsop_data.xlsx');

% boundary values
Ms = Msun;       % kg (solar mass)
Ls = Lsun;       % W  (surface luminosity)
Te = 5777;       % K  (effective temperature)

% constitutive parameters
X = 0.70;        % -  (hydrogen mass fraction)
Z = 0.03;        % -  (metals mass fraction)
gamma = 5/3;     % -  (adiabatic index)

[r, Rs, M, P, L, T] = FCT_SolveModelBwd (Ms, Ls, Te, X, Z, gamma);

% mass density
rho = FCT_MassDensity (P, T, X, Z);

% critical luminosity for radiative/convective energy transport
kap = FCT_Opacity (rho, T, X, Z);
Lcrit = piac16 .* G .* (gamma - 1) .* T.^4 .* M ./ (3 .* kap .* gamma .* P);
if ~exist ('OCTAVE_VERSION', 'builtin')
  Lcrit = smoothdata (Lcrit, 'movmedian', 10);
end

fig = figure ('Position', [500 200 650 700], 'PaperSize', [21 21]);
subplot (3, 2, 1);
PLF_DualPlotSingleAxis ('(a) mass', 'M [10^{30} kg]', r ./ Rs, M ./ 1E30, SSM(:,2), SSM(:,1) .* 1.9891E30 ./ 1E30);
subplot (3, 2, 2);
PLF_DualPlotSingleAxis ('(b) mass density', '\rho [10^5 kg/m^3]', r ./ Rs, rho ./ 1E5, SSM(:,2), SSM(:,4) .* 1000 ./ 1E5);
subplot (3, 2, 3);
PLF_DualPlotSingleAxis ('(c) pressure', 'P [10^{16} Pa]', r ./ Rs, P ./ 1E16, SSM(:,2), SSM(:,5) .* 0.1 ./ 1E16);
subplot (3, 2, 4);
PLF_DualPlotSingleAxis ('(d) temperature', 'T [10^6 K]', r ./ Rs, T ./ 1E6, SSM(:,2), SSM(:,3) ./ 1E6);
subplot (3, 2, 5);
PLF_DualPlotSingleAxis ('(e) luminosity', 'L [10^{26} W]', r ./ Rs, L ./ 1E26, SSM(:,2), SSM(:,6) .* 3.8418E26 ./ 1E26);
plot (r ./ Rs, Lcrit ./ 1E26, 'k');
subplot (3, 2, 6);
plot (0, 0, 'b', 0, 0, 'm', 0, 0, 'k');
axis off;
legend ('model', 'reference', 'critical', 'Location', 'north');
if ~exist ('OCTAVE_VERSION', 'builtin')
  sgtitle (sprintf ('M = M_%c     X = %.2f     Z = %.2f     \\gamma = %.2f', char(9737), X, Z, gamma));
end
print (fig, 'figures/solarmodel.pdf', '-dpdf', '-r300', '-bestfit');
