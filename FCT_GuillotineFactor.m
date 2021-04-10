%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  tgbf = FCT_GuillotineFactor (rho, X)
%
%  rho  - mass density (vector)
%  X    - hydrogen mass fraction (scalar)
%
%  tgbf - guillotine factor for bound-free opacity (vector)
%

function tgbf = FCT_GuillotineFactor (rho, X)
  tgbf = 2.82 .* (1E-3 .* rho .* (1 + X)).^0.2;
end