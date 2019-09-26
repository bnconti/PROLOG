% Predicado que relaciona una lista cualquiera con
% el elemento que se encuentra en el último lugar.

ultimo([Ult], X) :- X is Ult, !.

ultimo([_|T], X) :-
    ultimo(T, X).