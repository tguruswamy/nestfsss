function [ out ] = thermalbosedist( Omega, T )
%THERMALBOSEDIST Thermal Bose Distribution n(Omega, T)
%%
% $$n(Omega, T) = \frac{1}{\exp{\frac{Omega}{k_B T}} - 1}$$
%

c = Constants;

out = 1 ./ expm1(Omega ./ (c.K_B * T));

end