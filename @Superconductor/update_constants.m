function [ out ] = update_constants( sc )
%UPDATE_CONSTANTS
%%
% Return value of tau_0_phonon so problem converges

out = (3*sc.nphonon * sc.Nion * sc.tau_0 * (sc.K_B * sc.T_C)^3) ...
    / (2 * pi() * sc.N0 * sc.Delta_0 * sc.Omega_Debye^3);

end
