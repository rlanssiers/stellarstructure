%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  mu = FCT_MeanMolecularWeight (X, Z)
%
%  X  - hydrogen mass fraction (vector)
%  Z  - metals mass fraction (vector)
%
%  mu - mean molecular weight (vector)
%

function mu = FCT_MeanMolecularWeight (X, Z)
  Y = 1 - X - Z;
  mu = 1 ./ (2 .* X + (3 / 4) .* Y + (1 / 2) .* Z);
end