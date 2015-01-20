;;; Exercise 3.69.  Write a procedure triples that takes three infinite
;;; streams, S, T, and U, and produces the stream of triples (Si,Tj,Uk) such
;;; that i < j < k. Use triples to generate the stream of all Pythagorean
;;; triples of positive integers, i.e., the triples (i,j,k) such that i < j and
;;; i^2 + j^2 = k^2.

(load "./sec-3.5.scm")

; (1 1 1) + (1 1 z) + (1 y z) + (x y z)
(define (triples s t u)
  (cons-stream
   (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
     (stream-map (lambda (uk) (list (stream-car s) (stream-car t) uk))
                 (stream-cdr u))
     (interleave
      (stream-map (lambda (tjuk) (cons (stream-car s) tjuk))
                  (pairs (stream-cdr t) (stream-cdr u)))
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u))))))

(define (pythagorean-triples)
  (define (square x) (* x x))
  (stream-filter (lambda (ns)
                   (= (+ (square (car ns)) (square (cadr ns)))
                      (square (caddr ns))))
                 (triples integers integers integers)))

; (define s (triples integers integers integers))
(define s (pythagorean-triples))
(do ([i 0 (+ i 1)]
     [s (pythagorean-triples) (stream-cdr s)])
  ((= i 3))
  (print (stream-car s)))
