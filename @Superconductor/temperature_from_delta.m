function [ out ] = temperature_from_delta( sc, D, exact )
%TEMPERATURE_FROM_DELTA
%%
% Find the temperature which provides the superconducting energy gap
% D

if nargin < 3
    exact = 0;
end

if D==0
    out = sc.T_C;
    return
elseif D > sc.Delta_0
    warning('Energy gap %g higher than Delta_0 %g', D, sc.Delta_0);
    out = 0;
    return
elseif (D == sc.Delta_0) && ~exact
    out = 0.1*sc.T_C;
    return
end

%approxT = sc.T_C * (1 - (1/1.74)^2*(D/sc.Delta_0)^2);
%if (abs(approxT - sc.T_C)/sc.T_C < 0.001)
%    out = approxT;
%    return
%end

func = @(t) 1/sc.N0V - gap_integral(sc, D/sc.Delta_0, t, sc.Omega_Debye/sc.Delta_0);

try
    out = fzero(func, [ 0 sc.T_C ]);
catch err
    if strcmp(err.identifier,'MATLAB:fzero:ValuesAtEndPtsSameSign')
        %warning('Unable to accurately calculate T at Delta=%g', D)
        if (D < 0.5*sc.Delta_0)
            out = sc.T_C * (1 - (1/1.74)^2*(D/sc.Delta_0)^2);
        else
            out = D/sc.K_B/lambertw(2*pi/log(D/sc.Delta_0));
        end
    else
        rethrow(err)
    end
end

end
