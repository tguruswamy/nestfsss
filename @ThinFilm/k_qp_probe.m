function [ out ] = k_qp_probe(tf)
%K_QP_PROBE Quasiparticle probe drive term
%%
% $$h \nu_p = j \Gamma$$
%

E = tf.sc.En;
f = tf.sc.f;
N = tf.sc.N;
bin_width = tf.sc.bin_width;
Delta = tf.sc.Delta;
rho = tf.sc.rho;

i=1:N;
j=int32(tf.hnu_p/bin_width);

A=zeros(1,N);
B=zeros(1,N);

A(i) = rho(i+j) .* (1 + Delta^2 ./ E(i) ./ E(i+j)) ...
    .* (f(i+j) - f(i));

g = i(i-j>0);
B(g) = rho(g-j) .* (1 + Delta^2 ./ E(g) ./ E(g-j)) ...
    .* (f(g) - f(g-j));

out = 2 * (A - B) .* heaviside(E(i) - Delta);

end
