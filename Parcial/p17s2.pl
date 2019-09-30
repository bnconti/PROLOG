% Solución de Napo

/*ejerc1*/
adyacentes([],_,_):-!.
adyacentes(X,Y,[X,Y|_]):-!.
adyacentes(E1,E2,[_,Y|Z]):- adyacentes(E1,E2,[Y|Z]),!.

/*ejerc2*/
intervalo([N],N,N).
intervalo([N|Z],N,M):- N1 is N+1, intervalo(Z,N1,M).

/*ejerc3*/

miembro(X,[X|_]).
miembro(X,[_|Y]):- miembro(X,Y).

funcion([]).
funcion([[X,_]|Z]):- not(miembro([X,_],Z)), funcion(Z).

inyectiva([]).
inyectiva([[_,Y]|Z]):- not(miembro([_,Y],Z)), inyectiva(Z).

/*ejerc4*/
horoscopo(aries,21,3,20,4).
horoscopo(tauro,21,4,20,5).
horoscopo(germinis,21,5,20,6).
horoscopo(cancer,21,6,20,7).
horoscopo(leo,21,7,20,8).
horoscopo(virgo,21,8,20,9).
horoscopo(libra,21,9,20,10).
horoscopo(escorpio,21,10,20,11).
horoscopo(sagitario,21,11,20,12).
horoscopo(capricornio,21,12,20,1).
horoscopo(acuario,21,1,20,2).
horoscopo(pisis,21,2,20,3).

cantidad_dias(1,D):- D =< 31.
cantidad_dias(2,D):- D =< 28.
cantidad_dias(3,D):- D =< 31.
cantidad_dias(4,D):- D =< 30.
cantidad_dias(5,D):- D =< 31.
cantidad_dias(6,D):- D =< 30.
cantidad_dias(7,D):- D =< 31.
cantidad_dias(8,D):- D =< 31.
cantidad_dias(9,D):- D =< 30.
cantidad_dias(10,D):- D =< 31.
cantidad_dias(11,D):- D =< 30.
cantidad_dias(12,D):- D =< 31.

signos(D,1,S):- cantidad_dias(1,D),D =< 20, horoscopo(S,21,12,20,1),!.
signos(D,12,S):- cantidad_dias(12,D),D >= 21, horoscopo(S,21,12,20,1),!.
signos(D,M,S):- cantidad_dias(M,D),D >= 21, horoscopo(S,21,M,20,M1),M1 is M+1,!.
signos(D,M,S):- cantidad_dias(M,D),D < 21, horoscopo(S,21,M1,20,M),M1 is M-1,!.