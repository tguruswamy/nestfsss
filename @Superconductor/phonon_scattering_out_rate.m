function [ out ] = phonon_scattering_out_rate( sc )
%phonon_scattering_out_rate Rate at which phonons scatter away from energy
%from C&S equations

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
    .* (1-f(j)).*f(m) ...
...%    .* (f(j)-f(m)) ...
    );
end

out = 1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

end

