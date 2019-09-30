bazar(fuentes).
bazar(vasos).
bazar(juego_de_café).
perfumeria(jabones).
perfumeria(crema).
perfumeria(perfume).
jugueteria(autito).
jugueteria(munheca).
jugueteria(oso).

precio(fuentes, 15).
precio(vasos, 12).
precio(juego_de_café, 20).

precio(jabones, 10).
precio(crema, 15).
precio(perfume, 25).

precio(autito, 10).
precio(munheca, 15).
precio(oso, 20).

articulos(Ba, Per, Ju) :- 
        bazar(Ba),
        perfumeria(Per),
        jugueteria(Ju).

oferta(Valor) :-
        articulos(Ba, Per, Ju),
        precio(Ba, P1), precio(Per, P2), precio(Ju, P3),
        Tot is P1+P2+P3,
        Tot =< Valor,
        write(Ba), write(', '), write(Per), write(' y '), write(Ju), write(' = '), write(Tot).
