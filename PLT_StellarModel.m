%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%

clc;
close all;
clear variables;

DEF_Constants;

% stellar data taken from:
% An Introduction to Modern Astrophysics, 2nd Ed.
% B. Carroll, D. Ostlie
% Cambridge University Press
stellardata = [  0.21     0.0076  3170; % M5
                 0.51     0.077   3840; % M0
                 0.61     0.216   4410; % K5
                 0.79     0.552   5150; % K0
                 1.0      1.0     5777; % Sun
                 1.4      2.56    6650; % F5
                 1.6      5.21    7300; % F0
                 2       12.3     8190; % A5
                 2.9     39.4     9800; % A0
                 5.9    480      15200; % B5
                17.5  32500      30000; % B0
                23   147000      35800; % O8
                37   324000      39500  % O6
              ];

fprintf (' n  Ms/Msun     Ls/Lsun     Te\n');
fprintf ('--  -------  ----------  -----\n');
for i = 1:size (stellardata, 1)
  fprintf ('%2i  %7.2f  %10.3f  %5i\n', i, stellardata (i, 1), stellardata (i, 2), stellardata (i, 3));
end

n = input ('Select number [default all]: ');
if isempty (n)
  nmin = 1;
  nmax = size (stellardata, 1);
else
  nmin = n;
  nmax = n;
end

for n=nmin:nmax
  % boundary values
  Ms = stellardata (n, 1) * Msun;  % kg (total mass)
  Ls = stellardata (n, 2) * Lsun;  % W  (surface luminosity)
  Te = stellardata (n, 3);         % K  (effective temperature)

  % constitutive parameters
  X = 0.70;        % -  (hydrogen mass fraction)
  Z = 0.03;        % -  (metals mass fraction)
  gamma = 5/3;     % -  (adiabatic index)

  [r, Rs, M, P, L, T] = FCT_SolveModelBwd (Ms, Ls, Te, X, Z, gamma);

  % mass density
  rho = FCT_MassDensity (P, T, X, Z);

  % opacity
  kap = FCT_Opacity (rho, T, X, Z);

  fig = figure ('Position', [500 200 650 700], 'PaperSize', [21 21]);
  subplot (3, 2, 1);
  PLF_DualPlotSingleAxis ('(a) mass', 'M [kg]', r ./ Rs, M);
  subplot (3, 2, 2);
  PLF_DualPlotSingleAxis ('(b) mass density', '\rho [kg/m^3]', r ./ Rs, rho);
  subplot (3, 2, 3);
  PLF_DualPlotSingleAxis ('(c) pressure', 'P [Pa]', r ./ Rs, P);
  subplot (3, 2, 4);
  PLF_DualPlotSingleAxis ('(d) temperature', 'T [K]', r ./ Rs, T);
  subplot (3, 2, 5);
  PLF_DualPlotSingleAxis ('(e) luminosity', 'L [W]', r ./ Rs, L);
  subplot (3, 2, 6);
  PLF_DualPlotSingleAxis ('(f) opacity', 'log \kappa [m^2/kg]', r ./ Rs, log (kap));
  if ~exist ('OCTAVE_VERSION', 'builtin')
    sgtitle (sprintf ('M = %.1f M_%c     X = %.2f     Z = %.2f     \\gamma = %.2f', Ms / Msun, char(9737), X, Z, gamma));
  end
  print (fig, sprintf ('figures/stellarmodel(%.2f).pdf', stellardata (n, 1)), '-dpdf', '-r300', '-bestfit');
end
