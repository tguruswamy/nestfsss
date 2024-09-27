function out = tau_ep( sup, En )
%TAU_EP Electron-phonon scattering rate tau_ep^(-1)
%

En(En >= sup.Omega_Debye) = sup.Omega_Debye;

out = 1/3 * 1/sup.tau_0 * (En ./ (Constants.K_B * sup.T_C)).^3;

end

