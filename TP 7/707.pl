% Predicado que vincula una lista numérica, con la suma de sus elementos.

suma([], 0).

suma([H|T], S) :-
    suma(T, SS),
    S is H + SS.
