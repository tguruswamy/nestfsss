function [ out ] = ddPprobe_dBprobe( tf )
%DDP_PROBE_DBPROBE d(dPprobe)_dBprobe
%%
% Derivative of probe power error term with respect to B_probe

E = tf.sc.En;
rho = tf.sc.rho;

i=1:tf.sc.N;
out = 4 * tf.sc.N0 * tf.sc.bin_width * ...
    sum(k_qp_probe(tf) .* E(i) .* rho(i));

end
