#lang racket
(require racket/trace)	

; 1. Factorial

; Recursión clásica
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

; Versión con recursión de cola (no apila registros en el stack)
(define (tail-factorial n [acc 1])
  (if (= n 0)
      acc
      (tail-factorial (- n 1) (* n acc))))

; 2. Potencia con exponente natural

(define (potencia m n)
  (if (= n 0)
      1
      (* m (potencia m (- n 1)))))

(define (tail-potencia m n [acc 1])
  (if (= n 0)
      acc
      (tail-potencia m (- n 1) (* m acc))))

; 3. Máximo común divisor

(define (mayor a b)
  (if (> a b)
      a
      b))

(define (menor a b)
  (if (< a b)
      a
      b))

(define (mcd a b)
  (if (= a b)
      a
      (mcd (menor a b) (- (mayor a b) (menor a b)))))

; 4. Fibonacci

(define (fibo n)
  (if (= n 0)
      0
      (if (= n 1)
          1
          (+ (fibo (- n 1)) (fibo (- n 2))))))

(define (tail-fibo n [a 0] [b 1])
  (if (= n 0)
      a
      (if (= n 1)
          b
          (tail-fibo (- n 1) b (+ a b)))))

; 5. Números primos

(define (divisor? n c)
  (if (= 0 (remainder n c))
      #t
      "NIL"))

; Teorema de Wilson para verificar si es primo
(define (primo? n)
  (divisor? (+ (tail-factorial(- n 1)) 1) n))

; 6. Escribir un predicado que acepte un elemento y una lista,
; y devuelva T si el elemento pertenece a la lista.

(define (pertenece? lista ele)
  (if (empty? lista)
      #f
      (if (equal? (first lista) ele)
          #t
          (pertenece? (rest lista) ele))))

; 7. Escribir una función que acepte una lista y devuelva su cant. de elementos.

(define (cantEle lista [cont 0])
  (if (empty? lista)
      cont
      (cantEle (rest lista) (+ cont 1))))

; 8. Escribir una función que acepte una lista numérica y devuelva la sumatoria de la misma.

(define (sumatoria lista [cont 0])
  (if (empty? lista)
      cont
      (sumatoria (rest lista) (+ cont (first lista)))))

; 9. Escribir una función que acepte una lista de números enteros y devuelva
; la cantidad de números naturales que contiene la lista.

(define (entero? n)
  (and (integer? n) (positive? n)))

(define (cantNaturales lista)
  (cantEle (filter entero? lista)))

; 10. Escribir una función "estaentre", que acepta dos números enteros "m" y "n", y
; devuelve la lista de los enteros mayores o iguales que "m" y menores o iguales que "n".

(define (entre m n [lista empty])
  (if (equal? m (+ n 1))
      lista
      (entre (+ m 1) n (append lista (list m)))))
      

; 11. Definir una función que acepta una lista y devuelve el último elemento de la misma.

(define (ultimo? lista)
  (if (equal? (rest lista) null)
      (first lista)
      (ultimo? (rest lista))))

; 12. Definir una función que acepte dos listas y devuelva
; una lista que sea la concatenación de las mismas.

(define (concat lista1 lista2)
  (append lista1 lista2))


; 13. Definir una función que acepta una lista y dos átomos "a" y "b",
; y devuelve otra lista con los elementos de la primera, pero con el átomo
; "a" sustituido por el "b", en su primer ocurrencia.

(define (reemplazar lista a b)
  (list-set lista (index-of lista a) b))
  

; 14. Escribir una función que acepta dos átomos A y B y una lista C, y
; devuelve una lista D, tal que D es igual a C, pero con el átomo A sustituido
; por el B, en todas sus ocurrencias.

(define (reemplazarTodos lista a b)
  (if (pertenece? lista a)
      (reemplazarTodos (reemplazar lista a b) a b)
      lista))

