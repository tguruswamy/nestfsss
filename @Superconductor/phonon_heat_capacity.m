function out = phonon_heat_capacity( sc, T )
%PHONON_HEAT_CAPACITY Low-temperature Debye phonon heat capacity

out = 4/5*pi^4*sc.nphonon*sc.Nion*sc.K_B*(T/sc.theta_D).^3;

end

