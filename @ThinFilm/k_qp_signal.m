function [ out ] = k_qp_signal(tf)
%K_QP_SIGNAL Quasiparticle signal drive term
%%
% $$h \nu_s = j \Gamma$$
%

E = tf.sc.En;
f = tf.sc.f;
Delta = tf.sc.Delta;
rho = tf.sc.rho;
N = tf.sc.N;
bin_width = tf.sc.bin_width;
hnu_s = tf.hnu_s;

i=1:N;

Eprime = hnu_s - E(i);
m = int32((Eprime - Delta)/bin_width + 1);
m = m(m>0);
i = i(m>0);

C=zeros(1,N);

C(i) = rho(m) .* (1 - Delta^2 ./ E(i) ./ E(m)) ...
    .* (1 - f(m) - f(i));

out1 = 2*C;

ii=1:N;

j=int32(hnu_s/bin_width);

A=zeros(1,N);
B=zeros(1,N);

A(ii) = rho(ii+j) .* (1 + Delta^2 ./ E(ii) ./ E(ii+j)) ...
    .* (f(ii+j) - f(ii));

g = ii(ii-j>0);
B(g) = rho(g-j) .* (1 + Delta^2 ./ E(g) ./ E(g-j)) ...
    .* (f(g) - f(g-j));

out2 = 2 * (A - B) .* heaviside(E(ii) - Delta);

out = out1 + out2;

end
