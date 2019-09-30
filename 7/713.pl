% Predicado que relaciona una lista L1 con otra lista L2, con los 
% mismos elementos que L1, pero rotados un lugar a la izquierda.

rotar(L1, N, L2) :-
    append(Lx, Ly, L1),     % L1 es Lx + Ly.
    append(Ly, Lx, L2),     % L2 es Ly + Lx.
    length(Lx, N).