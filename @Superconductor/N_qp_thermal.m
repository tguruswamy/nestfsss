function [ out ] = N_qp_thermal( sc, T )
%N_QP_THERMAL Number of quasiparticles at temperature T
%

% Approximation for K_B T < Delta
% from de Visser et al, Physical Review Letters (2011)
%out = 2 * sc.N0 * sqrt(2*pi() * sc.K_B * T * sc.Delta) \
%    * exp(-sc.Delta / (sc.K_B * T));

i=1:sc.N;
f=thermalfermidist(sc.En, T);
%use rho_f as this is called before array is populated to help choose gamma
integrand = f(i) .* rho_f(sc, sc.En(i));
out = 4 * sc.N0 * sc.bin_width * sum(integrand);

%out = 4 * sc.N0 * trapz(sc.En(i), integrand);

end

