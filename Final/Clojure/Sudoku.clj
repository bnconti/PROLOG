(defn ProdCruz [A, B]
  (for [a A b B] (str a b)))

(def filas "ABCDEFGHI")
(def columnas "123456789")
(def digitos "123456789")

;; El tablero está dividido en regiones o bloques de 3x3
(def tamañoRegion 3)
(def filasRegion (partition tamañoRegion filas))
(def columnasRegion (partition tamañoRegion columnas))

;; Las casillas vacías van a etiquetarse con alguno de estos caracteres
(def caracteresCasillaVacia "0.-")

;; Generar índices de las casillas del tablero mediante
;; el prod. cruz de filas y columnas. A1, A2, ..., I9
(def casillas (ProdCruz filas columnas))

;; Las unidades forman el conjunto de filas, columnas y regiones
(def unidades (map set (concat
                        (for [c columnas] (ProdCruz filas [c]))         ; Columnas: (A1, B1, ...), (A2, B2, ...), ...
                        (for [f filas] (ProdCruz [f] columnas))         ; Filas: (A1, A2, ...), (B1, B2, ...), ...
                        (for [fs filasRegion
                              cs columnasRegion] (ProdCruz fs cs)))))   ; Regiones: (A1, B1, C1, A2, ..., C3), ...

(def test1 (for [c columnas] (ProdCruz filas [c])))
(def test2 (for [f filas] (ProdCruz [f] columnas)))
(def test3 (for [fs filasRegion cs columnasRegion] (ProdCruz fs cs)))

(println test1)