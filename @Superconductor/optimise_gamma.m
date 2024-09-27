function out = optimise_gamma( sc )
%OPTIMISE_GAMMA
%

obj = sc;

[out,fval,exitflag] = fminsearch(@nqp_error, 0.25);

if (exitflag ~= 1)
    warning('optimise_gamma: minimum bound not found; current value %f', fval);
end

    function err = nqp_error( g )
        obj.gamma = g;
        err = (exact_nqp( obj, obj.T_B ) - N_qp_thermal( obj, obj.T_B )).^2 * 1E24;
    end

end

