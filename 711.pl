% Predicado que relaciona dos listas con una tercera, 
% formada con los elementos de ambas.

concatenar([], Lista, Lista).

concatenar([Elem | Lista1], Lista2, [Elem | Lista3]) :- 
    concatenar(Lista1, Lista2, Lista3).