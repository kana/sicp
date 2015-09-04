;;; Exercise 4.35.  Write a procedure an-integer-between that returns an
;;; integer between two given bounds. This can be used to implement a procedure
;;; that finds Pythagorean triples, i.e., triples of integers (i,j,k) between
;;; the given bounds such that i < j and i^2 + j^2 = k^2, as follows:
;;;
;;; (define (a-pythagorean-triple-between low high)
;;;   (let ((i (an-integer-between low high)))
;;;     (let ((j (an-integer-between i high)))
;;;       (let ((k (an-integer-between j high)))
;;;         (require (= (+ (* i i) (* j j)) (* k k)))
;;;         (list i j k)))))

(define (an-integer-between i j)
  (require (<= i j))
  (amb i (an-integer-between (+ i 1) j)))
