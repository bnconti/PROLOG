/* Parcial 2017 */
/* 1 */
ady(E1,E2,[E1,E2|_]).
ady(E1,E2,[_|Y]) :- ady(E1,E2,Y), !.

/* 2 */
intervalo([M],M,M).
intervalo([N|C],N,M) :- N1 is N+1, intervalo(C,N1,M).

/* 3 */
es_par_2([X,Y],[X,Y]).
es_par_2([X1,],[X2,]) :- X1 \== X2.
es_par_1(_,[]).
es_par_1(X,[H|T]) :- es_par_2(X,H), es_par_1(X,T), !.
es_func([_]).
es_func([X|C]) :- es_par_1(X,C), es_func(C), !.

es_iny_2([X,Y],[X,Y]).
es_iny_2([X1,Y1],[X2,Y2]) :-X1 \== X2, Y1 \== Y2.
es_iny_1(_,[]).
es_iny_1(X,[H|T]) :- es_iny_2(X,H), es_iny_1(X,T), !.
es_iny([]).
es_iny([X|C]) :- es_iny_1(X,C), es_iny(C), !.

/* 4 */
signo(D,marzo,aries) :- D >= 21, D =< 31, !.
signo(D,abril,aries) :- D >= 1, D =< 20, !.
signo(D,abril,tauro) :- D >= 21, D =< 30, !.
signo(D,mayo,tauro) :- D >= 1, D =< 20, !.
signo(D,mayo,geminis) :- D >= 21, D =< 31, !.
signo(D,junio,geminis) :- D >= 1, D =< 21, !.
signo(D,junio,cancer) :- D >= 22, D =< 30, !.
signo(D,julio,cancer) :- D >= 1, D =< 22, !.
signo(D,julio,leo) :- D >= 23, D =< 31, !.
signo(D,agosto,leo) :- D >= 1, D =< 23, !.
signo(D,agosto,virgo) :- D >= 24, D =< 31, !.
signo(D,septiembre,virgo) :- D >= 1, D =< 23, !.
signo(D,septiembre,libra) :- D >= 24, D =< 30, !.
signo(D,octubre,libra) :- D >= 1, D =< 22, !.
signo(D,octubre,escorpio) :- D >= 23, D =< 31, !.
signo(D,noviembre,escorpio) :- D >= 1, D =< 22, !.
signo(D,noviembre,sagitario) :- D >= 23, D =< 30, !.
signo(D,diciembre,sagitario) :- D >= 1, D =< 21, !.
signo(D,diciembre,capricornio) :- D >= 22, D =< 31, !.
signo(D,enero,capricornio) :- D >= 1, D =< 19, !.
signo(D,enero,acuario) :- D >= 20, D =< 30, !.
signo(D,febrero,acuario) :- D >= 1, D =< 19, !.
signo(D,febrero,pisis) :- D >= 20, D =< 29, !.
signo(D,marzo,pisis) :- D >= 1, D =< 20, !.