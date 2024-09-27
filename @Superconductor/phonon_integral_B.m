function [ out ] = phonon_integral_B( sc )
%PHONON_INTEGRAL_B
%%
% Calculate phonon distribution directly from quasiparticle distribution

E = sc.En;
Omega = sc.Omega;
f = sc.f;
Delta = sc.Delta;
bin_width = sc.bin_width;
rho = sc.rho;
N = sc.N;

t1 = zeros(1,N);
j=1:N;
for i=1:N
    Eprime = E(j) + Omega(i);
    m = int32((Eprime - Delta)/bin_width + 1);
    t1(i) = sum(...
    rho(j) .* rho(m) ...
    .* (1 - Delta^2./(E(j).*E(m))) ...
    .* (f(j+i).*f(j) - f(j+i)) ...
    );
end

t2 = zeros(1,N);
for i=int32(2*Delta/bin_width):N
    Emax = Omega(i) - Delta;
    j = 1:int32((Emax-Delta)/bin_width + 1);
    Eprime = Omega(i) - E(j);
    m = int32((Eprime - Delta)/bin_width + 1);
    m = m(m>0);
    j = j(m>0);
    t2(i) = sum(...
    rho(j) .* rho(m) ...
    .* (1 + Delta^2./(E(j).*E(m))) ...
    .* (f(j).*f(m)) ...
    );
end

out = 1/(pi()*sc.tau_0_phonon*sc.Delta_0) * bin_width * (-2*t1 + t2) ...
        + thermalbosedist(Omega(1:N), sc.T_B)/sc.tau_l;

end

