function [ tf ] = update_dists(tf, f)
%UPDATE_DISTS Summary of this function goes here
%   Detailed explanation goes here

sc = tf.sc;
N = sc.N;
sc.f(1:N) = f;
sc.f(N+1:end) = extrapolate_f(sc.En, sc.f, N);

sc.n(1:N) = update_phonon_distribution(tf);
sc.n(N+1:end) = extrapolate_n(sc.Omega, sc.n, N);
%sc.dndf = dn_df(sc);

tf.sc = sc;

end

