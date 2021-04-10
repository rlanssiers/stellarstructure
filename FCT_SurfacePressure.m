%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  Ps = FCT_SurfacePressure (Ms, Ls, Ts, X, Z)
%
%  Ms    - total mass (vector)
%  Ls    - surface luminosity (vector)
%  Ts    - surface temperature (vector)
%  X     - hydrogen mass fraction (scalar)
%  Z     - metal mass fraction (scalar)
%
%  Ps    - surface pressure (vector)
%

function Ps = FCT_SurfacePressure (Ms, Ls, Ts, X, Z)
  global piac16 G kB mH;

  % guillotine factor assumed to be 10
  kappa = 3.68E18 * (1 - Z) * (1 + X) + 4.34E21 * (1 / 10) * Z * (1 + X);
  mu = FCT_MeanMolecularWeight (X, Z);
  Ps = sqrt (piac16 * G * Ms * kB / (12.75 * Ls * kappa * mu * mH)) * Ts^4.25;
end