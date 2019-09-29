% Preparar un predicado binario que sea verdadero cuando sus dos
% sujetos sean números tales que el primero es múltiplo del segundo.

% Completar el predicado anterior para que sea verdadero si 
% cualquiera de los números es múltiplo del otro.

multi(N, N) :- !.

multi(M, N) :-
    M >= N,
    TEMP is M-N,
    TEMP >= N,
    multi(TEMP, N), !.

multi(N, M) :-
    TEMP is M-N,
    TEMP >= N,
    multi(N, TEMP).