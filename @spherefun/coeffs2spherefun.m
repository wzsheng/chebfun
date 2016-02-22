function F = coeffs2spherefun( X ) 
% COEFFS2SPHEREFUN      Make a SPHEREFUN object from a matrix of Fourier
% coefficients. 
%
%  F = coeffs2spherefun( X ) returns a spherefun object F that has a
%  Fourier--Fourier matrix of coefficients X.  This is useful for
%  computing quantities on the sphere with the function F.  Spherefun is
%  available as part of Chebfun. 

% Get size: 
[m, n] = size( X ); 

% If n is odd, then make it even. 
if ( mod(n,2) == 1 ) 
    X = [zeros(m,1) X ]; 
end

if ( mod(m, 2) == 1 ) 
    X = [ zeros(1,n+1) ; X  ];
    m = m + 1; 
end

% Convert to values on the grid: 
VALS = trigtech.coeffs2vals( trigtech.coeffs2vals( X ).' ).'; 

% Restrict to the region of interest: 
VALS = VALS([floor(m/2)+1:m 1], :);

if ( norm( imag( VALS ) )/max(abs(VALS(:))) ) < sqrt(eps)  
    VALS = real( VALS ); 
end

% Finally, make a spherefun object out of the values: 
F = spherefun( VALS ); 

end