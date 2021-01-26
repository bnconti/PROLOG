# PROLOG

[SWI Prolog](https://www.swi-prolog.org/)
[Racket](https://racket-lang.org/)

## Notas Prolog
* Para consultar un programa, `swipl nombre` o `swipl` y desp. `['nombre']`.
* `trace` para seguir la ejecución del programa paso a paso. `notrace` para desactivar.
* El `!` se usa para que no siga buscando soluciones.
* `Ctrl+D` para hacer halt y salir del programa.

## Notas Racket
* Usar Dr. Racket como entorno de desarrollo.
* `Ctrl+S` para guardar y `Ctrl+R` para correr el archivo y poder llamar a las funciones.
* `define-trace` permite seguir la ejecución de las funciones.


## N Reinas

Instalar [Scryer Prolog](https://github.com/mthom/scryer-prolog).

```
# scryer-prolog reinas.pl
   
   ?- n_reinas(8, Rs), labeling([ff], Rs).
      Rs = [1,5,8,6,3,7,2,4]
   ;  Rs = [1,6,8,3,7,4,2,5]
   ;  Rs = [1,7,4,6,8,2,5,3]
   ;  ...
```
## Sudoku

```
docker build -t clj .
docker run -it --rm --name sudoku clj
```

Salida a modo de ejemplo:
```
:: Problema:
850002400
720000009
004000000
000107002
305000900
040000000
000080070
017000000
000036040

:: Soluci├│n:
 8   5   9 | 6   1   2 | 4   3   7 
 7   2   3 | 8   5   4 | 1   6   9 
 1   6   4 | 3   7   9 | 5   2   8 
-----------+-----------+-----------
 9   8   6 | 1   4   7 | 3   5   2 
 3   7   5 | 2   6   8 | 9   1   4 
 2   4   1 | 5   9   3 | 7   8   6 
-----------+-----------+-----------
 4   3   2 | 9   8   1 | 6   7   5 
 6   1   7 | 4   2   5 | 8   9   3 
 5   9   8 | 7   3   6 | 2   4   1 

:: Problema:
4.....8.5
.3.......
...7.....
.2.....6.
....8.4..
....1....
...6.3.7.
5..2.....
1.4......

:: Soluci├│n:
 4   1   7 | 3   6   9 | 8   2   5 
 6   3   2 | 1   5   8 | 9   4   7 
 9   5   8 | 7   2   4 | 3   1   6 
-----------+-----------+-----------
 8   2   5 | 4   3   7 | 1   6   9 
 7   9   1 | 5   8   6 | 4   3   2 
 3   4   6 | 9   1   2 | 7   5   8 
-----------+-----------+-----------
 2   8   9 | 6   4   3 | 5   7   1 
 5   7   3 | 2   9   1 | 6   8   4 
 1   6   4 | 8   7   5 | 2   9   3 

:: Problema:
52...6...
......7.1
3........
...4..8..
6......5.
.........
.418.....
....3..2.
..87.....

:: Soluci├│n:
 5   2   7 | 3   1   6 | 4   8   9 
 8   9   6 | 5   4   2 | 7   3   1 
 3   1   4 | 9   8   7 | 5   6   2 
-----------+-----------+-----------
 1   7   2 | 4   5   3 | 8   9   6 
 6   8   9 | 2   7   1 | 3   5   4 
 4   5   3 | 6   9   8 | 2   1   7 
-----------+-----------+-----------
 9   4   1 | 8   2   5 | 6   7   3 
 7   6   5 | 1   3   4 | 9   2   8 
 2   3   8 | 7   6   9 | 1   4   5 
```
