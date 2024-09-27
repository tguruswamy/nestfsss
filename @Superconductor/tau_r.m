function [ out ] = tau_r( sc )
%TAU_R Average recombination time
%%
%

out = 1/(2 * RT_R(sc) * N_qp(sc));

end
