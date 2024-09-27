function [ out ] = N_qp( sc )
%N_QP Total quasiparticle number density
%%
%

E = sc.En;
f = sc.f;
rho = sc.rho;

i=1:sc.N;
%i=1:length(E);
out = 4 * sc.N0 * sc.bin_width * sum(f(i) .* rho(i));

end
