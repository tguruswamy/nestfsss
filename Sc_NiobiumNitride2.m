classdef Sc_NiobiumNitride2 < Superconductor
    %Sc_NiobiumNitride
    %

    properties (Constant)
        %NbN resonator parameters
        Nion = 8.470/106.91 * Constants.AVOGADRO / (Constants.centi * Constants.Meters)^3;
        % from Wikipedia / David

        N0 = 2.56E22 / Constants.eV / (Constants.centi * Constants.Meters)^3;
        % from Semenov

        %Number of phonon branches
        nphonon = 6;

        %Debye temperature
        %theta_D = 330 * Constants.Kelvin;
        %from Toth
        theta_D = 246 * Constants.Kelvin;
        %from b and <alpha^2>

        %Zero-Temperature energy gap
        Delta_0 = 2.56 * Constants.milli * Constants.eV;
        %from Kihlstrom (1985)

        %Electron-phonon interaction Eliashberg spectral function alpha^2 F
        %Mass enhancement parameter
        %Inverse moment of alpha^2 F(Omega)
        lambda = 1.4589;
        %from Kihlstrom (1985)

        %approximate alpha^2 F(Omega) == b Omega^2
        %so b = lambda/Omega_Debye^2
        b = 0.0047 / (Constants.milli*Constants.eV)^2;
        %from Kihlstrom (1985)

        %avg(alpha^2) = lambda/9*Omega_Debye
        alphasq_avg = 2.4941 * (Constants.milli*Constants.eV);
        %from Kihlstrom (1985)

        %Quasiparticle characteristic lifetime
        tau_0 = (1+Sc_NiobiumNitride.lambda) * Constants.HBAR / (2*pi*Sc_NiobiumNitride.b*(Constants.K_B*15.8*Constants.Kelvin)^3);
        % == Z1(0) * hbar / (2*pi*b*(kT_C)^3) )

        %Phonon characteristic lifetime
        %tau_0_phonon

        %Fermi energy
        EFermi = 1.15 * Constants.Rydberg;
        %from Schwarz, J Phys C: Solid State Phys, 1975

        %Material name
        material = 'NbN';

        %Sigma
        sigma = 1.29E16; %W m^-3 K^-1
    end

    properties
        %Phonon characteristic lifetime
        tau_0_phonon_exact = Constants.HBAR * Sc_NiobiumNitride.Nion / ...
            (4 * pi^2 * Sc_NiobiumNitride.N0/(1+Sc_NiobiumNitride.lambda) * Sc_NiobiumNitride.alphasq_avg * Sc_NiobiumNitride.Delta_0);
        %tau_0_phonon == hbar * Nion / (4*pi^2 * N(0) * <alpha^2> * Delta_0)
    end
end