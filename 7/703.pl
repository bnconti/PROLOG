% En el viaje de ida, el tren que va de Uruguaba a Saltario pasa por las estaciones de Neufé,
% Cataquèn, Cordoza, Misiomarca, Mendolta y Jujunes. Como es de esperar, en el viaje de vuelta las
% recorre en orden inverso. Armar una base con estos datos, y predicados que permitan consultar que
% estaciones están antes o después que una dada en el viaje de ida.

pasa(uruguaba, neufe).
pasa(neufe, cataquen).
pasa(cataquen, cordoza).
pasa(cordoza, misiomarca).
pasa(misiomarca, mendolta).
pasa(mendolta, jujunes).
pasa(jujunes, saltario).

conectada(ES1, ES2) :- pasa(ES1, ES2).
conectada(ES1, ES2) :- pasa(ES1, ESN), conectada(ESN, ES2).
