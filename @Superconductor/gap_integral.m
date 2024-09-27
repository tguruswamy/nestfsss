function [ out ] = gap_integral( sc, d, T, upperlim )
%Gap integral
%%
% Evaluate the integral part of ther gap equation

kernel = @(u) tanh(sqrt(d^2 + u.^2).*sc.Delta_0./(2 * sc.K_B * T))./sqrt(d^2+u.^2);

out = quadgk(kernel, 0, upperlim, 'relTol', 1e-12);

end
