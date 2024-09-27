function [ out ] = RT_S2( sc )
%RT_R Rothwarf-Taylor scattering rate S2 == S-
%%
% 2Delta Phonon scattering in rate

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
bin_width = sc.bin_width;
rho = sc.rho;

t = zeros(1,sc.N);
for i=int32(2*sc.Delta/sc.bin_width + 1):sc.N;
    Emax = E(i) - 2*Delta;
    j=1:int32((Emax - Delta)/bin_width + 1);
    t(i) = sum( ...
    rho(j) .* (E(i) - E(j)).^2 ...
    .* (1 - Delta^2 ./ (E(i).*E(j))) ...
    .* (1 - f(j)) ...
    );
end

t2 = 1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

k=int32(2*sc.Delta/sc.bin_width + 1):sc.N;
Nqp_3Delta = 4 *sc.N0 * bin_width * sum(rho(k) .* f(k));
out = 4 * sc.N0 * bin_width * sum(rho(k) .* f(k) .* t2(k)) / Nqp_3Delta;

end
