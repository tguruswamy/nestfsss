function [ out ] = scattering_in_rate( sc )
%scattering_rate Rate at which quasiparticles of energy E(i) are created by scattering

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
bin_width = sc.bin_width;
rho = sc.rho;

t1 = zeros(1,sc.N);
j=1:sc.N;
for i=1:sc.N
    Eprime = E(i) + Omega(j);
    m = int32((Eprime - Delta)/bin_width + 1);
    t1(i) = sum( ...
    Omega(j) .^ 2 .* rho(m) ...
    .* (1 - Delta^2 ./ (E(i) .* E(m))) ...
    .* (n(j)+1) .* f(m) .* (1-f(i)) ...
    );
end

t2 = zeros(1,sc.N);
for i=1:sc.N
    Omega_max = E(i) - Delta;
    j=1:int32(Omega_max/bin_width); %i-1
    Eprime = E(i) - Omega(j);
    m = int32((Eprime - Delta)/bin_width + 1);
    t2(i) = sum( ...
    Omega(j) .^ 2 .* rho(m) ...
    .* (1 - Delta^2 ./ (E(i) .* E(m))) ...
    .* n(j) .* f(m) .* (1-f(i)) ...
    );
end

out = 1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * (t1+t2);

end

