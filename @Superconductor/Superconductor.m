classdef Superconductor
    %SUPERCONDUCTOR Superconductor out of thermal equilibrium, with quasiparticle distribution f and
    %phonon distribution n (but energy gap D from temperature T_b)
    %

    properties (Constant)
        %Useful constants
        K_B = Constants.K_B;
    end

    properties (Abstract, Constant)
        %Material parameters
        N0 % in ueV^-1 nm^-3
        Nion % in nm^-3

        %Number of phonon branches
        nphonon;

        %Debye temperature
        theta_D % in ns

        %Quasiparticle characteristic lifetime
        tau_0 % in ns

        %Zero-Temperature energy gap
        Delta_0 % in ns

        %Fermi energy
        EFermi % in ueV

        %Material name
        material % string
    end

    properties
        %Phonon escape time
        tau_l % in ns
    end

    properties
        %Debye energy
        Omega_Debye

        %Delta(T) should be calculated based on T_B
        Delta

        %BCS Parameter
        N0V

        %Superconductor critical temperature
        T_C

        %Starting quasiparticle temperature
        T_start

        %Bath temperature
        T_B

        %Energy bin width
        bin_width = 1 * Constants.micro * Constants.eV;

        %Number of energy bins
        N = int32(1000);

        %Discrete quasiparticle energy
        En

        %Quasiparticle distribution
        f

        %Discrete phonon energy
        Omega

        %Phonon distribution
        n

        %Quasiparticle density of states broadening
        gamma

        %Phonon characteristic lifetime
        tau_0_phonon % in ns

        %Quasiparticle density of states
        rho

        %Energies should go up to at least this multiple of K_B T
        minE_KBT = 12;

        %Energies should go up to at least this multiple of Delta
        minE_Delta = 10;

        %Maximum number of bins
        maxN = 2500;
        
        %Bins per Delta
        bins_per_delta = 100;
        
        %Sigma from material constants rather than fit
        sigma_n_theory;
        sigma_s_theory;
    end
    
    properties
        gap_temps
        
        gap_array
        
        temp_gaps
        
        temp_array
    end

    methods
        function obj = Superconductor()
            %SUPERCONDUCTOR Superconductor Class Constructor
            %

            %Debye energy
            obj.Omega_Debye = obj.theta_D * obj.K_B; % in ueV

            %BCS Parameter
            obj.N0V = 1/asinh(obj.Omega_Debye/obj.Delta_0);

            %Calculate gap energy at T=0K using exact solution
            %Delta_0 = Omega_Debye / sinh(1 / N0V);

            %Superconductor critical temperature
            %T_C = 1.169; % 1.169... K, adjusted later
            %Eq 3.29 of BCS Paper (?)
            %obj.T_C = 1.134 * obj.theta_D * exp(-1 / obj.N0V);
            obj.T_C = obj.Delta_0 / 1.764 / obj.K_B;
            %obj.T_C = update_constants(obj);

            %Delta(T) could be calculated based on T_B
            %obj.Delta = obj.Delta_0 * sqrt(1-obj.T_B/obj.T_C);
            obj.Delta = obj.Delta_0;

            %Phonon characteristic lifetime
            obj.tau_0_phonon = update_constants(obj);

            %Phonon pair breaking time
            %obj.tau_pb = obj.tau_0_phonon;
            
            %obj = init_arrays(obj);
            
            obj.sigma_n_theory = 48*obj.N0*1.0369*Constants.K_B^5/(obj.tau_0*(Constants.K_B*obj.T_C)^3);
            obj.sigma_s_theory = 16*pi*obj.N0*obj.Delta_0^4*Constants.K_B/(obj.tau_0*(Constants.K_B*obj.T_C)^3);
        end
        
        function obj = init_arrays(obj)
            obj.gap_temps = linspace(0*obj.T_C, 1.0*obj.T_C, 1000);
            obj.gap_array = zeros(1, 1000);
            for i=1:length(obj.gap_temps)
                obj.gap_array(i) = obj.delta_from_temperature(obj.gap_temps(i));
            end
            
            obj.temp_gaps = linspace(0*obj.Delta_0, 1.0*obj.Delta_0, 1000);
            obj.temp_array = zeros(1, 1000);
            for i=1:length(obj.temp_gaps)
                obj.temp_array(i) = obj.temperature_from_delta(obj.temp_gaps(i));
            end
        end
        
        function out = delta_interp(obj, T)
            out = zeros(size(T));
            if isempty(obj.gap_temps)
                for i=1:length(T)
                    out(i) = obj.delta_from_temperature(T(i));
                end
            else
                warning('Interpolating data for T=%g.', T);
                out = interp1(obj.gap_temps, obj.gap_array, T, 'linear', 0);
            end
        end
        
        function out = temp_interp(obj, D)
            if isempty(obj.temp_gaps)
                for i=1:length(D)
                    out(i) = obj.temperature_from_delta(D(i));
                end
            else
                out = interp1(obj.temp_gaps, obj.temp_array, D, 'linear', 0);
            end
        end
        
        function out = ddelta_dT(obj, T)
            out = (delta_interp(obj, T+0.5*sqrt(eps)) - delta_interp(obj, T-0.5*sqrt(eps)))/sqrt(eps);
        end

        function obj = set.Delta(obj, val)
            obj.Delta = val;

            if (~(isempty(obj.T_C) || isempty(obj.Delta_0) || ...
                    isempty(obj.Omega_Debye) ))
                %Bath temperature
                %T_B = 120E-3; % 120 mK
                %obj.T_B = 0.1 * obj.T_C;

                if (val == obj.Delta_0)
                    obj.T_B = 0.1 * obj.T_C;
                else
                    obj.T_B = temperature_from_delta(obj, val);
                end

                %Starting quasiparticle temperature
                %obj.T_start = 0.1 * obj.T_C;
                obj.T_start = (1+0.5*exp(-obj.T_B/(0.5*Constants.Kelvin)))*obj.T_B;

                obj = change_discretisation(obj, 0);
            end
        end

        function obj = change_discretisation(obj, minE)
            %Don't want more than maxN bins for speed
            max_energy = max([obj.minE_Delta * obj.Delta, obj.minE_KBT * Constants.K_B * obj.T_B, minE]);
            bw_min = max_energy / obj.maxN;

            %bin_width should divide Delta into at least bins_per_delta bins
            bw_suggested = obj.Delta/obj.bins_per_delta;
            if (bw_suggested < bw_min)
                bw_suggested = obj.Delta/floor(obj.Delta/bw_min);
            end
            obj.bin_width = bw_suggested;

            obj.N = int32(ceil(max_energy/obj.bin_width));

            obj = reinit_distributions(obj);
        end

        function obj = reinit_distributions(obj)
            %Discrete quasiparticle energy
            maxqpenergy = (double(obj.N)*obj.bin_width + obj.Delta) + obj.N*obj.bin_width;
            obj.En = (0:2*double(obj.N)) * obj.bin_width + obj.Delta;

            %Quasiparticle distribution
            obj.f = thermalfermidist(obj.En, obj.T_start);

            %Discrete phonon energy
            maxphononenergy = 2*double(obj.N)*obj.bin_width + 2*obj.Delta;
            obj.Omega = (1:maxphononenergy/obj.bin_width) * obj.bin_width;

            %Phonon distribution
            obj.n = thermalbosedist(obj.Omega, obj.T_B);

            %Quasiparticle density of states broadening
            %gamma = 0.12; %Based on physical measurements according to David
            obj.gamma = optimise_gamma(obj);

            %Quasiparticle density of states
            obj.rho(1:length(obj.En)) = rho_f(obj, obj.En);
        end
    end

end

