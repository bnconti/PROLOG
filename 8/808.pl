% Predicado que relaciona dos listas de igual longitud L1 y L2, con una 
% tercera L3, tal que los elementos de L3 son sublistas formadas por los
% elementos correspondientes de L1 y L2 tomados de a pares.

duplas([H1|T1], [H2|T2], [[H1, H2] | LN]) :-
    duplas(T1, T2, LN).

duplas([H1], [H2], [[H1, H2]]).
