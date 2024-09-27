function out = dn_dt( tf )
%DN_DT Summary of this function goes here
%   Detailed explanation goes here

sc = tf.sc;
N = sc.N;
n = sc.n;

out = phonon_integral_A(sc) .* n(1:N) + phonon_integral_B(sc) + phonon_injection(tf);

end

