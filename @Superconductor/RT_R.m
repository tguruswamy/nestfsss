function [ out ] = RT_R( sc )
%RT_R Rothwarf-Taylor recombination rate R
%%
% Quasiparticle recombination rate, as in Chang & Scalapino

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
    t(i) = sum( ...
    Omega(j) .^ 2 .* rho(m) ...
    .* (1 + Delta^2 ./ (E(i).*E(m))) ...
    .* f(m) .* f(i) .* (n(j) + 1) ...
    );
end

t2 = 1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

k=1:sc.N;
out = 1/2 * 4 * sc.N0 * bin_width * sum(rho(k) .* t2(k)) / N_qp(sc)^2;

end
