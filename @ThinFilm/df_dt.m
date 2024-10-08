function [ out ] = df_dt( tf )
%DF_DT df/dt
%%
% Rate of change of quasiparticle distribution

out = tf.B_probe * k_qp_probe(tf) * tf.enable_probe ...
    + tf.B_signal * k_qp_signal(tf) * tf.enable_signal ...
    + phonon_absorption(tf.sc) ...
    + phonon_emission(tf.sc) ...
    + pair_breaking(tf.sc);

end
