function [ out ] = dP_signal( tf )
%DP_SIGNAL deltaP_signal
%%
% Error in absorbed signal power

E = tf.sc.En;
rho = tf.sc.rho;

i=1:tf.sc.N;
out = 4 * tf.sc.N0 * tf.B_signal * tf.sc.bin_width ...
    * sum(k_qp_signal(tf) .* E(i) .* rho(i)) ...
    - tf.Pabs_s;

end