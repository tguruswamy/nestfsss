function [ out ] = ddf_dt_dBprobe( tf )
%DDF_DT_DBPROBE d(df_dt)_dBprobe
%%
% Derivative of rate of change of quasiparticle distribution
% with respect to B_probe

out = k_qp_probe(tf);

end
