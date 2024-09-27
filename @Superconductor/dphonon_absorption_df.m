function [ out ] = dphonon_absorption_df( sc )
%DPHONON_ABSORPTION_DF d(df_dt(phonon_absorption))_df
%%
% Derivative of phonon absorption term with respect to
% quasiparticle distribution

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
N = sc.N;
rho = sc.rho;

A=zeros(1,N);
j=1:N;
for i=1:N;
    A(i) = sum( ...
        Omega(j).^2 .* rho(i+j) ...
        .* (1 - Delta^2./(E(i).*E(i+j))) ...
        .* (n(j) + f(i+j)) ...
        );
end

B=zeros(N,N);
for i=1:N;
    k = i+1:N;
    B(i, k) = Omega(k-i).^2 .* rho(k) ...
        .* (1 - Delta^2./(E(i).*E(k))) ...
        .* (1 + n(k-i) - f(i));
end

t = diag(A) - B;

out = -1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * sc.bin_width * t;

end
