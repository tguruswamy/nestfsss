function [ out ] = dphonon_emission_df( sc )
%DPHONON_EMISSION_DF d(df_dt(phonon_emission))_df
%%
% Derivative of phonon emission term with respect to
% quasiparticle distribution

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
N = sc.N;
rho = sc.rho;
bin_width = sc.bin_width;

A=zeros(1,N);
for i=1:N
    Omega_max = E(i) - Delta;
    j=1:int32(Omega_max/bin_width); %i-1
    A(i) = sum( ...
        Omega(j).^2 .* rho(i-j) ...
        .* (1 - Delta^2./(E(i).*E(i-j))) ...
        .* (1 + n(j) - f(i-j)) ...
        );
end

B=zeros(N,N);
for i=1:N
    Omega_max = E(i) - Delta;
    k=1:int32(Omega_max/bin_width); %i-1
    B(i, k) = Omega(i-k).^2 .* rho(k) ...
        .* (1 - Delta^2./(E(i).*E(k))) ...
        .* (f(i) + n(i-k));
end

t = diag(A) - B;

out = -1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * sc.bin_width * t;

end
