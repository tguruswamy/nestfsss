function out = sigma_1_thermal( sc, T, omega )
%SIGMA_2_THERMAL BCS conductivity calculated from f in thermal equilibrium, with Delta
%recalculated from f

    hbarw = Constants.HBAR * omega;
    
    sc.Delta = sc.delta_from_temperature(T);
    sc = sc.change_discretisation(max(sc.En));
    
    sc.f = thermalfermidist(sc.En, T);
    sc.n = thermalbosedist(sc.Omega, T);
    
    exactgap = sc.exact_gap();
    newE = sc.En - sc.Delta + exactgap;

    function out = oldf(E)
        out = interp1(sc.En, sc.f, E);
        effT = abs(sc.En(sc.N) / (sc.K_B * log(1/sc.f(sc.N) - 1)));
        out(isnan(out)) = thermalfermidist(E(isnan(out)), effT);
    end

    function out = newf(E)
        out = interp1(newE, sc.f, E);
        effT = abs(newE(sc.N) / (sc.K_B * log(1/sc.f(sc.N) - 1)));
        out(isnan(out)) = thermalfermidist(newE(isnan(out)), effT);
    end

scale_factor = quadgk(@(x) x.^2.*oldf(x)./sqrt(x.^2 - sc.Delta^2), sc.Delta, 20*sc.Delta, 'AbsTol', 0) / ...
    quadgk(@(x) x.^2.*newf(x)./sqrt(x.^2 - exactgap^2), exactgap, 20*exactgap, 'AbsTol', 0);

    function out = f(E)
        out = scale_factor*newf(E);
    end

    function out = integrand(E)
        out = (f(E) - f(E+hbarw)).*abs(E.^2 + exactgap^2 + hbarw*E)./sqrt(E.^2 - exactgap^2)./sqrt((E+hbarw).^2 - exactgap^2);
    end

    function out = intgrd2(E)
        out = (1 - 2*f(E+hbarw)).*abs(E.^2 + exactgap^2 + hbarw*E)./sqrt(E.^2 - exactgap^2)./sqrt((E+hbarw).^2 - exactgap^2);
    end

    if (hbarw > 2*exactgap)
out = 2/hbarw*quadgk(@integrand, exactgap, 20*exactgap, 'AbsTol', 0) + ...
    1/hbarw*quadgk(@intgrd2, exactgap - hbarw, -exactgap, 'AbsTol', 0);
    else
out = 2/hbarw*quadgk(@integrand, exactgap, 20*exactgap, 'AbsTol', 0);
    end

end

