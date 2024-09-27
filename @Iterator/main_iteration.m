function [ out ] = main_iteration( obj, callback,  minN)
%MAIN_ITERATION
%%
% Calculate the driven f(E) and n(Omega).
% Convergence requirements hard-coded below.

%%

out = obj;
out.tf = check_bin_width_and_N(out.tf);
En = out.tf.sc.En;
Omega = out.tf.sc.Omega;
N = out.tf.sc.N;
f = out.tf.sc.f;
n = out.tf.sc.n;

B_p = out.tf.Pabs_p / ddPprobe_dBprobe(out.tf);
B_s = out.tf.Pabs_s / ddPsignal_dBsignal(out.tf);
out.tf.B_probe = B_p;
out.tf.B_signal = B_s;

err_eps = [1, 1];
old_err_eps = [Inf, Inf];
deltaB = [1, 1];
oldB_p = 0;
oldB_s = 0;

%%
it=0;
while (it < out.min_iterations || norm(err_eps) > out.convergence_eps || ...
        norm(deltaB) > out.convergence_deltaB || any(out.tf.sc.f < 0) || any(out.tf.sc.n < 0))
    newstatev = update_state_vector(out);

    f(1:N) = newstatev(1:N);
    f(N+1:end) = extrapolate_f(En, f, N);
    out.tf.sc.f = f;

    n(1:N) = update_phonon_distribution(out.tf);
    n(N+1:end) = extrapolate_n(Omega, n, N);
    out.tf.sc.n = n;

    B_p = out.tf.Pabs_p / ddPprobe_dBprobe(out.tf);
    B_s = out.tf.Pabs_s / ddPsignal_dBsignal(out.tf);
    %B_p = newstatev(N+1);
    %B_s = newstatev(N+2);

    out.tf.B_probe = B_p;
    out.tf.B_signal = B_s;

    err_eps = [eps_qp(out.tf), eps_phonon(out.tf)];

    if ((out.tf.Pabs_p + out.tf.Pabs_s + out.tf.Pabs_phonon) == 0) %no absorbed power
        %use temperature as convergence criteria instead
        err_eps = abs(T_N(out.tf.sc) - out.tf.sc.T_B) .* 1E3;
    end
    deltaB = [(B_p - oldB_p)/B_p, (B_s - oldB_s)/B_s];
    deltaB(isnan(deltaB)) = 0;
    oldB_p = B_p;
    oldB_s = B_s;

    err_eps
    deltaB
    
    if ((~out.tf.enable_phonon) && (it > out.max_iterations/10) && (norm(diff(err_eps)) > 0.75*norm(err_eps)))
        warning('eps_qp %g very different from eps_phonon %g, Probably not converging.', err_eps);
        return
    end

    delta_err_eps = abs(err_eps - old_err_eps);
    %if power flow discrepancy isn't changing, bail out, solution is not
    %converging
    if (((out.tf.enable_phonon && all(delta_err_eps < out.not_converging_delta)) ...
        || (~out.tf.enable_phonon && any(delta_err_eps < out.not_converging_delta))) ...
            && it > out.min_iterations)
        warning('Power flows not converging. Change on last iteration was eps_qp=%g, eps_phonon=%g.', ...
            delta_err_eps);
        return
    end
    old_err_eps = err_eps;

    if (it > out.max_iterations)
        warning('More than %d iterations, stopping', out.max_iterations);
        return
    end

    it = it+1

    if (nargin>=2 && isa(callback, 'function_handle'))
        if (nargin(func2str(callback)) == 2)
            callback(out, it);
        else
            callback(out);
        end
    end
end

end
