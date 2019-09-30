% Predicado que relaciona un número N y una lista numérica
% ordenada L1, con otra lista numérica ordenada L2, formada
% con los elementos de L1 y el número N.

% Caso especial, N es más grande que todos los elems.
insertar(N, [], [N]).

% Caso gral., inserto cuando encuentro un elem. menor que N.
insertar(N, [H|T], [N, H|T]) :-    
    N < H, !.

% Bucle principal.
insertar(N, [H|TO], [H|TN]) :-
    insertar(N, TO, TN), !.
