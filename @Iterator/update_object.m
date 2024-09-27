function [ obj ] = update_object( obj, state_vector )
%UPDATE_OBJECT Summary of this function goes here
%   Detailed explanation goes here

N = obj.tf.sc.N;
obj.tf = update_dists(obj.tf, state_vector(1:N));

%B_p = state_vector(N+1);
%B_s = state_vector(N+2);
B_p = obj.tf.Pabs_p / ddPprobe_dBprobe(obj.tf);
B_s = obj.tf.Pabs_s / ddPsignal_dBsignal(obj.tf);
obj.tf.B_probe = B_p;
obj.tf.B_signal = B_s;

end

