% Predicado que vincula una lista de números enteros
% con la cantidad de números naturales que contiene.

naturales([], 0).

naturales([H|T], L) :-
    H >= 0,
    naturales(T, L1),
    L is L1 + 1, !.

naturales([_|T], L) :-
    naturales(T, L1),
    L is L1, !.