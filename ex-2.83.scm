;;; Exercise 2.83.  Suppose you are designing a generic arithmetic system for
;;; dealing with the tower of types shown in figure 2.25: integer, rational,
;;; real, complex. For each type (except complex), design a procedure that
;;; raises objects of that type one level in the tower. Show how to install
;;; a generic raise operation that will work for each type (except complex).

(define (raise number)
  (apply-generic 'raise number))

(put 'raise '(integer)
     (lambda (n) (make-rational n 1)))

(put 'raise '(rational)
     (lambda (q) (attach-tag 'real (/ (numer q) (denom q)))))

(put 'raise '(real)
     (lambda (r) (make-complex-from-real-imag r 0)))
