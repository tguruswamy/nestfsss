function out = exact_gap( sc )
%EXACT_GAP Exact calculation of the energy gap using self-consistency
%equation and interpolated nonequilibrium quasiparticle distribution
%function

if sc.T_B == 0
    out = sc.Delta_0;
    return
elseif sc.T_B >= sc.T_C
    out = 0;
    return
end

    function out = f(E)
        minE = sc.En(1);
        maxE = sc.En(end);
        out((E >= minE) & (E <= maxE)) = interp1(sc.En, sc.f, E((E >= minE) & (E <= maxE)));
        effTend = abs(sc.En(sc.N) / (sc.K_B * log(1/sc.f(sc.N) - 1)));
        out(E > maxE) = thermalfermidist(E(E>maxE), effTend);
        effTbegin = abs(sc.En(1) / (sc.K_B * log(1/sc.f(1) - 1)));
        out(E < minE) = thermalfermidist(E(E<minE), effTbegin);
    end

    function out = gap_integral(sc, D)
        kernel = @(u) (1 - 2*f(u))./sqrt(u.^2 - D^2);
        out = quadgk(kernel, D, sqrt(sc.Omega_Debye^2 + D^2), 'RelTol', 1E-8);
    end

func = @(d) 1/sc.N0V - gap_integral(sc, d);

options = optimset(optimset('fzero'), 'TolX', 1E-18);
out = fzero(func, [ 0 1.1*sc.Delta_0 ], options);

end

