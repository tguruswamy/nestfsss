function [ out ] = ddPsignal_df( tf )
%DDP_SIGNAL_DF d(dPsignal)_df
%%
% Derivative of signal power error term with respect to quasiparticle distribution

E = tf.sc.En;
N = tf.sc.N;
rho = tf.sc.rho;

mdksdf = dksignal_df(tf);
t = zeros(1,N);
i = 1:N;
for k=1:N
    t(k) = sum( ...
        mdksdf(i, k)' .* E(i) .* rho(i) );
end

out = 4 * tf.sc.N0 * tf.sc.bin_width * tf.B_signal * t(1:N);

end
