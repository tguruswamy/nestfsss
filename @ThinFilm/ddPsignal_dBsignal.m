function [ out ] = ddPsignal_dBsignal( tf )
%DDPsignal_DBSIGNAL d(dPsignal)_dBsignal
%%
% Derivative of signal power error term with respect to B_signal

E = tf.sc.En;
rho = tf.sc.rho;

i=1:tf.sc.N;
out = 4 * tf.sc.N0 * tf.sc.bin_width * ...
    sum(k_qp_signal(tf) .* E(i) .* rho(i));

end
