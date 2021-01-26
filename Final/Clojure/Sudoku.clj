; Fuente: http://www.learningclojure.com/2009/11/sudoku_24.html

(def filas "ABCDEFGHI")
(def columnas "123456789")
(def dígitos "123456789")
(def caracteres-casilla-vacía "0.-") ; El valor de las casillas vacías pueden ser alguno de estos caracteres

; Devuelve el producto cruz entre dos colecciones A y B
(defn prod-cruz [A, B]
  (for [a A b B] (str a b)))

; Generar índices de las casillas del tablero mediante el prod. cruz de filas y columnas. 
; casillas: (A1, A2, ..., A9, B1, ..., I9)
(def casillas (prod-cruz filas columnas))

(def tamaño-región 3)                                     ; El tablero está dividido en regiones o bloques de 3x3
(def filas-región (partition tamaño-región filas))        ; ((A, B, C), (D, E, F), (G, H, I))
(def columnas-región (partition tamaño-región columnas))  ; ((1, 2, 3), (4, 5, 6), (7, 8, 9))

; Genera una lista con todas las unidades de la grilla. Una unidad puede ser una fila, columna o región.
; lista-unidades:
; (#{E1 A1 C1 B1 F1 D1 G1 H1 I1},
;  #{I2 E2 C2 A2 G2 F2 B2 H2 D2},
;  #{D3 H3 A3 I3 B3 C3 G3 F3 E3},
;  ... )
(def lista-unidades (map set (concat
                              (for [c columnas] (prod-cruz filas [c]))      ; Columnas: (A1, B1, ...), (A2, B2, ...), ...
                              (for [f filas] (prod-cruz [f] columnas))      ; Filas: (A1, A2, ...), (B1, B2, ...), ...
                              (for [fs filas-región
                                    cs columnas-región] (prod-cruz fs cs))  ; Regiones: (A1, B1, C1, A2, ..., C3), ...
                              )))

; Funciones auxiliares para crear diccionarios y conjuntos ordenados
(defn diccionario [x] (apply sorted-map (apply concat x)))
(defn conjunto [x] (apply sorted-set (apply concat x)))

