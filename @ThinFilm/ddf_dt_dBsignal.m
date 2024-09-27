function [ out ] = ddf_dt_dBsignal( tf )
%DDF_DT_DBSIGNAL d(df_dt)_dBsignal
%%
% Derivative of rate of change of quasiparticle distribution
% with respect to B_signal

out = k_qp_signal(tf);

end
