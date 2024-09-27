classdef Sc_Molybdenum < Superconductor
    %Sc_Molybdenum
    %

    properties (Constant)
        %Mo resonator parameters
        N0 = 2.90E22 / Constants.eV / (Constants.centi * Constants.Meters)^3;

        Nion = 0.107 * Constants.AVOGADRO / (Constants.centi * Constants.Meters)^3;

        %Number of phonon branches
        nphonon = 3;

        %Debye temperature
        theta_D = 459 * Constants.Kelvin;
        % from Parks Vol 2 Ch 13 Table VI

        %Zero-Temperature energy gap
        Delta_0 = 140 * Constants.micro * Constants.eV;
        %from Parks T_C = 0.92 K, rounded up

        %Electron-phonon interaction Eliashberg spectral function alpha^2 F
        %Mass enhancement parameter
        %Inverse moment of alpha^2 F(Omega)
        lambda = 0.416;
        %from Caro et al. (1981)

        %approximate alpha^2 F(Omega) == b Omega^2
        %so b = lambda/Omega_Debye^2
        b = 2.275E-4 / (Constants.milli*Constants.eV)^2;
        %from Caro et al. (1981)

        %avg(alpha^2) = lambda/9*Omega_Debye
        alphasq_avg = 1.6191 * (Constants.milli*Constants.eV);
        %from Caro et al. (1981)

        %Quasiparticle characteristic lifetime
        tau_0 = (1+Sc_Molybdenum.lambda) * Constants.HBAR / (2*pi*Sc_Molybdenum.b*(Constants.K_B*0.92*Constants.Kelvin)^3);
        % == Z1(0) * hbar / (2*pi*b*(kT_C)^3) )

        %Phonon characteristic lifetime
        %tau_0_phonon

        %Fermi energy
        EFermi = 9.32 * Constants.eV;
        %from Kozorezov 2000

        %Material name
        material = 'Mo';

        %Sigma
        sigma = 1.42E10; %W m^-3 K^-1
    end

    properties
        %Phonon characteristic lifetime
        tau_0_phonon_exact = Constants.HBAR * Sc_Molybdenum.Nion / ...
            (4 * pi^2 * Sc_Molybdenum.N0/(1+Sc_Molybdenum.lambda) * Sc_Molybdenum.alphasq_avg * Sc_Molybdenum.Delta_0);
        %tau_0_phonon == hbar * Nion / (4*pi^2 * N(0) * <alpha^2> * Delta_0)
    end
end

