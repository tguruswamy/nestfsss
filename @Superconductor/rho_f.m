function [ out ] = rho_f( sc, En )
%RHO Quasiparticle Density of States
%%
% $$\rho (E) = \Re \left\{ \frac{E - i\gamma}{\sqrt{(E - i\gamma)^2 - \Delta^2}} \right\} $$

Eprime = En - sc.gamma * 1i;

out = real(Eprime ./ sqrt( (Eprime) .^ 2 - sc.Delta^2 ));

end