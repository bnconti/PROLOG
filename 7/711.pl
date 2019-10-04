% Predicado que relaciona dos listas con una tercera, 
% formada con los elementos de ambas.

concatenar([], L2, L2).

concatenar([H | T], L2, [H | LC]) :-
    concatenar(T, L2, LC).

% Predicado 1: cuando haya sacado todos los elementos de L1, unifico L2 con la nueva lista.
% Predicado 2: agrego de derecha a izquierda los elementos de la L1 a la cabeza de la nueva lista,
% la cual tendrá copiada la L2.