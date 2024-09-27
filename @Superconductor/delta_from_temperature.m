function [ out ] = delta_from_temperature( sc, T )
%DELTA_FROM_TEMPERATURE
%%
% Find the superconducting energy gap
% D which provides the temperature T

if T==0
    out = sc.Delta_0;
    return
elseif T >= sc.T_C
    out = 0;
    return
end

func = @(d) (1/sc.N0V - gap_integral(sc, d, T, sc.Omega_Debye/sc.Delta_0));

options = optimset(optimset('fzero'), 'TolX', 1E-12);
try
    out = fzero(func, [ 0 1 ], options);
catch err
    if strcmp(err.identifier,'MATLAB:fzero:ValuesAtEndPtsSameSign')
        warning('Unable to calculate Delta at T=%g : %s', T, err.message)
        if (T < 0.5*sc.T_C)
            out = sc.Delta_0*(1 - 2*besselk(0, sc.Delta_0/sc.K_B/T));
        else
            out = 1.74*sc.Delta_0*sqrt(1-T/sc.T_C);
        end
        return
    else
        rethrow(err)
    end
end
out = out*sc.Delta_0;

end
