function out = tau_s( sc )
%TAU_S Nonequilibrium distribution-averaged quasiparticle scattering time

i = 1:sc.N;

avg_scattering_rate = 4*sc.N0*sc.bin_width*sum(sc.f(i).*sc.rho(i).*scattering_rate(sc));
out = sc.N_qp/avg_scattering_rate;

end

