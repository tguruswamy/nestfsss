function [ out ] = phonon_scattering_rate( sc )
%phonon_scattering_rate Phonon scattering term in C&S equations

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
bin_width = sc.bin_width;
rho = sc.rho;

t = zeros(1,sc.N);
j=1:sc.N;
for i=1:sc.N
    Eprime = E(j) + Omega(i);
    m = int32((Eprime - Delta)/bin_width + 1);
    t(i) = sum( ...
    rho(j) .* rho(m) ...
    .* (1 - Delta^2 ./ (E(j) .* E(m))) ...
    .* f(j).*(1-f(m)) ...
...%    .* (f(j)-f(m)) ...
    );
end

out = 1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

end

