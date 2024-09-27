function [ out ] = pair_breaking_rate( sc )
%pair_breaking_rate Rate at which phonons break pairs from C&S equations

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
bin_width = sc.bin_width;
rho = sc.rho;

t = zeros(1,sc.N);
for i=int32(2*Delta/bin_width):sc.N
    Emax = Omega(i)-Delta;
    j=1:int32((Emax-Delta)/bin_width+1);
    Eprime = Omega(i) - E(j);
    m = int32((Eprime - Delta)/bin_width + 1);
    m = m(m>0);
    j = j(m>0);
    t(i) = sum( ...
    rho(j) .* rho(m) ...
    .* (1 + Delta^2 ./ (E(j) .* E(m))) ...
    .* (1-f(j)) .* (1-f(m))   ...
    );
end

out = 1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

end

