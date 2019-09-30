padre_de(homero, pericles).
padre_de(homero, merlina).
padre_de(desconocido, lucas).
padre_de(desconocido, homero).
varon(homero).
varon(lucas).
varon(cosa).
varon(pericles).
mujer(merlina).
mujer(morticia).
mujer(la-abuela).
madre(la-abuela, homero).
esposos(morticia, homero).

hermano_de(X, Y) :-
    padre_de(P, X), 
    padre_de(P, Y),
    X \= Y.

tio(T) :-
    padre_de(P, merlina),
    hermano_de(P, T).