function [ out ] = P_Omega_phonon( sc )
%P_OMEGA_PHONON P(Omega)_phonon-b
%%
% Power flow from phonons to substrate at a specific energy

i=1:int32(length(sc.n));
out = sc.nphonon * sc.Nion * ...
    (3 * sc.Omega(i).^2 /sc.Omega_Debye^3) .* sc.Omega(i) ...
    .* (sc.n(i) - thermalbosedist(sc.Omega(i), sc.T_B))/sc.tau_l ...
    ;

end
