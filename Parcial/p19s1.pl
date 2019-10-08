% 1. Predicado que recibe dos listas y que es verdadero
% cuando la primer lista es un subconjunto de la segunda,
% es decir, todo elemento de la primera está presente
% en la segunda.

subconjunto([], _) :- !.

subconjunto([Cab | Cola], Lista2) :-
    es_miembro(Cab, Lista2),
    subconjunto(Cola, Lista2).

es_miembro(Elem, [Elem|_]) :- !.

es_miembro(Elem, [_|ColaL2]) :-
    es_miembro(Elem, ColaL2).


% 2. Predicado que relaciona una lista L1 y un elemento
% A perteneciente a la misma, con otra lista L2, formada
% con los mismos elementos de L1, menos A.

borrar([], _, []) :- !.

borrar([Elem|ColaL1], Elem, LNueva) :-
    borrar(ColaL1, Elem, LNueva), !.

borrar([Cab|ColaL1], Elem, [Cab|LNueva]) :-
    borrar(ColaL1, Elem, LNueva).

% 3. Predicado que dada una lista de enteros L,
% se satisface si existe algún elemento en L que
% igual a la suma de los demás elementos de L, y 
% falla en caso contrario.

suma(L) :-
    length(L, Long),
    suma(L, Long, 0).

suma([E|Cola], Long, Cont) :-
    ContAux is Cont + 1,
    ContAux =< Long,
    igual(E, Cola).

suma([E|Cola], Long, Cont) :-
    append(Cola, [E], LCorrida),
    ContAux is Cont + 1,
    ContAux =< Long,
    suma(LCorrida, Long, ContAux).

igual(E, Cola) :-
    igual(E, Cola, 0).

igual(E, [], E).

igual(E, [C|Cola], Tot) :-
    TotAux is Tot + C,
    igual(E, Cola, TotAux).


% 4. Predicado que, dada una lista de enteros, 
% escriba la lista que para cada elemento de L,
% dice cuántas veces aparece ese elemento en L.

card(L, LCont) :-
    card(L, LCont, []), !.

card([], [], _) :- !.

card([E|Cola], [[E,Tot] | ColaCont], LAux) :-
    not(member(E, LAux)),
    contar(E, Cola, Tot),
    card(Cola, ColaCont, [E|LAux]), !.

card([_|Cola], ColaCont, LAux) :-
    card(Cola, ColaCont, LAux).

contar(_, [], 1) :- !.

contar(E, [E|Cola], Tot) :-
    contar(E, Cola, TotAux),
    Tot is TotAux + 1, !.

contar(E, [_|Cola], Tot) :-
    contar(E, Cola, Tot).