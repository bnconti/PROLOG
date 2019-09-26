% Predicado unario que es verdadero cuando su sujeto
% es una lista numérica ordenada en forma creciente.

ordenada([_], true).

ordenada([Val1, Val2|T], R) :-
    Val1 =< Val2,
    ordenada([Val2|T], R).