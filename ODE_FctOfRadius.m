%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  dFdr = ODE_FctOfRadius (r, F, X, Z, gamma)
%
%  r     - radius
%  F     - [M P L T]
%  X     - hydrogen mass fraction
%  Z     - metal mass fraction
%  gamma - adiabatic index
%
%  dFdr  - [dM/dr dP/dr dL/dr dT/dr]
%

function dFdr = ODE_FctOfRadius (r, F, X, Z, gamma)
  global G piac16;

  rho = FCT_MassDensity (F(2), F(4), X, Z);
  [eps_pp, eps_cno] = FCT_EnergyRate (rho, F(4), X, Z);
  kap = FCT_Opacity (rho, F(4), X, Z);

  dFdr = zeros (size (F));
  dFdr(1) = rho * 4 * pi * r^2;
  dFdr(2) = -G * F(1) * rho / r^2;
  dFdr(3) = (eps_pp + eps_cno) * rho * 4 * pi * r^2;
  dFdr(4) = -3 * kap * rho * F(3) / (piac16 * r^2 * F(4)^3);

  if FCT_IsConvective (gamma, F(2) + dFdr(2) / 2, dFdr(2), F(4) + dFdr(4) / 2, dFdr(4))
    dFdr(4) = (1 - 1 / gamma) * F(4) / F(2) * dFdr(2);
  end
end
