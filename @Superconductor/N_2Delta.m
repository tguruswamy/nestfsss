function [ out ] = N_2Delta( sc )
%N_2Delta Total phonon density above Omega = 2Delta
%%
%

Omega = sc.Omega;
n = sc.n;

i=int32(2*sc.Delta/sc.bin_width):sc.N;
%i=int32(2*sc.Delta/sc.bin_width):length(Omega);
out = 3*sc.nphonon * sc.Nion * sc.bin_width * sum(Omega(i).^2 .* n(i))/ sc.Omega_Debye^3;

end
