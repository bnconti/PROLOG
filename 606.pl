% Preparar un predicado binario que sea verdadero cuando sus dos
% sujetos sean números tales que el primero es múltiplo del segundo.

multi(N, N).

multi(M, A) :-
    (   
        TEMP is M-A,
        TEMP >= A,
        multi(TEMP, A), !
    )
    ;
    (   
        TEMP is A-M,
        TEMP >= M,
        multi(TEMP, M)
    ).