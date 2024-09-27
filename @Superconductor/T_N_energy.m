function [ out ] = T_N_energy( sc )
%T_N_ENERGY
%%
% Effective temperature of quasiparticle distribution, calculated by
% matching the total *energy* of quasiparticles

% Approximation for K_B T < Delta
% from inverting equation in de Visser et al, Physical Review Letters (2011)
%out = (2 * sc.Delta) / (sc.K_B * lambertw(16 * pi() * sc.N0^2 * sc.Delta^2 / Nqp^2));

E_qp_thermal = @(sc, T) 4*sc.N0*sc.bin_width*sum(thermalfermidist(sc.En(1:sc.N), T).*sc.rho(1:sc.N).*sc.En(1:sc.N));

Eqp = 4*sc.N0*sc.bin_width*sum(sc.f(1:sc.N).*sc.rho(1:sc.N).*sc.En(1:sc.N));

[out,fval,exitflag] = fminsearch(@eqp_error, sc.T_B);

if (exitflag ~= 1)
    warning('T_N_energy: minimum bound not found; current value %f', fval);
end

    function err = eqp_error( T )
        err = (Eqp - E_qp_thermal( sc, T )).^2 * 1E24;
    end

end
