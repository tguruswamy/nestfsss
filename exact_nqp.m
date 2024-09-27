function out = exact_nqp( sc, T )
%EXACT_NQP Exact number of quasiparticles at temperature T
%

c = Constants;
K_B = c.K_B;
Delta = sc.Delta;

func = @(x) fermi_(x, T) .* rho_(x, Delta);

out = 4 * sc.N0 * quadgk(func, Delta, inf);

    function out = fermi_(En, T)
        out = 1./(1 + exp(En./(K_B*T)));
    end

    function out = rho_(En, Delta)
        out = En ./ sqrt(En.^2 - Delta^2);
    end
end