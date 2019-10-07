% 1 - Palíndromo

% Esta solución recibe una sola lista, es más sencilla.

/*
palindromo(L) :- 
    invertida(L, L, []).

invertida([], LInv, LInv).

invertida([Head | Tail], LInv, LAux) :-
    invertida(Tail, LInv, [Head | LAux]).
*/

% El ejercicio original.

palindromo([Head | Tail], [Head | TailP]) :-
    palindromo([Head | Tail], [Head | TailP], []), !.

palindromo([], [], []) :- !.

palindromo([], [Head | TailP], [Head | LisAux]) :-
    palindromo([], TailP, LisAux), !.

palindromo([Head | Tail], [Head | TailP], LisAux) :-
    palindromo(Tail, TailP, [Head | LisAux]).


% 2 - Lista con duplicados.

doble([], []) :- !.

doble([Cab | ColaOrig], [Cab, Cab | ColaDoble ]) :-
    doble(ColaOrig, ColaDoble).


% 3 - Conjuntos disjuntos (ningún elemento en común).

% Un conjunto A es disjunto con B si ningún elemento de A pertenece a B y ningún
% elemento de B pertenece a A. O sea, la intersección es vacía.

disjuntos([CabC1 | ColaC1], [CabC2 | ColaC2]) :-
    disjunto([CabC1 | ColaC1], [CabC2 | ColaC2]),
    disjunto([CabC2 | ColaC2], [CabC1 | ColaC1]).

disjunto([], _) :- !.

disjunto([Cab | ColaConj], Conjunto) :-
    not(member(Cab, Conjunto)),
    disjunto(ColaConj, Conjunto), !.


% 4 - Nro. de ocurrencias de un elemento en una lista.

ocurrencias(_, [], 0) :- !.

ocurrencias(Elem, [Elem | Cola], Cant) :-
    ocurrencias(Elem, Cola, CantAux),
    Cant is CantAux + 1, !.

ocurrencias(Elem, [_ | Cola], Cant) :-
    ocurrencias(Elem, Cola, Cant).