function [ out ] = max_scattering_rate( sc )
%max_scattering_rate Maximum possible scattering rate, ignoring details of
%distribution

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
bin_width = sc.bin_width;
rho = sc.rho;

% t1 = zeros(1,sc.N);
% j=1:sc.N;
% for i=1:sc.N
%     Eprime = E(i) + Omega(j);
%     m = int32((Eprime - Delta)/bin_width + 1);
%     t1(i) = sum( ...
%     Omega(j) .^ 2 .* rho(m) ...
%     .* (1 - Delta^2 ./ (E(i) .* E(m))) ...
%     .* n(j) .* (1-f(m)) ...
%     );
% end

t2 = zeros(1,sc.N);
for i=1:sc.N
    Omega_max = E(i) - Delta;
    j=1:int32(Omega_max/bin_width); %i-1
    Eprime = E(i) - Omega(j);
    m = int32((Eprime - Delta)/bin_width + 1);
    t2(i) = sum( ...
    Omega(j) .^ 2 .* rho(m) ...
    .* (1 - Delta^2 ./ (E(i) .* E(m))) ...
    );
end

out = 1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * (t2);

end

