function [ out ] = P_phonon( sc )
%P_PHONON P_phonon-b
%%
% Power flow from phonons to substrate

out = sc.bin_width * sum( ...
        P_Omega_phonon(sc) ...
    );

end
