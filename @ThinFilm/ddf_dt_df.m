function [ out ] = ddf_dt_df( tf )
%DDF_DT_DF d(df_dt)_df
%%
% Derivative of rate of change of quasiparticle distribution
% with respect to quasiparticle distribution

N = tf.sc.N;

mdkpdf = dkprobe_df(tf);
mdksdf = dksignal_df(tf);
out = tf.B_probe * mdkpdf(1:N, 1:N) * tf.enable_probe ...
    + tf.B_signal * mdksdf(1:N, 1:N) * tf.enable_signal ...
    + dphonon_absorption_df(tf.sc) ...
    + dphonon_emission_df(tf.sc) ...
    + dpair_breaking_df(tf.sc);

end
