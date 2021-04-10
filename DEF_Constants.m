%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%

%
% Values taken from appendix A in:
%
% Bradley W. Carroll, Dale A. Ostlie
% An Introduction to Modern Astrophysics
% 2nd Edition
% Cambridge University Press
% ISBN 978-1-108-42216-1
%

% Physiscal constants

global sigma a c G kB mH piac16;

sigma = 5.670400E-8;    % W/(m2 K4)  (Stefan-Boltzmann constant)
a = 7.565767E-16;       % J/(m3 K4)  (radiation constant)
c = 2.99792458E8;       % m/s        (speed of light)
G = 6.67428E-11;        % N m2/kg2   (gravitational constant)
kB = 1.3806504E-23;     % J/K        (Boltzmann constant)
mH = 1.673532499E-27;   % kg         (mass of hydrogen atom)

piac16 = 16 * pi * a * c;


% Astronomical constants

global Msun Lsun Rsun Tsun;

Msun = 1.9891E30;       % kg         (solar mass)
Lsun = 3.839E26;        % W          (solar luminosity)
Rsun = 6.95508E8;       % m          (solar radius)
Tsun = 5777;            % T          (solar effective temperature)
