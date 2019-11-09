#lang racket

(require racket/trace)

; Parcial 1

; 1. Definir por recursión la función borra tal que (borra x xs) es la
; lista obtenida borrando una ocurrencia de x en la lista xs.

(trace-define (borra x xs)
  (cond
    ((null? xs) empty)
    ((eq? (first xs) x) (rest xs))
    (else
     (cons (first xs) (borra x (rest xs))))))

(trace-define (borra-todo x xs)
  (cond
    ((null? xs) empty)
    ((eq? (first xs) x) (borra-todo x (rest xs)))
    (else
     (cons (first xs) (borra-todo x (rest xs))))))

; 2. Definir la función mitades tal que (mitades xs) es el par formado por las dos mitades en que
; se divide xs tales que sus longitudes difieren como máximo en uno. Por ejemplo, (mitades ‘(2 3 5 7 9)) == ‘(‘(2 3) ‘(5 7 9))

