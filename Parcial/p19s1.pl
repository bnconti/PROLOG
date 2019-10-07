% 1 - Palíndromo

/*
palindromo(L) :- 
    invertida(L, L, []).

invertida([], LInv, LInv).

invertida([Head | Tail], LInv, LAux) :-
    invertida(Tail, LInv, [Head | LAux]).
*/

palindromo([Head | Tail], [Head | TailP]) :-
    palindromo([Head | Tail], [Head | TailP], []), !.

palindromo([], [], []) :- !.

palindromo([], [Head | TailP], [Head | LisAux]) :-
    palindromo([], TailP, LisAux), !.

palindromo([Head | Tail], [Head | TailP], LisAux) :-
    palindromo(Tail, TailP, [Head | LisAux]).
