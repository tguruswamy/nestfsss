function [ out ] = phonon_emission( sc )
%PHONON_EMISSION df_dt(phonon_emission)
%%
% Phonon emission contribution to df_i/dt

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
rho = sc.rho;
bin_width = sc.bin_width;
N = sc.N;

t = zeros(1,N);
for i=1:N
    Omega_max = E(i) - Delta;
    j=1:int32(Omega_max/bin_width); %i-1
    Eprime = E(i) - Omega(j);
    m = int32((Eprime - Delta)/bin_width + 1);
    t(i) = sum( ...
    Omega(j) .^ 2 .* rho(m) ...
    .* (1 - Delta^2 ./ (E(i) .* E(m))) ...
    .* (f(i) - f(i).*f(i-j) + (f(i) - f(i-j)).*n(j)) ...
    );
end

out = -1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

end
