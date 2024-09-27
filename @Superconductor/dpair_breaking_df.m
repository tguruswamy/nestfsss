function [ out ] = dpair_breaking_df( sc )
%DPAIR_BREAKING_DF d(df_dt(pair_breaking))_df
%%
% Derivative of pair breaking term with respect to
% quasiparticle distribution

E = sc.En;
Omega = sc.Omega;
f = sc.f;
n = sc.n;
Delta = sc.Delta;
N = sc.N;
bin_width = sc.bin_width;
rho = sc.rho;

A=zeros(1,N);
m=1:N;
for i=1:N
    j=int32((E(i) + E(m))/bin_width);
    A(i) = sum( ...
        Omega(j).^2 .* rho(m) ...
        .* (1 + Delta^2./(E(i)*E(m))) ...
        .* (f(m) + n(j)) ...
        );
end

B=zeros(N,N);
k=1:N;
for i=1:N
    j=int32((E(i) + E(k))/bin_width);
    B(i, k) = Omega(j).^2 .* rho(k) ...
        .* (1 + Delta^2./(E(i)*E(k))) ...
        .* (n(j) + f(i));
end

t = diag(A) + B;

out = -1/(sc.tau_0 * (sc.K_B * sc.T_C)^3) * bin_width * t;

end
