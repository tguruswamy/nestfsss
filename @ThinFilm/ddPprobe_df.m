function [ out ] = ddPprobe_df( tf )
%DDP_PROBE_DF d(dPprobe)_df
%%
% Derivative of probe power error term with respect to quasiparticle distribution

E = tf.sc.En;
N = tf.sc.N;
rho = tf.sc.rho;

j = tf.hnu_p/tf.sc.bin_width;

mdkpdf = dkprobe_df(tf);
t = zeros(1,N);
i = 1:(N+j);
for k=1:N
    t(k) = sum( ...
        mdkpdf(i, k)' .* E(i) .* rho(i) );
end

out = 4 * tf.sc.N0 * tf.sc.bin_width * tf.B_probe * t(1:N);

end
