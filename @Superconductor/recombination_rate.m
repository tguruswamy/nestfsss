function [ out ] = recombination_rate( sc )
%recombination_rate Rate of quasiparticle recombination, from C&S

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
bin_width = sc.bin_width;
rho = sc.rho;

t = zeros(1,sc.N);
m=1:sc.N;
for i=1:sc.N
    j = int32((E(m) + E(i))/bin_width);
    t(i) = 1./(1-f(i)) * sum( ...
    Omega(j) .^ 2 .* rho(m) ...
    .* (1 + Delta^2 ./ (E(i).*E(m))) ...
    .* f(m) .* (n(j) + 1) ...
    );
end

out = 1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

end

