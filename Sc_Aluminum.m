classdef Sc_Aluminum < Superconductor
    %Sc_Aluminum
    %

    properties (Constant)
        %Al resonator parameters
        N0 = 1.74E28 / Constants.eV / Constants.Meters^3;
        % 1.74E28 states eV^-1 m^-3, from David
        Nion = 6.022E28 / Constants.Meters^3;
        % 6.022E28 atoms m^-3, from David

        %Number of phonon branches
        nphonon = 3;

        %Debye temperature
        theta_D = 420 * Constants.Kelvin; % 420 K

        %Quasiparticle characteristic lifetime
        tau_0 = 438 * Constants.nano * Constants.Seconds; % 438 ns

        %Phonon characteristic lifetime
        %tau_0_phonon = 260E-3; % 260 ps

        %Zero-Temperature energy gap
        Delta_0 = 180 * Constants.micro * Constants.eV; % 180 ueV

        %Fermi energy
        EFermi = 11.63 * Constants.eV;
        %from Kozorezov 2000

        lambda = 0.43;
        b = 0.317E-3 / (Constants.milli*Constants.eV)^2;
        alphasq_avg = 1.93 * (Constants.milli*Constants.eV);

        %Material name
        material = 'Al';

        %Sigma
        sigma = 3.23E10; %W m^-3 K^-1
    end

    properties
        %Phonon characteristic lifetime from Kaplan
        tau_0_phonon_exact = 260 * Constants.pico * Constants.Seconds;
    end
end

