classdef Iterator
    %ITERATOR
    %

    properties
        %Newton-Raphson convergence parameter
        chi = 0.95;

        %Convergence requirements on deltaB
        convergence_deltaB = 1E-3;

        %Convergence requirements on eps_qp and eps_phonon
        convergence_eps = 1E-3;

        %Maximum number of iterations
        max_iterations = 100;

        %Minimum number of iterations
        min_iterations = 3;

        %Thin film resonator object
        tf;
    end

    properties (Dependent = true)
        %If err_eps is changing less than this, solution is not going to
        %converge
        not_converging_delta
    end

    methods
        function obj = Iterator(tf)
            %ITERATOR Iterator class constructor
            %

            %Thin film resonator object
            if (nargin == 1 && isa(tf,'ThinFilm'))
                obj.tf = tf;
            end
        end

        function out = get.not_converging_delta(obj)
            out = obj.convergence_eps * 1E-3;
        end

        function out = eq(obj1, obj2)
            if isscalar(obj1)
                %obj1 = obj1(ones(size(obj2)));
                out = arrayfun(@(x) isequal(x, obj1), obj2);
            else
                out = arrayfun(@(x) x == obj2, obj1);
            end
            %out = arrayfun(@isequal, obj1, obj2);
        end

        function out = ne(obj1, obj2)
            out = not(obj1 == obj2);
        end
    end

end

