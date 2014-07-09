;;; Exercise 2.79.  Define a generic equality predicate equ? that tests the
;;; equality of two numbers, and install it in the generic arithmetic package.
;;; This operation should work for ordinary numbers, rational numbers, and
;;; complex numbers.

(define (equ? x y)
  (apply-generic 'equ? x y))

(put 'equ? '(scheme-number scheme-number)
     =)
(put 'equ? '(rational rational)
     equal?)
(put 'equ? '(complex complex)
     (lambda (z1 z2)
       (and (= (real-part z1) (real-part z2))
            (= (imag-part z1) (imag-part z2)))))
