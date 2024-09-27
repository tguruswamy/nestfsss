function [ out ] = converged( obj )
%CONVERGED
%
if isempty(obj.tf.enable_phonon)
    obj.tf.enable_phonon = 0;
end
if isempty(obj.tf.Pabs_phonon_spec)
    obj.tf.Pabs_phonon_spec = 0;
end

if ((obj.tf.Pabs_p + obj.tf.Pabs_s + obj.tf.Pabs_phonon) == 0) %no absorbed power
    %use temperature as convergence criteria instead
    err_eps = abs(T_N(obj.tf.sc) - obj.tf.sc.T_B) .* 1E3;
else
    err_eps = [eps_qp(obj.tf), eps_phonon(obj.tf)];
end

out = (norm(err_eps) < obj.convergence_eps) & (all(obj.tf.sc.f >= 0)) & (all(obj.tf.sc.n >= 0));

end

