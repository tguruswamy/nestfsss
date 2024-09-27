function [ out ] = tau_s_thermal( sc, T )
%TAU_S_THERMAL Thermal average quasiparticle scattering time at temperature T
%%

obj = sc;
obj.f = thermalfermidist(obj.En, T);
obj.n = thermalbosedist(obj.Omega, T);

out = tau_s(obj);

end
