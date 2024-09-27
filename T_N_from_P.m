function [out] = T_N_from_P(sc, taupb, eta2D, P)
% P in Watts / m^3

    function err = inner(T)
        err = P - sc.sigma*Pabs_by_sigma(sc, taupb, eta2D, T);
    end

    out = fzero(@inner, [sc.T_B, 0.99*sc.T_C]);
end