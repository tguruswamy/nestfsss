classdef Sc_Niobium < Superconductor
    %Sc_Niobium
    %

    properties (Constant)
        %Nb resonator parameters
        N0 = 2.84*3.17E22 / Constants.eV / (Constants.centi * Constants.Meters)^3;
        % 2.84 * 31.7E21 states eV^-1 cm^-3, from Kaplan
        % Kaplan N0 must be multiplied by Z_1(0)
        Nion = 5.57E10 / (Constants.micro * Constants.Meters)^3;
        % 5.57E10 atoms um^-3, from Kaplan & Zehnder

        %Number of phonon branches
        nphonon = 3;

        %Debye temperature
        theta_D = 275 * Constants.Kelvin; % 275 K, Kaplan

        %Quasiparticle characteristic lifetime
        tau_0 = 0.149 * Constants.nano * Constants.Seconds; % 0.149 ns, from Kaplan

        %Phonon characteristic lifetime
        %tau_0_phonon = 4.17E-3; % 4.17 ps, from Kaplan

        %Zero-Temperature energy gap
        Delta_0 = 1470 * Constants.micro * Constants.eV; % 1.47 meV, from Zehnder

        %Fermi energy
        EFermi = 6.18 * Constants.eV;
        %from Kozorezov 2000

        lambda = 1.84;
        b = 4.0E-3 / (Constants.milli*Constants.eV)^2;
        alphasq_avg = 4.6 * (Constants.milli*Constants.eV);

        %Material name
        material = 'Nb';

        %Sigma
        sigma = 3.83E15; %W m^-3 K^-1
    end

    properties
        %Phonon characteristic lifetime
        tau_0_phonon_exact = 4.17 * Constants.pico * Constants.Seconds;
    end
end

