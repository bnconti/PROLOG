% Solución propia.

% 1. Definir la relación adyacentes(E1, E2, L) que verifique 
% si los elementos E1 y E2 pertenecen a la lista L y además
% están uno inmediatamente después del otro.

adyacentes(E1, E2, [E1, E2 | _]) :- !.

adyacentes(E1, E2, [_, H2 | T]) :-
    adyacentes(E1, E2, [H2 | T]).


% 2. Escriba un predicado intervalo (I, N, M) donde I es la
% lista ordenada que inicia en N y termina en M.

intervalo([M], M, M).

intervalo([N|T], N, M) :-
    N1 is N+1,
    intervalo(T, N1, M), !.


% 3. Consideremos una relación representada por pares ordenados,
% luego escribir un predicado función(R) que sea verdadero si la
% relación R es una función, y un predicado inyectiva(R) que sea
% verdadera si la relación es una función inyectiva.




% 4. Definir la relación signo(D, M, S) que se verifique cuando
% el día D y el mes M correspondan al signo S. Controle que el
% día D esté comprendido dentro del rango permitido para el mes M.

signo(D, marzo, aries) :-
    D >= 21,
    D =< 31.

signo(D, abril, aries) :-
    D >= 1,
    D =< 21.

signo(D, abril, tauro) :-
    D >= 21,
    D =< 30.

signo(D, mayo, tauro) :-
    D >= 1,
    D =< 20.

signo(D, mayo, geminis) :-
    D >= 21,
    D =< 31.

signo(D, junio, geminis) :-
    D >= 1,
    D =< 20.

signo(D, junio, cancer) :-
    D >= 21,
    D =< 30.

signo(D, julio, cancer) :-
    D >= 1,
    D =< 22.

signo(D, julio, leo) :-
    D >= 23,
    D =< 31.

signo(D, agosto, leo) :-
    D >= 1,
    D =< 23.

signo(D, agosto, virgo) :-
    D >= 24,
    D =< 31.

signo(D, septiembre, virgo) :-
    D >= 1,
    D =< 23.

signo(D, septiembre, libra) :-
    D >= 24,
    D =< 30.

signo(D, octubre, libra) :-
    D >= 1,
    D =< 22.

signo(D, octubre, escorpio) :-
    D >= 23,
    D =< 31.

signo(D, noviembre, escorpio) :-
    D >= 1,
    D =< 22.

signo(D, noviembre, sagitario) :-
    D >= 23,
    D =< 30.

signo(D, diciembre, sagitario) :-
    D >= 1,
    D =< 21.

signo(D, diciembre, capricornio) :-
    D >= 22,
    D =< 31.

signo(D, enero, capricornio) :-
    D >= 1,
    D =< 20.

signo(D, enero, acuario) :-
    D >= 21,
    D =< 31.

signo(D, febrero, acuario) :-
    D >= 1,
    D =< 18.

signo(D, febrero, piscis) :-
    D >= 19,
    D =< 28.

signo(D, marzo, piscis) :-
    D >= 1,
    D =< 20.
