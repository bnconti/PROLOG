% 1 - Bebidas

recarga('comerciante', 'agua', 0.25).
recarga('comerciante', 'gaseosa', 0.25).
recarga('comerciante', 'vino nacional', 0.30).
recarga('comerciante', 'vino importado', 0.50).
recarga('comerciante', 'whisky nacional', 0.50).
recarga('comerciante', 'whisky importado', 0.50).

recarga('particular', 'agua', 0.30).
recarga('particular', 'gaseosa', 0.40).
recarga('particular', 'vino nacional', 0.60).
recarga('particular', 'vino importado', 0.70).
recarga('particular', 'whisky nacional', 0.60).
recarga('particular', 'whisky importado', 0.70).

cliente('Luisa', 'particular').
cliente('Rubén', 'particular').
cliente('Zoraida', 'comerciante').
cliente('Ramón', 'comerciante').

precio('Villavicencio', 'agua mineral', 15).
precio('Glaciar', 'agua mineral', 12).
precio('CocaCola', 'gaseosa', 15).
precio('Goliat', 'gaseosa', 15).
precio('Bianchi', 'vino nacional', 20).
precio('Trapiche', 'vino nacional', 25).
precio('Richelieu', 'vino importado', 33).
precio('Cucagna', 'vino importado', 45).
precio('Criadores', 'whisky nacional', 60).
precio('Grants', 'whisky importado', 75).

calc_precio(NOM_CLIENTE, NOM_BEBIDA, PRECIO_FINAL) :-
    cliente(NOM_CLIENTE, TIPO_CLIENTE),
    precio(NOM_BEBIDA, TIPO_BEBIDA, PRECIO_BASE),
    recarga(TIPO_CLIENTE, TIPO_BEBIDA, RECARGA),
    PRECIO_FINAL is PRECIO_BASE + PRECIO_BASE*RECARGA.

% 3 

insord(N, [], [N]) :- !.

insord(N, [X | Y], [N, X | Y]) :-
    N =< X, !.

insord(N, [X | Y], [X | LF]) :- 
    insord(N, Y, LF).


igual([], []).

igual([X | Y], [X | Y1]) 
    :- igual(Y, Y1).