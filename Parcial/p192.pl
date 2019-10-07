% 1 - Costo de viajes.

costo_transporte('Bariloche', 5000).
costo_transporte('Salta', 7000).
costo_transporte('Mar del Plata', 3500).

costo_alojamiento('Hotel', 'Bariloche', 800).
costo_alojamiento('Cabanha', 'Bariloche', 1400).
costo_alojamiento('Camping', 'Bariloche', 350).
costo_alojamiento('Hotel', 'Salta', 800).
costo_alojamiento('Cabanha', 'Salta', 1200).
costo_alojamiento('Camping', 'Salta', 230).
costo_alojamiento('Hotel', 'Mar del Plata', 500).
costo_alojamiento('Cabanha', 'Mar del Plata', 900).
costo_alojamiento('Camping', 'Mar del Plata', 180).

costo_viaje(Destino, Alojamiento, Dias, Precio) :-
    costo_transporte(Destino, CosTrans),
    costo_alojamiento(Alojamiento, Destino, CosAloj),
    Precio is CosTrans + CosAloj*Dias, !.


% 2 - Enésimo valor.

enesimo([Elem | _], 1, Elem) :- !.

enesimo([_ | Cola], Pos, Elem) :-    
    PosAux is Pos - 1,
    enesimo(Cola, PosAux, Elem).


% 3 - Verificar si es conjunto, unión de conjuntos.

es_conjunto(Conj) :- sin_repetidos(Conj, []).

sin_repetidos([], _) :- !.

sin_repetidos([Cab | Cola], LAux) :-
    not(member(Cab, LAux)),
    sin_repetidos(Cola, [Cab | LAux]).


union(Con1, Con2, ConUnido) :-
    copiar(Con1, [], CAux),
    copiar(Con2, CAux, ConUnidoAux),
    reverse(ConUnidoAux, ConUnido), !.

copiar([], CAux, CAux) :- !.

copiar([CabC1 | ColaC1 ], CAux, CF) :-
    not(member(CabC1, CAux)),
    copiar(ColaC1, [CabC1 | CAux], CF), !.

copiar([_ | ColaC1 ], CAux, CF) :-
    copiar(ColaC1, CAux, CF).
