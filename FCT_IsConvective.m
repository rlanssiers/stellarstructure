%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  iscnv = FCT_IsConvective (gamma, P, dP, T, dT)
%
%  gamma - adiabatic index (scalar)
%  P     - pressure (scalar)
%  dP    - pressure difference (scalar)
%  T     - temperature (scalar)
%  dT    - temperature difference (scalar)
%
%  iscnv - true if zone is convective (scalar)
%

function iscnv = FCT_IsConvective (gamma, P, dP, T, dT)
  gamma_ratio = gamma / (gamma - 1);
  dlnPdlnT = (dP / P) / (dT / T);
  iscnv = dlnPdlnT < gamma_ratio;
end