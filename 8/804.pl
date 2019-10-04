% Predicado que vincula un número natural con 
% la lista formada por sus dígitos.

destripar(0, []) :- !.

destripar(N, L) :-
    C is N // 10,   % N // 10 me da N menos el último dígito.
    R is N mod 10,  % N mod 10 me da el último dígito de N.
    destripar(C, LC),
    append(LC, [R], L).


% Versión anterior, más larga e ineficiente.

/*

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

*/