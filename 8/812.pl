% Predicado que relaciona una lista numérica L1, con otra L2, con los
% mismos elementos que L1, pero con el mayor de ellos en el último lugar.

mayor([MaxAux | T], LN) :-
    mayor(T, MaxAux, Max),          % 1ero saco el mayor elemento.
    final([MaxAux | T], Max, LN).   % 2do lo remuevo y lo agrego al final.

mayor([], Max, Max).

mayor([C | T], MaxAux, Max) :-
    M is max(C, MaxAux),
    mayor(T, M, Max).

final([], MaxAux, [MaxAux]).

final([MaxAux | T], MaxAux, LN) :-
    final(T, MaxAux, LN), !.

final([H | T], MaxAux, [H | LN]) :-
    final(T, MaxAux, LN).
