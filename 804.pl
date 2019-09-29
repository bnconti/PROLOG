% Predicado que vincula un número natural con 
% la lista formada por sus dígitos.

destripar(N, LI) :-
    armar_lista(N, L),
    invertir(L, LI, []).

armar_lista(N, []) :-
    N < 1, !.

armar_lista(N, [R|T]) :-
    divmod(N, 10, Q, R),
    armar_lista(Q, T).

invertir([], LI, LI) :- !.

invertir([H|T], LI, AC) :- invertir(T, LI, [H|AC]).

