function r = rank(N)
% RANK  rank of the partial differential operator.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

A = N.coeffs; 
if ( iscell(A) )
   error('The operator has non-scalar variable coefficients. We do not support this.')
else
    r = rank( A );
end
end