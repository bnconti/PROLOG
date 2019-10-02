% Predicado que relaciona una lista numérica L1, con otra L2, con los
% mismos elementos que L1, pero con el mayor de ellos en el último lugar.

% Versión en una sola pasada.

mayor([H | T], LN) :-
    mayor([H | T], H, LN, _).

mayor([], Max, [Max], Max) :- !.

mayor([C | T], Max, LN, MaxFinal) :-
    MaxAux is max(C, Max),
    mayor(T, MaxAux, LN, MaxFinal),
    C = MaxFinal, !.

mayor([C | T], Max, [C | LN], MaxFinal) :-
    MaxAux is max(C, Max),
    mayor(T, MaxAux, LN, MaxFinal).

% Versión en dos pasadas (más claro pero más ineficiente).

mayor2([MaxAux | T], LN) :-
    mayor2(T, MaxAux, Max),          % 1ero saco el mayor2 elemento.
    final([MaxAux | T], Max, LN).    % 2do lo remuevo y lo agrego al final.

mayor2([], Max, Max).

mayor2([C | T], MaxAux, Max) :-
    M is max(C, MaxAux),
    mayor2(T, M, Max).

final([], MaxAux, [MaxAux]).

final([MaxAux | T], MaxAux, LN) :-
    final(T, MaxAux, LN), !.

final([H | T], MaxAux, [H | LN]) :-
    final(T, MaxAux, LN).