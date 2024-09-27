function out = tau_ee( sup, En )
%TAU_EE Electron-electron scattering rate tau_ee^(-1)
%   Assumes r_s = 1

out = En.^2 ./ Constants.HBAR ./ sup.EFermi .* (1/7.96);

end

