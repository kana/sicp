(load "./sec-3.5.scm")

;;; Exercise 3.56.  A famous problem, first raised by R. Hamming, is to
;;; enumerate, in ascending order with no repetitions, all positive integers
;;; with no prime factors other than 2, 3, or 5. One obvious way to do this is
;;; to simply test each integer in turn to see whether it has any factors other
;;; than 2, 3, and 5. But this is very inefficient, since, as the integers get
;;; larger, fewer and fewer of them fit the requirement. As an alternative, let
;;; us call the required stream of numbers S and notice the following facts
;;; about it.
;;;
;;; * S begins with 1.
;;; * The elements of (scale-stream S 2) are also elements of S.
;;; * The same is true for (scale-stream S 3) and (scale-stream 5 S).
;;; * These are all the elements of S.
;;;
;;; Now all we have to do is combine elements from these sources. For this we
;;; define a procedure merge that combines two ordered streams into one ordered
;;; result stream, eliminating repetitions:

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))

;;; Then the required stream may be constructed with merge, as follows:
;;;
;;;     (define S (cons-stream 1 (merge <??> <??>)))
;;;
;;; Fill in the missing expressions in the places marked <??> above.

(define S (cons-stream 1 (merge (merge (scale-stream integers 2)
                                       (scale-stream integers 3))
                                (scale-stream integers 5))))

(do ((i 0 (+ i 1)))
  ((= i 30))
  (print (stream-ref S i)))