; Crea una colección con todas las unidades que le correspoden a cada casillero.
; unidades:
; {A1 (#{E1 A1 C1 B1 F1 D1 G1 H1 I1} #{A5 A1 A3 A6 A9 A7 A4 A2 A8} #{A1 A3 C1 B1 C2 B3 C3 A2 B2}),
;  A2 (#{I2 E2 C2 A2 G2 F2 B2 H2 D2} #{A5 A1 A3 A6 A9 A7 A4 A2 A8} #{A1 A3 C1 B1 C2 B3 C3 A2 B2}),
;  ... }
(def unidades (diccionario (for [c casillas]
                             [c (for [unidad lista-unidades :when (unidad c)] unidad)])))

; Crea una colección con todos los pares para cada casillero.
; Una casilla es un par de otra cuando está en una misma unidad.
; pares:
; {A1 #{A2 A3 A4 A5 A6 A7 A8 A9 B1 B2 B3 C1 C2 C3 D1 E1 F1 G1 H1 I1}, 
;  A2 #{A1 A3 A4 A5 A6 A7 A8 A9 B1 B2 B3 C1 C2 C3 D2 E2 F2 G2 H2 I2},
;  ... }
(def pares (diccionario (for [c casillas]
                          [c (disj (conjunto (unidades c)) c)])))

; El Sudoku ingresado como entrada puede contener caracteres irrelevantes. Por esto,
; limpiamos la cadena de entrada tomando solamente los que están definidos en 'dígitos'
; y en 'caracteres-casilla-vacía'.
(defn filtrar [cadena] (filter (set (concat dígitos caracteres-casilla-vacía)) cadena))

; Crea una grilla inicial, donde a cada casillero se le asignan todos los dígitos del 1 al 9.
(defn crear-grilla [] (diccionario (for [c casillas] [c, (atom dígitos)])))

; Comprueba si todos los elementos de la colección son verdaderos. Esto sirve para detectar
; soluciones inválidas, ya que en estos casos se devuelve falso.
(defn verdaderos? [colección] (every? identity colección))

; Declaración de las funciones que van a llevar a cabo la propagación de restricciones.
(declare asignar! eliminar! comprobar!)


; Uno de los puntos de entrada del programa. El sudoku ingresado por el usuario pasa 
; por esta función, donde se filtra y luego se inicializa la grilla que vamos a utilizar.
; Al terminar la función, la grilla tendrá asignados los valores pasados como pista,
; y en las casillas a completar todos los dígitos, menos los que ya están asignados en sus unidades.
; Por ej., si en la casilla A1 se pasó cmo pista el valor 1 y en A2 2, A3 va a tener los valores (3, 4, ... 9)
(defn grilla-inicial [cadena]
  (let [cadena (filtrar cadena)
        grilla (crear-grilla)]
    (if (verdaderos? (for [[casilla nro] 
        (zipmap casillas cadena) :when ((set dígitos) nro)]
        (asignar! grilla casilla nro)))
      grilla
      false)))

; La estrategia de asignación se basa en dos principios:
; 1) Si una casilla tiene un único valor posible, eliminar ese valor de sus pares. Por ejemplo, si sabemos que C1 = 4,
; entonces podemos eliminar 4 como valor candidato de los pares de C1.
; 2) Si en una unidad solamente se puede poner un valor en una sola casilla, ponerlo ahí.
; Continuando con el ejemplo, si sabemos 3 no puede ir en ninguna columna desde C3 a C9,
; y C1 ya tiene asignada 4, entonces no hay más alternativa que C2 = 3.
; Esta asignación generará un «efecto dominó» en todo el tablero, ya que 3 se eliminará como posible valor en todos
; los pares de C2. A su vez, esta actualización sobre los pares puede provocar que nuevas asignaciones sean posibles 
; en los pares de los pares, dando inicio nuevamente al proceso.

; Asigna 'nuevo-dígito' en 'casilla', y además ejecuta todas las actualizaciones que puedan haberse generado a partir de esa asignación.
; Como en un principio las casillas a completar vienen cargadas con todos los dígitos, lo que hace en realidad es eliminar
; de la casilla todos los valores menos el que se quiere asignar. Si la asignación genera una grilla inválida, devuelve falso.
(defn asignar! [grilla casilla nuevo-dígito]
  (if (verdaderos? 
    (for [dígito @(grilla casilla) :when (not (= dígito nuevo-dígito))]
      (eliminar! grilla casilla dígito)))
    grilla
    false))


