%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  rho = FCT_MassDensity (P, T, X, Z)
%
%  P    - pressure (vector)
%  T    - temperature (vector)
%  X    - hydrogen mass fraction (scalar)
%  Z    - metal mass fraction (scalar)
%
%  rho  - mass density (vector)
%

function rho = FCT_MassDensity (P, T, X, Z)
  global a kB mH;

  Xv = X + zeros (size (P));
  Zv = Z + zeros (size (P));
  mu = FCT_MeanMolecularWeight (Xv, Zv);

  Prad = a .* T.^4 ./ 3;
  Pgas = P - Prad;
  rho = Pgas .* mu .* mH ./ (kB .* T);
end