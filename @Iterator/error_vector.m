function [ out ] = error_vector( it )
%ERROR_VECTOR
%%
%

out = [df_dt(it.tf), dP_probe(it.tf), dP_signal(it.tf)]';

%out = df_dt(E, Omega, f, n, B_probe, B_signal)';

end
