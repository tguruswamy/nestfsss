function [out,t] = sigma_s( sc, Pabs )
%SIGMA_S Calculate Sigma_s from two-temperature exponential expression

%replace with log-linear approximation?
eta_2D = eta_2Delta_phonon(sc);

taul = sc.tau_l;

%replace with log-linear approximation?
taupb = tau_pb(sc);

effT = T_N(sc);
Delta = sc.Delta;
K_B = sc.K_B;
T_B = sc.T_B;

t = effT * exp(-2*delta_from_temperature(sc, effT)/K_B/effT) ...
    - T_B * exp(-2*delta_from_temperature(sc, T_B)/K_B/T_B);

%Pabs should be in W/m^3
out = Pabs * eta_2D * (1+taul/taupb) / t;

end

