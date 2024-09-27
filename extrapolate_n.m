function [ out ] = extrapolate_n( Omega, n, N )
%EXTRAPOLATE_N
%%
% Calculate values for n(Omega) beyond N based on thermal distribution with
% same n(Omega(N)) == n(Omega(N), T)

c = Constants;

effT = abs(Omega(N) / (c.K_B * log1p(1/n(N))));

out = thermalbosedist(Omega(N+1:end), effT);

end
