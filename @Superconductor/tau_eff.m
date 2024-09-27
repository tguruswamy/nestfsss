function [ out ] = tau_eff( sc )
%TAU_EFF Effective quasiparticle lifetime
%%
%

out = tau_r(sc) * (1 + sc.tau_l/tau_pb(sc));

end