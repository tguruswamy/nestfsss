function [ out ] = thermalfermidist( En, T )
%THERMALFERMIDIST Thermal Fermi Distribution f(E, T)
%%
% $$f(E, T) = \frac{1}{\exp{\frac{E}{k_B T}} + 1}$$
%

c = Constants;

out = 1 ./ (exp(En ./ (c.K_B * T)) + 1);

end