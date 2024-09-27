classdef Constants
    %CONSTANTS Useful constants and units
    %

    properties (Constant)
        tera = 1E12;

        giga = 1E9;

        mega = 1E6;

        kilo = 1E3;

        centi = 1E-2;

        milli = 1E-3;

        micro = 1E-6;

        nano = 1E-9;

        pico = 1E-12;

        femto = 1E-15;

        atto = 1E-18;
    end

    properties (Constant)
        %Base units of the program = 1
        %Other units = factor to convert to base units
        %"A*Constants.Watts" _converts_ A watts into the program's base units
        %"A/Constants.Watts" _converts_ A from base units into Watts

        Seconds = 1/Constants.nano; %ns

        Kelvin = 1;

        eV = 1/Constants.micro; %micro eV

        Meters = 1/Constants.nano; %nm

        Coulombs = 1;

        Mol = 1;

        Joules = Constants.eV / Constants.Q_E;

        Watts = Constants.Joules / Constants.Seconds;

        Hertz = 1/Constants.Seconds;

        Ohm = Constants.Joules * Constants.Seconds / Constants.Coulombs^2;

        Rydberg = 13.605692 * Constants.eV;
    end

    properties (Constant)
        %Boltzmann constant
        K_B = 8.6173324E-5 * Constants.eV / Constants.Kelvin; % 8.6173324(78)*10^-5 eV/K

        %Charge on the electron
        Q_E = 1.602176565E-19 * Constants.Coulombs; % 1.602176565(35)*10^-19 C

        %Avogadro's Number
        AVOGADRO = 6.0221413E23 / Constants.Mol; % 6.02214129(27)*10^23 atoms/mol

        %Planck's Constant
        PLANCK = 4.135667516E-15 * Constants.eV * Constants.Seconds;

        %Reduced Planck's Constant
        HBAR = Constants.PLANCK/(2*pi);
    end

end

