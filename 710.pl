% Predicado cuyos sujetos son dos listas, y que es verdadero
% cuando la primer lista es un subconjunto de la segunda.

subconjunto([], _).

subconjunto([X|L1], L2) :-
    contiene(X, L2),
    subconjunto(L1, L2).

contiene(X, [X|_]) :- !.

contiene(X, [_|T]) :-
    contiene(X, T).