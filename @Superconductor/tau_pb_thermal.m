function [ out ] = tau_pb_thermal( sc, T )
%TAU_PB_THERMAL Thermal average pair-breaking time at temperature T
%%

obj = sc;
obj.f = thermalfermidist(obj.En, T);
obj.n = thermalbosedist(obj.Omega, T);

out = tau_pb(obj);

end
