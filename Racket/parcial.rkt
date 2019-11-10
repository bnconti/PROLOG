#lang racket

(require racket/trace)

; Parcial 1

; 1. Definir por recursión la función borra tal que (borra x xs) es la
; lista obtenida borrando una ocurrencia de x en la lista xs.

(define (borra x xs)
  (cond
    ((null? xs) empty)
    ((eq? (first xs) x) (rest xs))
    (else
     (cons (first xs) (borra x (rest xs))))))

(define (borra-todo x xs)
  (cond
    ((null? xs) empty)
    ((eq? (first xs) x) (borra-todo x (rest xs)))
    (else
     (cons (first xs) (borra-todo x (rest xs))))))

; 2. Definir la función mitades tal que (mitades xs) es el par formado por las dos
; mitades en que se divide xs tales que sus longitudes difieren como máximo en uno.
; Por ejemplo, (mitades ‘(2 3 5 7 9)) == ‘(‘(2 3) ‘(5 7 9))

(define (listaDesdeHasta xs i fin)
  (if (eq? i fin)
      (list (first xs))
      (if (eq? i 1)
          (cons (first xs) (listaDesdeHasta (rest xs) i (- fin 1)))
          (listaDesdeHasta (rest xs) (- i 1) (- fin 1)))))

(define (mitad xs)
  (list (listaDesdeHasta xs 1 (quotient (length xs) 2))
        (listaDesdeHasta xs (+ 1 (quotient (length xs) 2)) (length xs))))

; 3. Dos números son equivalentes si la media de sus cifras son iguales. Por ejemplo,
; 3205 y 41 son equvalentes ya que (3+2+0+5)/4 = (4+1)/2. Definir la función tal que
; (equivalentes x y) se verifica si los números x e y son equivalentes. Por ejemplo:
; (equivalentes 3205 41) -> True
; (equivalentes 3205 25) -> False

(define (media n [sum 0] [acc 0])
  (if (= n 0)
      (/ sum acc)
      (media (quotient n 10) (+ sum (remainder n 10)) (+ acc 1))))

(define (equivalentes? a b)
  (= (media a) (media b)))

; 4. El primitivo de un número se define como sigue: Dado un número natural N, multiplicamos
; todos sus dígitos, repetimos este procedimiento hasta que quede un solo dígito al cual
; llamamos primitivo de N. Por ejemplo para 327: 3x2x7 = 42 y 4x2 = 8. Por lo tanto, el
; primitivo de 327 es 8. Definir la función (primitivo n).

(define (digitos n [prod 1])
  (if (= n 0)
      prod
      (digitos (quotient n 10) (* prod (remainder n 10)))))

(define (primitivo n)
  (if (< (digitos n) 10)
      (digitos n)
      (primitivo (digitos n))))

; Mayor elemento de la lista

(trace-define (mayor lst)
  (if (empty? (rest lst))
      (first lst)
      (if (> (first lst) (mayor (rest lst)))
          (first lst)
          (mayor (rest lst)))))

; Borrar el mayor elemento de la lista
      
(define (borrar-mayor lst)
  (borra (mayor lst) lst))

; Segundo mayor elemento de la lista

(define (segundo-mayor lst)
  (mayor (borrar-mayor lst)))

; Invertir la lista

(define (inversa lst)
  (if (empty? lst)
      lst
      (append (inversa (rest lst)) (list (first lst)))))