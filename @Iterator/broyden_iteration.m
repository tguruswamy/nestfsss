function [ out ] = broyden_iteration( obj, callback )
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

x0 = state_vector(out);
fx0 = error_vector(out);
jac0 = Jacobian(out);
%jac0 = eye(N+2);

%evals = eig(jac0);
%error('Done');

%%
it=0;
while (it < out.min_iterations || norm(err_eps) > out.convergence_eps || ...
        norm(deltaB) > out.convergence_deltaB)
    [x0, fx0, jac0, out, failure] = broyden_step(x0, fx0, jac0, out);
    if failure
        [x0, fx0, jac0, out, failure] = broyden_step(x0, fx0, jac0, out);
    end
    if failure
        warning('Broyden step failed even with exact Jacobian');
    end

    B_p = out.tf.B_probe;
    B_s = out.tf.B_signal;
    err_eps = [eps_qp(out.tf), eps_phonon(out.tf)];

    if ((out.tf.Pabs_p + out.tf.Pabs_s) == 0) %no absorbed power
        %use temperature as convergence criteria instead
        err_eps = abs(T_N(out.tf.sc) - out.tf.sc.T_B) .* 1E3;
    end
    deltaB = [(B_p - oldB_p)/B_p, (B_s - oldB_s)/B_s];
    deltaB(isnan(deltaB)) = 0;
    oldB_p = B_p;
    oldB_s = B_s;

    err_eps
    deltaB

    delta_err_eps = abs(err_eps - old_err_eps);
    %if power flow discrepancy isn't changing, bail out, solution is not
    %converging
    if (any(delta_err_eps < out.not_converging_delta) && it > out.min_iterations)
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

    if (nargin==2 && isa(callback, 'function_handle'))
        if (nargin(func2str(callback)) == 2)
            callback(out, it);
        else
            callback(out);
        end
    end
end

end