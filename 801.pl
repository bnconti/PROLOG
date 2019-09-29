% Predicado que relaciona una lista L1 y un elemento A 
% perteneciente a la misma, con otra lista L2, formada
% con los mismos elementos de L1, menos A.

quitar(_, [], []).

quitar(X, [X|T], LN) :-
    quitar(X, T, LN), !.

quitar(X, [H|T], [H|LN]) :-
    quitar(X, T, LN).
