;;; Exercise 3.2.  In software-testing applications, it is useful to be able to
;;; count the number of times a given procedure is called during the course of
;;; a computation. Write a procedure make-monitored that takes as input
;;; a procedure, f, that itself takes one input. The result returned by
;;; make-monitored is a third procedure, say mf, that keeps track of the number
;;; of times it has been called by maintaining an internal counter. If the
;;; input to mf is the special symbol how-many-calls?, then mf returns the
;;; value of the counter. If the input is the special symbol reset-count, then
;;; mf resets the counter to zero. For any other input, mf returns the result
;;; of calling f on that input and increments the counter. For instance, we
;;; could make a monitored version of the sqrt procedure:
;;;
;;; (define s (make-monitored sqrt))
;;;
;;; (s 100)
;;; 10
;;;
;;; (s 'how-many-calls?)
;;; 1

(define (make-monitored f)
  (let ([called-count 0])
    (lambda (x)
      (cond
        [(eq? x 'how-many-calls?)
         called-count]
        [(eq? x 'reset-count)
         (set! called-count 0)]
        [else
          (set! called-count (+ called-count 1))
          (f x)]))))


(define s (make-monitored sqrt))

(print (s 'how-many-calls?))
;=> 0

(print (s 100))
;=> 10

(print (s 16))
;=> 4

(print (s 'how-many-calls?))
;=> 2

(s 'reset-count)
(print (s 'how-many-calls?))
;=> 0
