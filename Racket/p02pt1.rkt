#lang racket

(define (pulgadas X) (/ X 2.54))
(define (pie X) (/ (pulgadas X) 12))
(define (yardas X) (/ (pie X) 3))

(define (convertir X)
  (list (pulgadas X) (pie X) (yardas X)))


;;; PARTE I: DECISIONES ;;;

; 1. Definir un predicado que acepta un número y devuelve T si ese número es par

; Función auxiliar
(define (divisible? dividendo divisor)
  (if (equal? 0 (remainder dividendo divisor))
      #t
      #f))

(define (par? num)
  (divisible? num 2))


; 2. Definir un predicado que acepta un número y devuelve T si ese número es divisible por seis.

(define (divisiblePorSeis? num)
  (and (divisible? num 3) (divisible? num 2)))

; 3. Definir un predicado que acepta un número real y devuelve T si ese número pertenece al intervalo [0,1].

(define (perteneceIntervalo01 num)
  (and (>= num 0) (<= num 1)))

; 4. Definir una función para aceptar dos números y devolver el mayor

(define (mayor a b)
  (if (>= a b)
      a
      b))

; 5. Definir un predicado que acepta dos números y devuelve T si el segundo es múltiplo del primero.

(define (multiplo? a b)
  (divisible? b a))

; 6. Definir un predicado que acepta dos números y devuelve T si el segundo es múltiplo del primero o viceversa.

(define (multiplos? a b)
  (or (multiplo? a b) (multiplo? b a)))

; 7. En un grupo de tres personas hay un joven y dos adultos. Construir una función para ingresarle las tres edades y devuelva la edad del joven.

(define (menor e1 e2 e3)
  (if (and (<= e1 e2) (<= e1 e3))
      e1
      (if (and (<= e2 e1) (<= e2 e3))
          e2
          e3)))

; 8. Escribir una función que acepte tres números y devuelva la diferencia entre el mayor y el menor

; Función auxiliar
(define (mayorDe3 a b c)
  (mayor (mayor a b) (mayor b c)))

(define (difMayorMenor a b c)
  (-  (mayorDe3 a b c) (menor a b c)))

; 9. Escribir un predicado que acepta tres números y devuelve T si dos de ellos son iguales.

(define (dosIguales? a b c)
  (or (equal? a b) (equal? a c) (equal? b c)))

; 10. Eficiencia de la máquina

(define (calcularEficiencia pProd pDef)
  (cond ((and (>= pProd 1000) (<= pDef 20))
         printf "Puntaje 4")
        ((>= pProd 1000)
         printf "Puntaje 3")
        ((<= pDef 20)
         printf "Puntaje 2")
        (else
         printf "Puntaje 1")))


; 11. Desarrollar una función que acepte las longitudes de tres segmentos, y que devuelva
; T si forman triángulo. Recordar que la suma de las longitudes dos lados cualesquiera
; de un triángulo siempre debe ser mayor que la longitud del restante.

(define (esTriangulo? ls1 ls2 ls3)
  (and (> (+ ls1 ls2) ls3)
       (> (+ ls2 ls3) ls1)
       (> (+ ls1 ls3) ls2)))


; 12. Suponiendo los días de la semana numerados como domingo:1, lunes:2, etc.,
; aceptar un número entre 1 y 7 y devolver el día de la semana correspondiente.

(define (diaSemana num)
  (cond
    ((equal? num 1)
     printf "Domingo")
    ((equal? num 2)
     printf "Lunes")
    ((equal? num 3)
     printf "Martes")
    ((equal? num 4)
     printf "Miércoles")
    ((equal? num 5)
     printf "Jueves")
    ((equal? num 6)
     printf "Viernes")
    ((equal? num 7)
     printf "Sábado")
    (else
     printf "Número inválido")))

; 13. Tanque de agua.

(define (tanque capacidadTotal entrada salida estadoInicial)
  (if
   (> entrada salida)
   (/ (- capacidadTotal estadoInicial) (- entrada salida)) ; Se está llenando
   (/ estadoInicial (- salida entrada)))) ; Se está vaciando
   


; 14. Función que acepta un número que representa un año, y devuelve T si
; ese año es bisiesto. ; Un año es bisiesto si es divisible por 4, pero no
; es divisible por 100, salvo que sea divisible por 400.
      
(define (bisiesto? año)
  (and
   (divisible? año 4)
   (or
    (not (divisible? año 100))
    (and (divisible? año 100) (divisible? año 400)))))




