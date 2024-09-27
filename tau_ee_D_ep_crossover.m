function out = tau_ee_D_ep_crossover( sup, R )
%TAU_EE_D
%

out = 3 * sup.tau_0 * (Constants.K_B*sup.T_C)^3 * Constants.Q_E^2/(2*pi()^2*Constants.HBAR^2) * R ...
    * log(pi() * Constants.HBAR / Constants.Q_E^2 / R);

out = sqrt(out);

end

