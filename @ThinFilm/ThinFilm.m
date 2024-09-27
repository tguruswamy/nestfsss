classdef ThinFilm
    %THINFILM
    %

    properties (Constant)
        %Useful constants
        K_B = Constants.K_B;
    end

    properties
        %Absorbed probe power
        Pabs_p_spec % in aW/um^3

        %Absorbed probe power frequency
        hnu_p % ueV

        %Absorbed signal power
        Pabs_s_spec % in aW/um^3

        %Absorbed signal power frequency
        hnu_s % ueV

        %Absorbed phonon power
        Pabs_phonon_spec

        %Absorbed phonon power frequency
        hnu_phonon

        %Superconductor object for material parameters
        sc

        %Enable probe power
        enable_probe % 0 or 1

        %Enable signal power
        enable_signal % 0 or 1

        %Enable phonon power
        enable_phonon %0 or 1

        %Probe power normalization
        B_probe = 0;

        %Signal power normalization
        B_signal = 0;
    end

    properties (Dependent = true)
        %Absorbed probe power
        Pabs_p

        %Absorbed signal power
        Pabs_s

        %Absorbed phonon power
        Pabs_phonon
    end

    methods
        function obj = ThinFilm(sup)
            %THINFILM ThinFilm class constructor
            if (nargin == 1 && isa(sup, 'Superconductor'))
                obj.sc = sup;
            end

            %Enable probe power
            obj.enable_probe = 0;

            %Enable signal power
            obj.enable_signal = 0;

            %Enable phonon power
            obj.enable_phonon = 0;

            %Absorbed probe power frequency
            obj.hnu_p = 16 * Constants.micro * Constants.eV; % ueV

            %Absorbed signal power frequency
            obj.hnu_s = 370 * Constants.micro * Constants.eV; % ueV

            %Absorbed phonon frequency
            obj.hnu_phonon = 370 * Constants.micro * Constants.eV; % ueV

            obj.Pabs_p_spec = 2000; %20 aW / um^3 == 20 W/m^3
            obj.Pabs_s_spec = 0.2; %0.2 aW / um^3 == 0.2 W/m^3
            obj.Pabs_phonon_spec = 0.2; %0.2 aW / um^3 == 0.2 W/m^3
        end

        function out = get.Pabs_p(obj)
            %Absorbed probe power
            out = obj.Pabs_p_spec * Constants.Watts / Constants.Meters^3 * obj.enable_probe;
        end

        function out = get.Pabs_s(obj)
            %Absorbed signal power
            out = obj.Pabs_s_spec * Constants.Watts / Constants.Meters^3 * obj.enable_signal;
        end

        function out = get.Pabs_phonon(obj)
            %Absorbed phonon power
            out = obj.Pabs_phonon_spec * Constants.Watts / Constants.Meters^3 * obj.enable_phonon;
        end

        function obj = check_bin_width_and_N(obj)
            if (not(isempty(obj.sc)))
                if (abs(obj.sc.T_N - obj.sc.T_start) < sqrt(eps))
                    total_power = obj.Pabs_p_spec*obj.enable_probe + obj.Pabs_s_spec*obj.enable_signal;
                    obj.sc.T_start = T_N_from_P(obj.sc, obj.sc.tau_0_phonon, 1.0, total_power);
                    obj.sc = obj.sc.reinit_distributions();
                end

                val = obj.hnu_s;
                obj.hnu_s = round(val/obj.sc.bin_width)*obj.sc.bin_width;
                if (obj.hnu_s ~= val)
                    warning('Changing signal frequency to %g ueV, to be multiple of bin width %g ueV', obj.hnu_s, obj.sc.bin_width);
                end
                if (obj.hnu_s <= 2*obj.sc.Delta)
                    warning('Signal frequency %g ueV is not greater than 2*Delta = %g ueV', obj.hnu_s, 2*obj.sc.Delta);
                end
                if (obj.sc.En(obj.sc.N) < (3*obj.sc.Delta + max(obj.hnu_s, obj.hnu_phonon)))
                    minE = 2*obj.sc.Delta + max(obj.hnu_s, obj.hnu_phonon);
                    obj.sc = change_discretisation(obj.sc, minE);
                end

                val = obj.hnu_p;
                obj.hnu_p = round(val/obj.sc.bin_width)*obj.sc.bin_width;
                if (obj.hnu_p ~= val)
                    warning('Changing probe frequency to %g ueV, to be multiple of bin width %g ueV', obj.hnu_p, obj.sc.bin_width);
                end
                val = obj.hnu_s;
                obj.hnu_s = round(val/obj.sc.bin_width)*obj.sc.bin_width;
                if (obj.hnu_s ~= val)
                    warning('Changing signal frequency to %g ueV, to be multiple of bin width %g ueV', obj.hnu_s, obj.sc.bin_width);
                end
                if (obj.hnu_s <= 2*obj.sc.Delta)
                    warning('Signal frequency %g ueV is not greater than 2*Delta = %g ueV', obj.hnu_s, 2*obj.sc.Delta);
                end

                val = obj.hnu_phonon;
                obj.hnu_phonon = round(val/obj.sc.bin_width)*obj.sc.bin_width;
                if (obj.hnu_phonon ~= val)
                    warning('Changing phonon frequency to %g ueV, to be multiple of bin width %g ueV', obj.hnu_phonon, obj.sc.bin_width);
                end
            end
        end
    end

end

