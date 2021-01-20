;; http://www.learningclojure.com/2009/11/sudoku_24.html

;; Devuelve el producto cruz entre dos colecciones
(defn prod-cruz [A, B]
  (for [a A b B] (str a b)))

(def filas "ABCDEFGHI")
(def columnas "123456789")
(def digitos "123456789")

(def tamaño-region 3)                                     ;; El tablero está dividido en regiones o bloques de 3x3
(def filas-region (partition tamaño-region filas))        ;; ((A, B, C), (D, E, F), (G, H, I))
(def columnas-region (partition tamaño-region columnas))  ;; ((1, 2, 3), (4, 5, 6), (7, 8, 9))

;; Las casillas vacías van a etiquetarse con alguno de estos caracteres
(def caracteres-casilla-vacia "0.-")

;; Generar índices de las casillas del tablero mediante
;; el prod. cruz de filas y columnas. A1, A2, ..., I9
(def casillas (prod-cruz filas columnas))

;; Genera una lista con todas las unidades de la grilla.
;; Una unidad puede ser una fila, columna o región.
(def lista-unidades (map set (concat
                        (for [c columnas] (prod-cruz filas [c]))      ; Columnas: (A1, B1, ...), (A2, B2, ...), ...
                        (for [f filas] (prod-cruz [f] columnas))      ; Filas: (A1, A2, ...), (B1, B2, ...), ...
                        (for [fs filas-region
                              cs columnas-region] (prod-cruz fs cs))  ; Regiones: (A1, B1, C1, A2, ..., C3), ...
                              )))

;; Funciones auxiliares para crear diccionarios y conjuntos
(defn diccionario [x] (apply sorted-map (apply concat x)))
(defn union-conjuntos [x] (apply sorted-set (apply concat x)))

;; Comprueba si todos los elementos de la colección son verdaderos
(defn verdaderos? [coleccion] (every? identity coleccion))

;; Crea una colección con todas las unidades que le correspoden a cada casillero.
(def unidades (diccionario (for [c casillas]
                   [c (for [u lista-unidades :when (u c)] u)] )))

;; Crea una colección con todos los pares para cada casillero.
(def pares (diccionario (for [c casillas] 
                   [c (disj (union-conjuntos (unidades c)) c)])))

;; Declaración de las funciones que van a llevar a cabo 
;; la propagación de restricciones. Retornarán falso cuando
;; las mismas no se cumplan.
(declare asignar! eliminar! comprobar!)

;; Filtrar solo la parte relevante de la entrada para generar la grilla
(defn filtrar [cadena] (filter (set (concat digitos caracteres-casilla-vacia)) cadena))

;; Crea una grilla, donde cada casillero puede contener todos los digitos (?)
(defn crear-grilla [] (diccionario (for [c casillas] [c,(atom digitos)])))

;; Convierte una cadena de texto (que representa una grilla) en un diccionario
;; con posibles valores para cada casillero
(defn convertir-grilla [cadena]
  (let [cadena (filtrar cadena)
        values (crear-grilla)]
    (if (verdaderos? (for [[square digit] (zipmap casillas cadena) :when ((set digitos) digit)]
                  (asignar! values square digit)))
      values
      false)))


;;assign a definite value to a square by eliminating all other values.    
(defn asignar! [values square digit]
  (if (verdaderos? (for [d @(values square) :when (not (= d digit))] 
              (eliminar! values square d)))
    values
    false))


;;remove a potential choice from a square. If that leaves no values, then that's a fail
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


;;check whether the elimination of a value from a square has caused contradiction or further assignment
;;possibilities
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


;;the function to print out the board is the hardest thing to translate from python to clojure!
(defn centre[s width]
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

    (let [ width (+ 2 (apply max (for [s casillas] (count @(values s)))))
          line (str \newline 
                    (join \+ (repeat tamaño-region 
                                     (join \- (repeat tamaño-region 
                                                      (apply str (repeat width "-"))))))
                    \newline)]
      (forjoin line [rg filas-region]
               (forjoin "\n" [r rg]
                        (forjoin "|" [cg columnas-region]
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
         (let [ pivot 
               (second (first (sort     ;;which square has fewest choices?
                               (for [s casillas :when (>(count @(values s)) 1)] 
                                 [(count @(values s)),s]))))] 
           (let [results (for [d @(values pivot)] ;;try all choices

                           (do ;(print_board values)
                               (search (asignar! (deepcopy values) pivot d) (str recurse d))))] ;(format "%s->%s;" pivot d)
                (some identity results)))) ;;and if any of them come back solved, return solution

         
       false)))
