function [out] = T_N_from_P_bessel(sc, eta2D, P)

    function err = inner(T)
        err = P - Pabs_bessel(sc, eta2D, T);
    end

    out = fzero(@inner, [sc.T_B, 0.99*sc.T_C]);
end