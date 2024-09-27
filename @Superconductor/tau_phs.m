function out = tau_phs( sc )
%TAU_PHS Nonequilibrium distribution-averaged phonon scattering time

i = 1:sc.N;

avg_scattering_rate = 4*sc.N0*sc.bin_width*sum(sc.n(i).*sc.Omega(i).^2.*(phonon_scattering_rate(sc)-phonon_scattering_out_rate(sc)));
out = sc.N_phonon/avg_scattering_rate;

end

