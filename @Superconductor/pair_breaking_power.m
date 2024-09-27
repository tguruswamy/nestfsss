function [ out ] = pair_breaking_power( sc )
%pair_breaking_power Contribution to total power flow from pair breaking,
%as a function of phonon energy
%%

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
    .* ((1-f(m)) .* (1-f(i)) .* n(j)) ...
    );
end

out = -1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

end
