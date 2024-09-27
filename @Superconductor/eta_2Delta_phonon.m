function [ out ] = eta_2Delta_phonon( sc )
%ETA_2DELTA_PHONON
%%
% Proportion of phonon power flow carried by phonons with
% energy above 2*Delta

Omega = sc.Omega;
n = sc.n;

i = int32(2*sc.Delta/sc.bin_width):sc.N;
t1 = sum( ...
    Omega(i).^3 ...
    .* (n(i) - thermalbosedist(Omega(i), sc.T_B)) ...
    );

j = 1:sc.N;
t2 = sum( ...
    Omega(j).^3 ...
    .* (n(j) - thermalbosedist(Omega(j), sc.T_B)) ...
    );

out = t1/t2;

end

