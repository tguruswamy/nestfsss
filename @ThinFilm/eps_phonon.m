function [ out ] = eps_phonon( tf )
%EPS_PHONON eps_phonon-b
%%
% Phonon to substrate power flow error term
if isempty(tf.enable_phonon)
    tf.enable_phonon = 0;
end
if isempty(tf.Pabs_phonon_spec)
    tf.Pabs_phonon_spec = 0;
end

Pabs_t = tf.Pabs_p + tf.Pabs_s + tf.Pabs_phonon;

out = (Pabs_t - P_phonon(tf.sc)) / Pabs_t;

end
