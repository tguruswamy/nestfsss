function [ out ] = dkprobe_df( tf )
%DKPROBE_DF dK_qp_probe/df
%%
% Derivative of probe drive term with respect to quasiparticle distribution

E = tf.sc.En;
Delta = tf.sc.Delta;
N = tf.sc.N;
bin_width = tf.sc.bin_width;
rho = tf.sc.rho;

j = int32(tf.hnu_p/bin_width);
i = 1:(N+j);

A = zeros(1,N+j);
A(i) = rho(i+j) .* (1 + Delta^2 ./ E(i) ./ E(i+j));

B = zeros(1,N+j);
g = i(i-j>0);
B(g) = rho(g-j) .* (1 + Delta^2 ./ E(g) ./ E(g-j));

out = 2 * (diag(A(1:N),j) + diag(B(j+1:N+j),-j) - diag(A+B));

end
