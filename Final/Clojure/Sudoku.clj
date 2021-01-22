;; http://www.learningclojure.com/2009/11/sudoku_24.html

(def filas "ABCDEFGHI")
(def columnas "123456789")
(def dígitos "123456789")
(def caracteres-casilla-vacía "0.-") ;; El valor de las casillas vacías pueden ser alguno de estos caracteres

;; Devuelve el producto cruz entre dos colecciones A y B
(defn prod-cruz [A, B]
  (for [a A b B] (str a b)))

;; Generar índices de las casillas del tablero mediante el prod. cruz de filas y columnas. 
;; casillas: (A1, A2, ..., A9, B1, ..., I9)
(def casillas (prod-cruz filas columnas))

(def tamaño-región 3)                                     ;; El tablero está dividido en regiones o bloques de 3x3
(def filas-región (partition tamaño-región filas))        ;; ((A, B, C), (D, E, F), (G, H, I))
(def columnas-región (partition tamaño-región columnas))  ;; ((1, 2, 3), (4, 5, 6), (7, 8, 9))

;; Genera una lista con todas las unidades de la grilla. Una unidad puede ser una fila, columna o región.
;; lista-unidades:
;; (#{E1 A1 C1 B1 F1 D1 G1 H1 I1},
;;  #{I2 E2 C2 A2 G2 F2 B2 H2 D2},
;;  #{D3 H3 A3 I3 B3 C3 G3 F3 E3},
;;  ... )
(def lista-unidades (map set (concat
                              (for [c columnas] (prod-cruz filas [c]))      ; Columnas: (A1, B1, ...), (A2, B2, ...), ...
                              (for [f filas] (prod-cruz [f] columnas))      ; Filas: (A1, A2, ...), (B1, B2, ...), ...
                              (for [fs filas-región
                                    cs columnas-región] (prod-cruz fs cs))  ; Regiones: (A1, B1, C1, A2, ..., C3), ...
                              )))

;; Funciones auxiliares para crear diccionarios y conjuntos ordenados
(defn diccionario [x] (apply sorted-map (apply concat x)))
(defn conjunto [x] (apply sorted-set (apply concat x)))

