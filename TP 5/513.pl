conectadas(arrecifes, san_antonio_de_areco, ruta_8).
conectadas(san_antonio_de_areco, cardales, ruta_8).
conectadas(carmen_de_areco, san_andres_de_giles, ruta_7).
conectadas(san_andres_de_giles, lujan, ruta_7).
conectadas(cardales, lujan, ruta_6).
conectadas(san_antonio_de_areco, san_andres_de_giles, ruta_41).
conectadas(san_andres_de_giles, mercedes, ruta_41).
conectadas(arrecifes, carmen_de_areco, ruta_51).
conectadas(carmen_de_areco, chivilcoy, ruta_51).
conectadas(lujan, mercedes, ruta_5).
conectadas(mercedes, chivilcoy, ruta_5).
siguiente(X, Y, Z) :- conectadas(Y, X, Z).


% a) Están conectadas San Andrés de Giles y Mercedes?
% conectadas(san_andres_de_giles, mercedes, Ruta).

% b) Chivilcoy está conectada con San Antonio de Areco?
% conectadas(chivilcoy, san_antonio_de_areco, Ruta).

% c) La ruta 51 conecta Carmen de Areco con San Andrés de Giles?
% conectadas(carmen_de_areco, san_andres_de_giles, ruta_51).

% d) Con quien está conectada Luján?
% conectadas(lujan, Conectada, Ruta).

% e) Cual es la que está conectada con San Andrés de Giles?
% conectadas(Conectada, san_andres_de_giles, Ruta).

% f) Cuales son las que están conectadas con San Andrés de Giles?
% conectadas(san_andres_de_giles, Conectada, Ruta).

% g) Que rutas llegan a Luján?
% conectadas(_, lujan, Ruta).

% h) Que rutas salen de Luján?
% conectadas(lujan, _, Ruta).

% i) Se puede salir de Carmen de Areco y llegar a Luján pasando por San Andrés de Giles?
% conectadas(carmen_de_areco, san_andres_de_giles, _), conectadas(san_andres_de_giles, lujan, _).

% j) Que ruta llega a Chivilcoy saliendo de Luján y pasando por Mercedes?
% conectadas(lujan, mercedes, Ruta), conectadas(mercedes, chivilcoy, Ruta).
