function [out,t] = Pabs_by_sigma(sc, taupb, eta2D, effT)
    Delta = sc.Delta;
    K_B = sc.K_B;
    T_B = sc.T_B;

    taul = sc.tau_l;

    t = effT * exp(-2*delta_from_temperature(sc, effT)/K_B/effT) ...
        - T_B * exp(-2*delta_from_temperature(sc, T_B)/K_B/T_B);

    %units of K
    out = 1./eta2D ./ (1+taul./taupb) .* t;
end