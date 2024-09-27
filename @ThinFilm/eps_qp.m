function [ out ] = eps_qp( tf )
%EPS_QP eps_qp-phonon
%%
% Quasiparticle-phonon power flow error term
if isempty(tf.enable_phonon)
    tf.enable_phonon = 0;
end
if isempty(tf.Pabs_phonon_spec)
    tf.Pabs_phonon_spec = 0;
end

if tf.enable_phonon && ~tf.enable_probe && ~tf.enable_signal
    Pabs_t = tf.Pabs_phonon;
    out = -P_qp(tf.sc) / Pabs_t; %for phonon injection, P_qp should be net zero
else
    Pabs_t = tf.Pabs_p + tf.Pabs_s;
    out = (Pabs_t - P_qp(tf.sc)) / Pabs_t;
end

end
