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