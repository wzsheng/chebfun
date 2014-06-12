function pass = test_feval(pref)

if ( nargin == 0 )
    pref = chebfunpref();
end

%% Scalar equation:
dom = [0 pi];
x = chebfun(@(x) x, dom, pref);
u = sin(x);
Nu = diff(u, 2) + cos(u);
N = chebop(@(u) diff(u, 2) + cos(u), dom);
err(1) = norm(feval(N, u) - Nu);
err(length(err) + 1) = norm(N(u) - Nu);

N = chebop(@(x, u) diff(u, 2) + cos(u), dom);
err(length(err) + 1) = norm(feval(N, u) - Nu);
err(length(err) + 1) = norm(N(u) - Nu);
err(length(err) + 1) = norm(N*u - Nu);
err(length(err) + 1) = norm(feval(N, x, u) - Nu);
err(length(err) + 1) = norm(N(x, u) - Nu);

%% Scalar equation, chebmatrix input:
N = chebop(@(u) diff(u, 2) + cos(u), dom);
u = chebmatrix({u});

err(length(err) + 1) = norm(feval(N, u) - Nu);
err(length(err) + 1) = norm(N(u) - Nu);

N = chebop(@(x, u) diff(u, 2) + cos(u), dom);
err(length(err) + 1) = norm(feval(N, u) - Nu);
err(length(err) + 1) = norm(N(u) - Nu);
err(length(err) + 1) = norm(N*u - Nu);
err(length(err) + 1) = norm(feval(N, x, u) - Nu);
err(length(err) + 1) = norm(N(x, u) - Nu);
%% System of equations:

N = chebop(@(x, u, v) [diff(u, 2) + cos(v) ; diff(v, 2) - sin(u)], dom);
x = chebfun(@(x) x, dom, pref);
u = sin(x);
v = exp(x);
uv = [u ; v];
Nuv = [diff(u, 2) + cos(v) ; diff(v, 2) - sin(u)];
err(length(err) + 1) = norm(feval(N, u, v) - Nuv);
err(length(err) + 1) = norm(feval(N, x, u, v) - Nuv);
err(length(err) + 1) = norm(feval(N, uv) - Nuv);
err(length(err) + 1) = norm(N(u, v) - Nuv);
err(length(err) + 1) = norm(N(x, u, v) - Nuv);
err(length(err) + 1) = norm(N(uv) - Nuv);
err(length(err) + 1) = norm(N*uv - Nuv);

%% Quasimatrix notation, part I:
N = chebop(@(x, u) [diff(u{1}, 2) + cos(u{2}) ; diff(u{2}, 2) - sin(u{1})]);
x = chebfun(@(x) x, [0 pi], pref);
u = [sin(x) ; exp(x)];
Nu = [diff(u{1}, 2) + cos(u{2}) ; diff(u{2}, 2) - sin(u{1})];
err(length(err) + 1) = norm(feval(N, u) - Nu);
err(length(err) + 1) = norm(feval(N, x, u) - Nu);
err(length(err) + 1) = norm(N(u) - Nu);
err(length(err) + 1) = norm(N(x, u) - Nu);
err(length(err) + 1) = norm(N*u - Nu);

%% Quasimatrix notation, part II:
N = chebop(@(u) [diff(u{1}, 2) + cos(u{2}) ; diff(u{2}, 2) - sin(u{1})]);
x = chebfun(@(x) x, [0 pi], pref);
u = [sin(x) ; exp(x)];
Nu = [diff(u{1}, 2) + cos(u{2}) ; diff(u{2}, 2) - sin(u{1})];
err(length(err) + 1) = norm(feval(N, u) - Nu);
err(length(err) + 1) = norm(N(u) - Nu);
err(length(err) + 1) = norm(N*u - Nu);

%% Feval with numerical input:
% Primitive operator blocks
[Z, I, D, C, M] = linop.primitiveOperators(dom);
N = chebop(@(u) diff(u) + x.*u, dom);
L = linop(D + M(x));
err(length(err) + 1) = norm(N(6) - matrix(L, 6));

N = chebop(@(x, u, v) [diff(u) + v ; diff(v) - sin(x).*u], dom);
L = linop([D, I; -M(sin(x)), D]);
err(length(err) + 1) = norm(N(6) - matrix(L, 6));
%% Happy?

tol = 1e-14;
pass = err < tol;

end