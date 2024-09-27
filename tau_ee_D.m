function out = tau_ee_D( R, En )
%TAU_EE_D
%

out = Constants.Q_E^2/(2*pi()^2*Constants.HBAR^2) * R * En ...
    * log(pi() * Constants.HBAR / Constants.Q_E^2 / R);

end

