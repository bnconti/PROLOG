% Predicado que relaciona una lista numérica de dos elementos 
% con otra lista con esos dos elementos ordenados de menor a mayor.

acomodados([Val1, Val2], [Val2, Val1]) :- Val1 =< Val2, !.

acomodados([Val1, Val2], [Val1, Val2]).