%%
if exist('sc', 'var')
    oldsc = sc;
end

%%
clearvars('-except', 'oldsc');
format long e;

%%
it = Iterator(ThinFilm(Sc_Aluminum())); %create the solution object

it.tf.sc.minE_KBT = 18; %energy of last bin as a multiple of k_B T_B
it.tf.sc.minE_Delta = 10; %energy of last bin as a multiple of Delta
it.max_iterations = 500; %stop if iterations continue too long
it.convergence_eps = 1E-5; %stop when |eps| is below this

it.tf.sc.Delta = 1.0*it.tf.sc.Delta_0; %set Delta(T), which sets T_B

%it.tf.sc.T_B = 0.9 * it.tf.sc.T_C;
%it.tf.sc.T_B = 0.320; %in K
%it.tf.sc.T_start = it.tf.sc.T_B; %starting distributions are thermal
it.tf.sc = it.tf.sc.change_discretisation(0); %update the distributions, calculate the optimum DoS broadening

it.tf.enable_probe = 1; %0 = false, 1 = true
it.tf.hnu_p = 16 * Constants.micro * Constants.eV; %cannot be larger than 2Delta
it.tf.Pabs_p_spec = 2E3; %in W/m^3

it.tf.enable_signal = 1;
%it.tf.hnu_s = 2 * it.tf.sc.Delta + 1*it.tf.sc.bin_width; %in ueV (minimum allowed value)
it.tf.hnu_s = 5 * it.tf.sc.Delta; %in ueV
it.tf.Pabs_s_spec = 2E-3; %in W/m^3

it.tf.enable_phonon = 0;
it.tf.hnu_phonon = 16 * Constants.micro * Constants.eV; %can be pair-breaking or sub-gap energies
%it.tf.hnu_phonon = 2 * it.tf.sc.Delta + 1*it.tf.sc.bin_width; %in ueV
%it.tf.hnu_phonon = 4 * it.tf.sc.Delta; %in ueV
it.tf.Pabs_phonon_spec = 2E9; %in W/m^3

it.tf.sc.tau_l = 5 * it.tf.sc.tau_pb_thermal(it.tf.sc.T_B); %in ns

%%
if 1
tic;
[sol_signal, sol_probe] = it.with_without_signal(); %calculate solutions with and without enable_signal
toc;
sc = sol_signal.tf.sc;
end

%%
%Plot f(E)
if 1
figure(1);
semilogy(sc.En(1:sc.N) / sc.Delta, sol_signal.tf.sc.f(1:sc.N));
hold on;
semilogy(sc.En(1:sc.N) / sc.Delta, sol_probe.tf.sc.f(1:sc.N));
if exist('oldsc', 'var')
    semilogy(oldsc.En(1:oldsc.N) / oldsc.Delta, oldsc.f(1:oldsc.N) ,'-r');
end
hold off;
xlabel('E / \Delta');
ylabel('f(E)');
end
