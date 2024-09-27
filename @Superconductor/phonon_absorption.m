function [ out ] = phonon_absorption( sc )
%PHONON_ABSORPTION df_dt(phonon_absorption)
%%
% Phonon absorption contribution to df_i/dt

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
rho = sc.rho;
bin_width = sc.bin_width;
N = sc.N;

t = zeros(1,N);
j=1:N;
for i=1:N
    Eprime = E(i) + Omega(j);
    m = int32((Eprime - Delta)/bin_width + 1);
    t(i) = sum( ...
    Omega(j) .^ 2 .* rho(m) ...
    .* (1 - Delta^2 ./ (E(i) .* E(m))) ...
    .* (f(i+j) .* f(i) - f(i+j) + (f(i) - f(i+j)) .* n(j)) ...
    );
end

out = -1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * sc.bin_width * t;

end
