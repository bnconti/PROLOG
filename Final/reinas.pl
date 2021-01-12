:- use_module(library(clpz)).

n_reinas(N, Rs) :- 
	length(Rs, N),
	Rs ins 1..N,
	reinas_seguras(Rs).

reinas_seguras([]).
reinas_seguras([R|Rs]) :- 
	reinas_seguras_aux(Rs, R, 1),
	reinas_seguras(Rs).
	
reinas_seguras_aux([], _, _).
reinas_seguras_aux([R|Rs], R0, D0) :-
	R #\= R0,
	abs(R0 - R) #\= D0,
	D1 #= D0 + 1,
	reinas_seguras_aux(Rs, R0, D1).
	
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Ejemplos:
   ?- n_reinas(8, Rs), labeling([ff], Qs).
      Rs = [1,5,8,6,3,7,2,4]
   ;  Rs = [1,6,8,3,7,4,2,5]
   ;  Rs = [1,7,4,6,8,2,5,3]
   ;  ...
   ?- n_reinas(100, Qs), labeling([ff], Qs).
      Rs = [1,3,5,57,59,4,64,7,58,71|...]
   ;  Rs = [1,3,5,57,59,4,64,7,58,71|...]
   ;  ...
   
   Basado en https://www.metalevel.at/queens/
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */