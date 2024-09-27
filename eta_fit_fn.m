function [ eta2D ] = eta_fit_fn( P, P0, eta0, eta1 )
%ETA_FIT_FN Log-linear function for power dependence of eta

%eta2D = eta0.*(P<=P0) + (eta1*log(P) + eta2).*(P>P0);
eta2D = eta0.*(P<=P0) + (eta1*log(P/P0) + eta0).*(P>P0);

end

