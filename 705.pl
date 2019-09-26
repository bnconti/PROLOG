longitud([], 0).

longitud([_|T], L) :-
    longitud(T, L1),
    L is L1 + 1.