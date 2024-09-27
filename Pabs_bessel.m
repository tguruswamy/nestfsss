function [out,t] = Pabs_bessel(sc, eta2D, effT)
    
    function out = bessel_series(y)
        out = 30*besselk(0,y).*besselk(1,y) + 25*besselk(1,y).*besselk(2,y) + ...
            5*besselk(0,y).*besselk(3,y) + 3*besselk(2,y).*besselk(3,y) + besselk(1,y).*besselk(4,y);
    end

    t = delta_from_temperature(sc, effT)^5*bessel_series(delta_from_temperature(sc, effT)/sc.K_B/effT) - ...
       sc.Delta^5*bessel_series(sc.Delta/sc.K_B/sc.T_B);

    out = 1./eta2D ./ (1+sc.tau_l./sc.tau_pb) .* 4*sc.N0/sc.tau_0/(sc.K_B*sc.T_C)^3/8 * t;
end