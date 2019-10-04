% Predicado que relaciona una lista L1 con otra lista L2, con los
% mismos elementos que L1, pero rotados N lugares a la izquierda.

rotar(L1, N, L2) :-
    length(Li, N),          % Armo una lista nueva de N elementos.
    append(Li, Ld, L1),     % Li son los primeros N elementos de L1, Ld el resto.
    append(Ld, Li, L2).     % Hacer el append rotando Ld y Li, crea la lista requerida.
