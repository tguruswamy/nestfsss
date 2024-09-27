function [ sol_signal, sol_probe ] = with_without_signal( it )
%WITH_WITHOUT_SIGNAL Summary of this function goes here
%%

if (~it.tf.enable_signal)
    warning('Calling with_without_signal with no signal power');
end

if (~it.tf.enable_probe)
    warning('Calling with_without_signal with no probe power');
end

if (~it.tf.enable_phonon)
    warning('Calling with_without_signal with no phonon power');
end

if (it.tf.enable_phonon && it.tf.enable_signal)
    error('Calling with_without_signal with phonon power and signal power');
end

obj_signal = it;
sol_signal = main_iteration(obj_signal);
%sol_signal = broyden_iteration(obj_signal);

obj_probe = it;
obj_probe.tf.enable_phonon = 0;
obj_probe.tf.Pabs_phonon_spec = 0;
obj_probe.tf.enable_signal = 0;
obj_probe.tf.Pabs_s_spec = 0;

if (~obj_probe.tf.enable_probe)
    sol_probe = obj_probe;
    sol_probe.tf = check_bin_width_and_N(sol_probe.tf);
    sol_probe.tf.sc.T_start = sol_probe.tf.sc.T_B;
    sol_probe.tf.sc.f = thermalfermidist(sol_probe.tf.sc.En, sol_probe.tf.sc.T_B);
    sol_probe.tf.sc.n = thermalbosedist(sol_probe.tf.sc.Omega, sol_probe.tf.sc.T_B);
    sol_probe.tf.B_signal = 0;
    sol_probe.tf.B_probe = 0;
elseif (~obj_signal.tf.enable_phonon && ~obj_signal.tf.enable_signal)
    sol_probe = sol_signal;
else
    sol_probe = main_iteration(obj_probe);
    %sol_probe = broyden_iteration(obj_probe);
end

end

