% Predicado que relaciona dos átomos A y B, y dos listas C y D,
% tal que D es igual a C, pero con el átomo A sustituido por el
% B, en todas sus ocurrencias.

sustituir(_, _, [], []).

sustituir(A, B, [A|T], [B|LN]) :-
     sustituir(A, B, T, LN), ! .

sustituir(A, B, [H|T], [H|LN]) :-
    sustituir(A, B, T, LN).
