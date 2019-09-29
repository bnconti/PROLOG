% Predicado que relaciona una lista L1 y un número N, con otra
% lista L2, con los elementos de L1 menos los primeros N.

cortar(N, LI, LC) :-        % Lista Inicial, Lista Cortada
    length(LN, N),          % Crea una lista de N elementos
    append(LN, LC, LI).     % Devuelve en LC la lista cortada.
