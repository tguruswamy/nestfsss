function [ out ] = phonon_injection( tf )
%PHONON_INJECTION Summary of this function goes here
%   Detailed explanation goes here

sc = tf.sc;
A = tf.Pabs_phonon / (sc.bin_width*sc.nphonon*sc.Nion*3* tf.hnu_phonon^3/sc.Omega_Debye^3);
j = int32(tf.hnu_phonon / sc.bin_width);

out = zeros(1,sc.N);
out(j) = A;

end

