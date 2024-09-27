function [ out ] = T_N( sc )
%T_N T_N
%%
% Effective temperature of quasiparticle distribution, calculated by
% matching the number of quasiparticles

% Approximation for K_B T < Delta
% from inverting equation in de Visser et al, Physical Review Letters (2011)

%out = (2 * sc.Delta) / (sc.K_B * lambertw(16 * pi() * sc.N0^2 * sc.Delta^2 / Nqp^2));

Nqp = N_qp(sc);

[out,fval,exitflag] = fminsearch(@nqp_error, sc.T_B);

if (exitflag ~= 1)
    warning('T_N: minimum bound not found; current value %f', fval);
end

    function err = nqp_error( T )
        err = (Nqp - N_qp_thermal( sc, T )).^2 * 1E24;
    end

end
