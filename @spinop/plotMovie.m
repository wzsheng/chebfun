function plotOption = plotMovie(S, dt, p, plotOption, t, v, gridPoints)
%PLOTMOVIE   Plot a movie when solving a PDE specified by a SPINOP.
%   PLOTMOVIE

% Copyright 2016 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Set-up:
dom = S.domain;
xx = gridPoints;
N = size(xx, 1);
nVars = S.numVars;
Ylim = plotOption;

% Plot:
xxplot = [xx; 2*xx(end) - xx(end-1)];
for k = 1:nVars
    idx = (k-1)*N + 1;
    vplot = real(v(idx:idx+N-1));
    vplot = [vplot; vplot(1)]; %#ok<*AGROW>
    
    % Change axes if necessary:
    if ( nargout == 1 )
        minvnew = min(real(vplot));
        maxvnew = max(real(vplot));
        if ( maxvnew > Ylim(2*(k-1) + 2) )
            vscalenew = max(abs(minvnew), maxvnew);
            Ylim(2*(k-1) + 2) = maxvnew + .1*vscalenew;
        end
        if ( minvnew < Ylim(2*(k-1) + 1) )
            vscalenew = max(abs(minvnew), maxvnew);
            Ylim(2*(k-1) + 1) = minvnew - .1*vscalenew;
        end
    end
    
    % Update data:
    set(p{k}, 'xdata', xxplot), set(p{k}, 'ydata', vplot)
    set(p{k}.Parent, 'xlim', [dom(1), dom(2)])
    set(p{k}.Parent, 'ylim', [Ylim(2*(k-1) + 1), Ylim(2*(k-1) + 2)])
    
    % Update title:
    if ( k == 1 )
        title(p{k}.Parent, ...
            sprintf('N = %i, dt = %1.1e, t = %.4f', N, dt, t))
    end
    drawnow
    
end
plotOption = Ylim;

end