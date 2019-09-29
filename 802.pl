% Predicado que relaciona dos átomos A y B, y dos listas C y D, 
% tal que D es igual a C, pero con el átomo A sustituido por el
% B, en su primer ocurrencia.

sustituir(_, _, [], []).

sustituir(A, B, [A|T], [B|T]) :- ! .

sustituir(A, B, [H|T], [H|LN]) :-
    sustituir(A, B, T, LN).
