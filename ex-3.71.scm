;;; Exercise 3.71.  Numbers that can be expressed as the sum of two cubes in
;;; more than one way are sometimes called Ramanujan numbers, in honor of the
;;; mathematician Srinivasa Ramanujan.[70] Ordered streams of pairs provide an
;;; elegant solution to the problem of computing these numbers. To find
;;; a number that can be written as the sum of two cubes in two different ways,
;;; we need only generate the stream of pairs of integers (i,j) weighted
;;; according to the sum i^3 + j^3 (see exercise 3.70), then search the stream
;;; for two consecutive pairs with the same weight. Write a procedure to
;;; generate the Ramanujan numbers. The first such number is 1,729. What are
;;; the next five?

(load "./sec-3.5.scm")
(load "./ex-3.70.scm")

(define (ramanujan-numbers)
  (define (cube x)
    (* x x x))
  (define (weight ij)
    (+ (cube (car ij))
       (cube (cadr ij))))
  (define s (weighted-pairs
              integers
              integers
              weight))
  (define (drop-unique s)
    (let go ([s s]
             [w0 0]
             [w1 (weight (stream-car s))])
      (if (= w0 w1)
        (cons-stream w1 (go (stream-cdr s) w1 (weight (stream-car (stream-cdr s)))))
        (go (stream-cdr s) w1 (weight (stream-car (stream-cdr s))))
        )))
  (drop-unique s)
  )

(define s (ramanujan-numbers))
(do ((i 0 (+ i 1)))
  ((= i 30))
  (print (stream-ref s i)))
