% Predicado que relaciona una lista numérica con el menor de sus elementos

menor([Min | T], X) :-
    menor(T, Min, X).

menor([], Min, Min).

menor([C | T], Min, X) :-
    Y is min(C, Min),
    menor(T, Y, X).