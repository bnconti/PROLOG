% Predicado que relaciona una lista L1 con otra lista L2, con los
% mismos elementos que L1, pero rotados 1 lugar a la izquierda.

rotar([E1, E2], [E2, E1]) :- !.

rotar([E1, E2 | T], [E2 | LF]) :-
    rotar([E1 | T], LF).
