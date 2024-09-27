function [ out ] = extrapolate_f( En, f, N )
%EXTRAPOLATE_F
%%
% Calculate values for f(E) beyond N based on thermal distribution with
% same f(E(N)) == f(E(N), T)

c = Constants;

effT = abs(En(N) / (c.K_B * log(1/f(N) - 1)));

out = thermalfermidist(En(N+1:end), effT);

end
