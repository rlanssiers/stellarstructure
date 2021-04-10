%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  kap = FCT_Opacity (rho, T, X, Z)
%
%  rho - mass density (vector)
%  T   - temperature (vector)
%  X   - hydrogen mass fraction (scalar)
%  Z   - metals mass fraction (scalar)
%
%  kap - opacity (vector)
%

function kap = FCT_Opacity (rho, T, X, Z)
  % electon scattering opacity
  kap_es = 0.02 .* (1 + X);
  
  % free-free opacity
  kap_ff = 3.68E18 .* (1 - Z) .* (1 + X) .* rho .* T.^-3.5;
  
  % bound-free opacity (guillotine factor assumed to be 10)
  kap_bf = 4.34E21 .* (1 ./ 10) .* Z .* (1 + X) .* rho .* T.^-3.5;

  % total opacity
  kap = kap_es + kap_ff + kap_bf;
end