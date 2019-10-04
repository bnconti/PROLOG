% Predicado unario que es verdadero cuando su sujeto
% es una lista numérica ordenada en forma creciente.

ordenada([_]) :- !.     % Una lista de un único elemento
                        % está siempre ordenada.

ordenada([Val1, Val2 | T]) :-
    Val1 =< Val2,
    ordenada([Val2 | T]), !.

ordenada([]).       % Caso especial para una lista vacía.