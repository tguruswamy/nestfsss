function [ out ] = tau_r_thermal( sc, T )
%TAU_R_THERMAL Thermal average recombination time at temperature T
%%
% from de Visser et al, Physical Review Letters (2011)
% Approximation for K_B T < Delta

%out = sc.tau_0 / sqrt(pi()) * (sc.K_B * sc.T_C / (2 * sc.Delta))^(5/2) ...
%    * sqrt(sc.T_C /  T) * exp( sc.Delta / (sc.K_B * T));

obj = sc;
obj.f = thermalfermidist(obj.En, T);
obj.n = thermalbosedist(obj.Omega, T);

out = tau_r(obj);

end
