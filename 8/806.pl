% Predicado que relaciona una lista con su inversa.

invertir(LO, LI) :-
    invertir(LO, LI, []), !.

invertir([], LI, LI) :- !.  

invertir([H|T], LI, LA) :-
    invertir(T, LI, [H|LA]).

% Hay que utilizar una lista auxiliar y copiarla
% a la invertida alcanzado el caso base, porque al
% volver la recursión la va desapilando.
