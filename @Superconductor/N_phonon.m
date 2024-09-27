function [ out ] = N_phonon( sc )
%N_PHONON Total phonon number density

i = int32(1:sc.N);
out = sc.nphonon * sc.Nion * 3/sc.Omega_Debye^3 * sc.bin_width * sum(sc.n(i).*sc.Omega(i).^2);

end

