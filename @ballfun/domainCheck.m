function out = domainCheck(f, g)
%DOMAINCHECK   True if the domains of two ballfun objects are the same.
%   DOMAINCHECK(F, G) returns TRUE if the domains of the two ballfun 
%   objects F and G coincide up to a tolerance depending on their 
%   horizontal scales or if both F and G are empty CHEBFUN objects.
%
% See also CHEBFUN/DOMAINCHECK and CHEBFUN2/DOMAINCHECK.

% Copyright 2016 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The ballfun class uses this function internally to compare the domains of
% ballfun objects before attempting to perform operations on multiple
% ballfun objects that require the ballfun objects to reside on the same domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Empty check: 
if ( isempty(f) && isempty(g) )
    out = true;
    return
elseif ( xor(isempty(f), isempty(g) ) )
    out = false;
    return
end

% Extract columns, rows and tubes: 
[ignore, fCols, fRows, fTubes] = tucker(f);
[ignore, gCols, gRows, gTubes] = tucker(g);

% Call 1D domain check: 
out = domainCheck(fCols, gCols) & domainCheck(fRows, gRows) & ...
    domainCheck(fTubes, gTubes);

end