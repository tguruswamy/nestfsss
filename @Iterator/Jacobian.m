function [ out ] = Jacobian( it )
%JACOBIAN
%%
%

N = it.tf.sc.N;
tf = it.tf;

out = zeros(N+2, N+2);
%out = zeros(N, N);

out(1:N, 1:N) = ddf_dt_df(tf);

%last columns
out(1:N, N+1) = ddf_dt_dBprobe(tf) * tf.enable_probe;
out(1:N, N+2) = ddf_dt_dBsignal(tf) * tf.enable_signal;

%last rows
out(N+1, 1:N) = ddPprobe_df(tf) * tf.enable_probe;
out(N+2, 1:N) = ddPsignal_df(tf) * tf.enable_signal;

if (tf.enable_probe == 1)
    out(N+1, N+1) = ddPprobe_dBprobe(tf);
else
    out(N+1, N+1) = 1;
end

if (tf.enable_signal == 1)
    out(N+2, N+2) = ddPsignal_dBsignal(tf);
else
    out(N+2, N+2) = 1;
end

end
