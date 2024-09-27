function [eta1, eta2] = eta_photon_rate( it_probe, it_signal )
%ETA_COMPLETE Signal quasiparticle creation efficiency with probe and
%signal, compares increase in quasiparticle generation rate to expected rate if each photon produces one qp
%% Is this useful?

N_qp_r = @(x) 4*x.N0*x.bin_width*sum(-recombination_power(x).*x.rho(1:x.N));

B = it_probe.tf.sc.RT_B;
N2D = N_2Delta_thermal(it_probe.tf.sc, it_probe.tf.sc.T_B);
taul = it_probe.tf.sc.tau_l;

Pabs = it_probe.tf.Pabs_p;
Nnet = (N_qp_r(it_probe.tf.sc) - 2*B*N2D) / (1 + B*taul);
hnu = it_probe.tf.hnu_p;

if Pabs > 0
    if Nnet < 0
        warning('Negative probe eta!');
        eta1 = NaN;
    else
        eta1 = Nnet*hnu/Pabs;
    end
else
    eta1 = NaN;
end

if nargin > 1
    
if it_signal.tf.enable_signal && (~isempty(it_signal.tf.enable_phonon) && it_signal.tf.enable_phonon)
    error('Cant calculate eta when both signal and phonon are on');
end

B = it_signal.tf.sc.RT_B;
N2D = N_2Delta_thermal(it_signal.tf.sc, it_signal.tf.sc.T_B);
taul = it_signal.tf.sc.tau_l;

if it_signal.tf.enable_signal && (isempty(it_signal.tf.enable_phonon) || ~it_signal.tf.enable_phonon)
Pabs = it_signal.tf.Pabs_s;
hnu = it_signal.tf.hnu_s;
elseif ~it_signal.tf.enable_signal && (~isempty(it_signal.tf.enable_phonon) && it_signal.tf.enable_phonon)
Pabs = it_signal.tf.Pabs_phonon;
hnu = it_signal.tf.hnu_phonon;
else
Pabs = 0;
hnu = 0;
end

Nnet2 = (N_qp_r(it_signal.tf.sc) - 2*B*N2D) / (1 + B*taul) - Nnet;

if Pabs > 0
    if Nnet2 < 0
        warning('Negative eta!');
        %eta2 = eta_signal_power(it_signal, it_probe);
        eta2 = NaN;
    else
        eta2 = Nnet2*hnu/Pabs;
    end
else
    eta2 = NaN;
end

end
end