; Elimina un valor de una casilla. A la hora de realizar esto existen tres casos:
; 1) Que el valor ya esté eliminado de la casilla, por lo que no hay nada que hacer.
; 2) Que luego de eliminar la casilla no cuenta con ningún valor posible, en cuyo caso
;    se llegó una grilla inválida y hay que hacer backtracking en lo posible.
; 3) Que luego de eliminar el dígito de la casilla, la misma solo cuenta con un
;    único valor posible. En este caso, este valor quedará asignado en la casilla y
;    se eliminará de sus pares. Para esto se llama recursivamente a eliminar!.
;    Y tras volver de la recursión comprueba que la grilla siga siendo válida.
(defn eliminar! [grilla casilla dígito]
  (if (not ((set @(grilla casilla)) dígito)) grilla     ; (1) Ya está eliminado
      (do
        (swap! (grilla casilla) #(. % replace (str dígito) ""))     ; Remover
        (if (= 0 (count @(grilla casilla)))
          false     ; (2) Grilla inválida
          (if (= 1 (count @(grilla casilla)))     ; (3) Un solo valor posible
            (let [dígito-aux (first @(grilla casilla))]
              (if (not (verdaderos? (for [casilla-aux (pares casilla)]
               (eliminar! grilla casilla-aux dígito-aux))))
                false
                (comprobar! grilla casilla dígito)))
            (comprobar! grilla casilla dígito))))))

; Verifica si tras eliminar un valor de una casilla se generaron contradiciones o nuevas posibilidades de asignación
(defn comprobar! [grilla casilla dígito]
  (loop [unidad (unidades casilla)] ; Bucle que recorre las tres unidades de la casilla
    (let [dplaces (for [casilla (first unidad) :when ((set @(grilla casilla)) dígito)] casilla)] ;how many possible placings of dígito 
      (if (= (count dplaces) 0) ;if none then we've failed
        false
        (if (= (count dplaces) 1) ;if only one, then that has to be the answer
          (if (not (asignar! grilla (first dplaces) dígito)) ;so we can assign it.
            false
            (if (not (empty? (rest unidad))) (recur (rest unidad)) grilla))
          (if (not (empty? (rest unidad))) (recur (rest unidad)) grilla))))))


; Necesitamos esta función para preservar el estado de la grilla 
; cuando corre el algoritmo para probar valores.
(defn copiar-grilla [grilla] (diccionario (for [clave (keys grilla)] [clave (atom @(grilla clave))])))


(defn solucionar
  ([grilla] (solucionar grilla ""))
  ([grilla, iteración]
   (if grilla
     (if (verdaderos? (for [c casillas] (= 1 (count @(grilla c))))) ; (1)Si todas las casillas tienen un solo valor...
       grilla                                                       ; Ya tenemos la solución, devolverla.
       (let [pivote                                                 ; Caso contrario...
             (second (first (sort     ; Seleccionar la casilla con más de un valor, pero con la menor cant. de valores
                             (for [c casillas :when (> (count @(grilla c)) 1)]
                               [(count @(grilla c)), c]))))]
         (let [resultados (for [nro @(grilla pivote)] ;try all choices
                         (do ;(imprimir-tablero grilla)
                           (solucionar (asignar! (copiar-grilla grilla) pivote nro) (str iteración nro))))] ;(format "%s->%s;" pivot d)
           (some identity resultados)))) ;and if any of them come back solved, return solution
     false)))


; Funciones para dibujar el tablero en pantalla

(defn centre [s width]
  (let [pad (- width (count s))
        lpad (int (/ pad 2))
        rpad (- pad lpad)]
    (str (apply str (repeat lpad " ")) s (apply str (repeat  rpad " ")))))

(defn join [char seq]
  (apply str (interpose char seq)))

(defmacro forjoin [sep [var seq] body]
  `(join ~sep (for [~var ~seq] ~body)))

(defn tablero [grilla]
  (if (= grilla false)
    "Sin solución"

    (let [width (+ 2 (apply max (for [s casillas] (count @(grilla s)))))
          line (str \newline
                    (join \+ (repeat tamaño-región
                                     (join \- (repeat tamaño-región
                                                      (apply str (repeat width "-"))))))
                    \newline)]
      (forjoin line [rg filas-región]
               (forjoin "\n" [r rg]
                        (forjoin "|" [cg columnas-región]
                                 (forjoin " " [c cg]
                                          (centre @(grilla (str r c)) width))))))))

(defn imprimir-tablero [grilla] (println (tablero grilla)))
(defn imprimir-problema [problema]  (println (join \newline (map #(apply str %) (partition 9 (filter (set (concat dígitos caracteres-casilla-vacía)) problema))))))

(def sudoku-dificil "
850002400
720000009
004000000
000107002
305000900
040000000
000080070
017000000
000036040
")


(def sudokus-95 (with-open [rdr (clojure.java.io/reader "95sudokus.txt")] 
                          (reduce conj [] (line-seq rdr))))

(defn probar-solucion [problema]
     (do
       (println "\n:: Problema:")
       (imprimir-problema problema)
       (println "\n:: Solución:")
       (imprimir-tablero (solucionar (grilla-inicial problema)))))

(probar-solucion sudoku-dificil)

(doall (map probar-solucion sudokus-95))