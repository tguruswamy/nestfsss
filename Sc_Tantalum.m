classdef Sc_Tantalum < Superconductor
    %Sc_Tantalum
    %

    properties (Constant)
        %Ta resonator parameters
        N0 = 1.69*4.08E22 / Constants.eV / (Constants.centi * Constants.Meters)^3;
        % 1.69 * 40.8E21 states eV^-1 cm^-3, from Kaplan
        % Kaplan N0 must be multiplied by Z_1(0)
        Nion = 5.52E28 / Constants.Meters^3;
        % 5.52E28 atoms m^-3, from Parks Vol 2 Ch 13 Table VI
        % Typo in Kaplan

        %Number of phonon branches
        nphonon = 3;

        %Debye temperature
        theta_D = 240 * Constants.Kelvin; % 240 K, Kaplan

        %Quasiparticle characteristic lifetime
        tau_0 = 1.78 * Constants.nano * Constants.Seconds; % 1.78 ns, from Kaplan

        %Phonon characteristic lifetime
        %tau_0_phonon = 22.7E-3; % 22.7 ps, from Kaplan

        %Zero-Temperature energy gap
        Delta_0 = 700 * Constants.micro * Constants.eV; % 700 ueV, from Zehnder

        %Fermi energy
        EFermi = 9.5 * Constants.eV;
        %from Kozorezov 2000

        lambda = 0.69;
        b = 1.73E-3 / (Constants.milli*Constants.eV)^2;
        alphasq_avg = 1.38 * (Constants.milli*Constants.eV);

        %Material name
        material = 'Ta';

        %Sigma
        sigma = 1.17E14; %W m^-3 K^-1
    end

    properties
        %Phonon characteristic lifetime from Kaplan
        tau_0_phonon_exact = 22.7 * Constants.pico * Constants.Seconds;
    end
end

