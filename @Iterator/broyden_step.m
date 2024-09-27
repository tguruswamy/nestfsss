function [ x0, fx0, jac0, obj, failure ] = broyden_step( x0, fx0, jac0, obj )
%BROYDEN_ITERATION Summary of this function goes here
%   Detailed explanation goes here

c1 = 1E-4;
ratio = 0.5;

alpha = 1;
xstep = -jac0\fx0;

x1 = x0 + alpha*xstep;
obj = update_object(obj, x1);
x1 = state_vector(obj);
failure = 0;
for i=1:16
    fx1 = error_vector(obj);
    expected_fnew = norm(fx0-c1*alpha*fx0);
    if ( norm(fx1) <= expected_fnew )
        break
    end
    if (i == 16)
        warning('Line search unable to satisfy Armijo condition.');
%         failure = 1;
        break;
    end
    alpha = ratio*alpha;
%     if (all(abs(alpha*xstep) < eps(x0)))
%         warning('Step size approaching epsilon');
%     end
    x1 = x0 + alpha*xstep;
    obj = update_object(obj, x1);
    x1 = state_vector(obj);
end

if failure
    obj = update_object(obj, x0);
    x0 = state_vector(obj);
    jac0 = Jacobian(obj);
else
%    y = fx1 - fx0;
    s = alpha*xstep;
    jac0 = jac0 + (fx1*s')/(s'*s);
    
    x0 = x1;
    fx0 = fx1;
end

end

