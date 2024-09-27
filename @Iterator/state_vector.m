function [ out ] = state_vector( it )
%STATE_VECTOR
%%
%

N = it.tf.sc.N;

out = [it.tf.sc.f(1:N), it.tf.B_probe, it.tf.B_signal]';

%out = f(1:N)';

end
