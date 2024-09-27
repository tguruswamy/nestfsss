function [ out ] = RT_S1( sc )
%RT_R Rothwarf-Taylor scattering rate S1 == S+
%%
% 2Delta Phonon scattering out rate ...

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
bin_width = sc.bin_width;
rho = sc.rho;

t = zeros(1,sc.N);
j=1:sc.N;
for i=int32(2*sc.Delta/sc.bin_width):sc.N
    Eprime = E(j) + Omega(i);
    k = int32((Eprime - Delta)/bin_width + 1);
    t(i) = sum( ...
    rho(j) .* rho(k) ...
    .* (1 - Delta^2 ./ (E(j).*E(k))) ...
    .* (f(j) - f(k)) ...
    );
end

t2 = 2/(pi * sc.tau_0_phonon * sc.Delta_0) * bin_width * t;

k=int32(2*sc.Delta/sc.bin_width):sc.N;
out = 3 * sc.nphonon * sc.Nion/sc.Omega_Debye^3 * bin_width * sum(Omega(k).^2 .* n(k) .* t2(k)) / N_2Delta(sc);

end
