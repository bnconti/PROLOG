rotar([X, Y], [Y, X]) :- !.
rotar([X, Y | T], [Y | LF]) :- rotar([X | T], LF).