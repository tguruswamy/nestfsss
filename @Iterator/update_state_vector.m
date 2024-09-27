function [ out ] = update_state_vector( it )
%UPDATE_STATE_VECTOR
%%
%

out = state_vector(it) - it.chi * Jacobian(it) \ error_vector(it);

end
