function out = electronic_heat_capacity( sc, T )
%HEAT_CAPACITY BCS electronic heat capacity, by integral (Tinkham)

K_B = sc.K_B;

rho = @(E, D) real((E-1i*sc.gamma)./sqrt((E-1i*sc.gamma).^2 - D^2));
dfermi = @(E, T) -1/K_B/T/4./cosh(E/2/K_B/T).^2;

out = 4*sc.N0/T*quadgk(@(u) -dfermi(u,T).*rho(u,delta_interp(sc, T)).*(u.^2 - delta_interp(sc, T)*ddelta_dT(sc, T)*T), ...
    delta_interp(sc, T), 100*sc.Omega_Debye, 'relTol', 1e-8, 'absTol', 0);

end

