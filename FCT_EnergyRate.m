%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  [eps_pp, eps_cno] = FCT_EnergyRate (rho, T, X, Z)
%
%  rho     - mass density (scalar)
%  T       - temperature (vector)
%  X       - hydrogen mass fraction (scalar)
%  Z       - metals mass fraction (scalar)
%
%  eps_pp  - energy production rate due to pp-chains (vector)
%  eps_cno - energy production rate due to cno cycle (vector)
%

function [eps_pp, eps_cno] = FCT_EnergyRate (rho, T, X, Z)
  T6 = T ./ 1E6;
  XCNO = Z / 2;

  eps_pp = 0.241 .* rho .* X.^2 .* T6.^(-2/3) .* exp (-33.80 .* T6.^(-1/3));
  eps_cno = 8.67E20 .* rho .* X .* XCNO .* T6.^(-2/3) .* exp (-152.28 .* T6.^(-1/3));
end