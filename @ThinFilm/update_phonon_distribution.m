function [ out ] = update_phonon_distribution( tf )
%UPDATE_PHONON_DISTRIBUTION
%%
%

out = (- phonon_integral_B(tf.sc) - phonon_injection(tf)) ...
    ./ phonon_integral_A(tf.sc);

end

