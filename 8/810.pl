% Predicado que vincula un número en notación romana, tal que 
% los caracteres romanos son elementos de una lista L1, con el
% mismo número en notación arábiga.

valor(i, 1).
valor(v, 5).
valor(x, 10).
valor(l, 50).
valor(c, 100).
valor(d, 500).
valor(m, 1000).

arabigo([X, Y | T], Valor) :-
    valor(X, Vx),
    valor(Y, Vy),
    Vx < Vy,
    arabigo(T, Sig_Valor),
    Valor is Vy - Vx + Sig_Valor, !.

arabigo([X | T], Valor) :-
    valor(X, Vx),
    arabigo(T, Sig_Valor),
    Valor is Vx + Sig_Valor.

arabigo([], 0).
