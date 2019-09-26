% Predicado que relaciona una lista con su cantidad de elementos.

longitud([], 0).

longitud([_|T], L) :-
    longitud(T, L1),
    L is L1 + 1.