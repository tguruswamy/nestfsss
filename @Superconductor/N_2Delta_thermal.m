function [ out ] = N_2Delta_thermal( sc, T )
%N_2Delta_thermal Total phonon density above Omega = 2Delta for a thermal
%distribution
%%

obj = sc;
obj.f = thermalfermidist(obj.En, T);
obj.n = thermalbosedist(obj.Omega, T);

out = N_2Delta(obj);
%out2 = 3*sc.nphonon*sc.Nion/sc.Omega_Debye^3 * (Constants.K_B*T)^3 * quadgk(@(x) x.^2./(exp(x) - 1), 2*sc.Delta/Constants.K_B/T, inf);
%(out2 - out)/out

end
