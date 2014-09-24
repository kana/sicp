;;; Exercise 3.1.  An accumulator is a procedure that is called repeatedly with
;;; a single numeric argument and accumulates its arguments into a sum. Each
;;; time it is called, it returns the currently accumulated sum. Write
;;; a procedure make-accumulator that generates accumulators, each maintaining
;;; an independent sum. The input to make-accumulator should specify the
;;; initial value of the sum; for example
;;;
;;; (define A (make-accumulator 5))
;;; (A 10)
;;; 15
;;; (A 10)
;;; 25

(define (make-accumulator sum)
  (lambda (n)
    (set! sum (+ sum n))
    sum))

(define A1 (make-accumulator 10))
(define A2 (make-accumulator 3))

(print (A1 8))
;=> 18

(print (A2 8))
;=> 11

(print (A1 4))
;=> 22

(print (A2 4))
;=> 15
