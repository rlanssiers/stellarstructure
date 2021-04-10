%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  [r, Rs, M, P, L, T] = FCT_SolveModelBwd (Ms, Ls, Ts, X, Z, gamma)
%
%  Ms    - total mass (scalar)
%  Ls    - surface luminosity (scalar)
%  Ts    - surface temperature (scalar)
%  X     - hydrogen mass fraction (scalar)
%  Z     - metal mass fraction (scalar)
%  gamma - adiabatic index (scalar)
%
%  r     - radius (vector)
%  Rs    - surface radius (scalar)
%  M     - mass (vector)
%  P     - pressure (vector)
%  L     - luminosity (vector)
%  T     - temperature (vector)
%

function [r, Rs, M, P, L, T] = FCT_SolveModelBwd (Ms, Ls, Ts, X, Z, gamma)
  global sigma Rsun;
  
  % surface radius
  Rs = sqrt (Ls / (4 * pi * sigma * Ts^4));
  fprintf ('Radius = %.1f x Rsun\n', Rs / Rsun);

  % surface pressure
  Ps = FCT_SurfacePressure (Ms, Ls, Ts, X, Z);

  %opts = odeset ('RelTol', 1E-6, 'AbsTol', 1E-9);
  opts = odeset ('NonNegative', 1:4);

  rrange = [Rs (0.01 * Rs)];
  F0 = [Ms Ps Ls Ts];
  % Gnu Octave only allows ode45, ode23, ode15s or ode15i
  [r, F] = ode23 (@(r, F) ODE_FctOfRadius (r, F, X, Z, gamma), rrange, F0, opts);
  
  M = F(:,1);
  P = F(:,2);
  L = F(:,3);
  T = F(:,4);
end