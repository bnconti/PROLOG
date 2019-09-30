% Predicado que relaciona una lista L1 y un número N, menor
% o igual que la longitud de L1, con el enésimo elemento de L1.

enesimo(0, [X | _], X) :- !.

enesimo(N, [_ | T], X) :-
    N1 is N-1,
    enesimo(N1, T, X).
