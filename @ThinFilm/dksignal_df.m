function [ out ] = dksignal_df( tf )
%DKSIGNAL_DF dK_qp_signal/df
%%
% Derivative of signal drive term with respect to quasiparticle distribution

E = tf.sc.En;
Delta = tf.sc.Delta;
N = tf.sc.N;
bin_width = tf.sc.bin_width;
rho = tf.sc.rho;

j = int32(tf.hnu_s/bin_width);
i = 1:N;

Eprime = tf.hnu_s - E(i);
m = int32((Eprime - Delta)/bin_width + 1);
m = m(m>0);
i = i(m>0);

A = zeros(1,N);
A(i) = rho(m) .* (1 - Delta^2 ./ E(i) ./ E(m));

B = zeros(N,N);
for k=m
    Eprime = tf.hnu_s - E(k);
    ii=int32((Eprime - Delta)/bin_width + 1);
    B(ii, k) = rho(k) .* (1 - Delta^2 ./ E(ii) ./ E(k));
end

out1 = -2 * (diag(A) + B);

%j = tf.hnu_s/bin_width;
ii = 1:N;

A = zeros(1,N);
A(ii) = rho(ii+j) .* (1 + Delta^2 ./ E(ii) ./ E(ii+j));

B = zeros(1,N);
g = ii(ii-j>0);
B(g) = rho(g-j) .* (1 + Delta^2 ./ E(g) ./ E(g-j));

out2 = 2 * (diag(A(1:N-j),j) + diag(B(j+1:N),-j) - diag(A+B));

out= out1+out2;

end
