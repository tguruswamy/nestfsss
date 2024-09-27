function [ out ] = recombination_power( sc )
%recombination_power Power flow from qp to phonons from recombination

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
rho = sc.rho;
bin_width = sc.bin_width;
N = sc.N;

t = zeros(1,sc.N);
m=1:N;
for i=1:N
    j = int32((E(m) + E(i))/bin_width);
    t(i) = sum( ...
    Omega(j) .^ 2 .* rho(m) ...
    .* (1 + Delta^2 ./ (E(i).*E(m))) ...
    .* (f(m) .* f(i) .* (n(j) + 1)) ...
    );
end

out = -1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

end
