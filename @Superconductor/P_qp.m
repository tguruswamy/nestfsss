function [ out ] = P_qp( sc )
%P_QP P_qp-phonon
%%
% Power flow from quasiparticles to phonons

E = sc.En;
rho = sc.rho;

i=1:sc.N;
t = sum( ...
    (- phonon_absorption(sc) ...
    - phonon_emission(sc) ...
    - pair_breaking(sc)) ...
    .* E(i) .* rho(i) ...
    );

out = 4 * sc.N0 * sc.bin_width * t;

end
