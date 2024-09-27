function [ out ] = dP_probe( tf )
%DP_PROBE deltaP_probe
%%
% Error in absorbed probe power

E = tf.sc.En;
rho = tf.sc.rho;

i=1:tf.sc.N;
out = 4 * tf.sc.N0 * tf.B_probe * tf.sc.bin_width ...
    * sum(k_qp_probe(tf) .* E(i) .* rho(i)) ...
    - tf.Pabs_p;

end