;; Crea una colección con todas las unidades que le correspoden a cada casillero.
;; unidades:
;; {A1 (#{E1 A1 C1 B1 F1 D1 G1 H1 I1} #{A5 A1 A3 A6 A9 A7 A4 A2 A8} #{A1 A3 C1 B1 C2 B3 C3 A2 B2}),
;;  A2 (#{I2 E2 C2 A2 G2 F2 B2 H2 D2} #{A5 A1 A3 A6 A9 A7 A4 A2 A8} #{A1 A3 C1 B1 C2 B3 C3 A2 B2}),
;;  ... }
(def unidades (diccionario (for [c casillas]
                             [c (for [u lista-unidades :when (u c)] u)])))

;; Crea una colección con todos los pares para cada casillero.
;; Una casilla es un par de otra cuando está en una misma unidad.
;; pares:
;; {A1 #{A2 A3 A4 A5 A6 A7 A8 A9 B1 B2 B3 C1 C2 C3 D1 E1 F1 G1 H1 I1}, 
;;  A2 #{A1 A3 A4 A5 A6 A7 A8 A9 B1 B2 B3 C1 C2 C3 D2 E2 F2 G2 H2 I2},
;;  ... }
(def pares (diccionario (for [c casillas]
                          [c (disj (conjunto (unidades c)) c)])))

;; El Sudoku ingresado como entrada puede contener caracteres irrelevantes. Por esto,
;; limpiamos la cadena de entrada tomando solamente los que están definidos en 'dígitos'
;; y en 'caracteres-casilla-vacía'.
(defn filtrar [cadena] (filter (set (concat dígitos caracteres-casilla-vacía)) cadena))

;; Crea una grilla inicial, donde a cada casillero se le asignan todos los dígitos del 1 al 9.
(defn inicializar-grilla [] (diccionario (for [c casillas] [c,(atom dígitos)])))

;; Comprueba si todos los elementos de la colección son verdaderos (?)
(defn verdaderos? [coleccion] (every? identity coleccion))

;; Uno de los puntos de entrada del programa. El sudoku ingresado por el usuario pasa 
;; por esta función, donde se filtra y luego se inicializa la grilla que vamos a utilizar.
;; Al terminar la función, la grilla tendrá asignados los valores pasados como pista,
;; y en las casillas a completar todos los dígitos, menos los que ya están asignados en sus unidades.
;; Por ej., si en la casilla A1 se pasó cmo pista el valor 1 y en A2 2, A3 va a tener los valores (3, 4, ... 9)
(defn grilla [cadena]
  (let [cadena (filtrar cadena)
        valores (inicializar-grilla)]
    (if (verdaderos? (for [[casilla nro] (zipmap casillas cadena) :when ((set dígitos) nro)]
                       (asignar! valores casilla nro)))
      valores
      false)))


;; Declaración de las funciones que van a llevar a cabo la propagación de restricciones.
(declare asignar! eliminar! comprobar!)

;; Asigna 'nro' en 'casilla'. Como las casillas a completar ya vienen cargadas con todos los dígitos,
;; lo que hace en realidad es eliminar todos los valores menos el que se quiere asignar.
(defn asignar! [valores casilla nro]
  (if (verdaderos? (for [d @(valores casilla) :when (not (= d nro))]
                     (eliminar! valores casilla d)))
    valores
    false))


;; Elimina un valor de una casilla. Si tras hacer esto no quedan valores, la función devuelve falso (sí o sí tiene que ir un número)
;; Si sólo queda un número en la casilla, entonces ese nú
;; remove a potential choice from a square. If that leaves no values, then that's a fail
;;if it leaves only one value then we can also eliminate that value from its peers.
;;either way, perform checks to see whether we've left the eliminated value with only one place to go.           
(defn eliminar! [values s d]
  (if (not ((set @(values s)) d)) values ;;if it's already not there nothing to do

      (do
        (swap! (values s) #(. % replace (str d) "")) ;;remove it
        (if (= 0 (count @(values s))) ;;no possibilities left

          false                       ;;fail
          (if (= 1 (count @(values s))) ;; one possibility left
            (let [d2 (first @(values s))]
              (if (not (verdaderos? (for [s2 (pares s)] (eliminar! values s2 d2))))
                false
                (comprobar! values s d)))
            (comprobar! values s d))))))

;; Verifica si tras eliminar un valor de una casilla se generaron contradiciones o nuevas posibilidades de asignación
(defn comprobar! [values s d]
  (loop [u (unidades s)] ;;for each row, column, and block associated with square s
    (let [dplaces (for [s (first u) :when ((set @(values s)) d)] s)] ;;how many possible placings of d 

      (if (= (count dplaces) 0) ;;if none then we've failed
        false
        (if (= (count dplaces) 1) ;;if only one, then that has to be the answer

          (if (not (asignar! values (first dplaces) d)) ;;so we can assign it.
            false
            (if (not (empty? (rest u))) (recur (rest u)) values))
          (if (not (empty? (rest u))) (recur (rest u)) values))))))

;; Dibuja el tablero
(defn centre [s width]
  (let [pad (- width (count s))
        lpad (int (/ pad 2))
        rpad (- pad lpad)]
    (str (apply str (repeat lpad " ")) s (apply str (repeat  rpad " ")))))

(defn join [char seq]
  (apply str (interpose char seq)))

(defmacro forjoin [sep [var seq] body]
  `(join ~sep (for [~var ~seq] ~body)))

(defn board [values]
  (if (= values false)
    "no solution"

    (let [width (+ 2 (apply max (for [s casillas] (count @(values s)))))
          line (str \newline
                    (join \+ (repeat tamaño-región
                                     (join \- (repeat tamaño-región
                                                      (apply str (repeat width "-"))))))
                    \newline)]
      (forjoin line [rg filas-región]
               (forjoin "\n" [r rg]
                        (forjoin "|" [cg columnas-región]
                                 (forjoin " " [c cg]
                                          (centre @(values (str r c)) width))))))))

(defn print_board [values] (println (board values)))


;;We can't use Dr Norvig's trick of avoiding a deep copy by using strings. We have to copy the table
;;by recreating the atoms and copying their contents
(defn deepcopy [values] (diccionario (for [k (keys values)] [k (atom @(values k))])))

;;I've added a frill here where the search function keeps track of the search branches that it's following.

;;This means that we can print the branches out when debugging.
(defn search
  ([values] (search values ""))
  ([values, recurse]
   (println "recursion: " recurse)
   (if values
     (if (verdaderos? (for [s casillas] (= 1 (count @(values s))))) ;;if all squares determined

       values                                               ;;triumph!
       (let [pivot
             (second (first (sort     ;;which square has fewest choices?
                             (for [s casillas :when (> (count @(values s)) 1)]
                               [(count @(values s)),s]))))]
         (let [results (for [d @(values pivot)] ;;try all choices

                         (do ;(print_board values)
                           (search (asignar! (deepcopy values) pivot d) (str recurse d))))] ;(format "%s->%s;" pivot d)
           (some identity results)))) ;;and if any of them come back solved, return solution


     false)))
