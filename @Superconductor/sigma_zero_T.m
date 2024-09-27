function [ sigma_2, sigma_1 ] = sigma_zero_T( sc, w )
%SIGMA_ZERO_T BCS conductivity at zero T, low frequency approximation
%(Tinkham)

Delta = sc.Delta;
hbarw = Constants.HBAR*w;

k = (hbarw - 2*Delta)./(hbarw + 2*Delta);

[K, E] = ellipke(k.^2);

[K2, E2] = ellipke(sqrt(1-k.^2));

if (hbarw > 2*Delta)
    sigma_1 = (1 + 2*Delta/hbarw) * E - (4*Delta/hbarw) * K;
else
    sigma_1 = zeros(size(w));
end
sigma_2 = (Delta/hbarw + 1/2) * E2 + (Delta/hbarw - 1/2) * K2;

end