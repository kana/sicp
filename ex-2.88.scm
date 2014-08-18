;;; Exercise 2.88.  Extend the polynomial system to include subtraction of
;;; polynomials. (Hint: You may find it helpful to define a generic negation
;;; operation.)

(define (negate x)
  (apply-generic 'negate x))

(put 'negate '(integer)
     -)
(put 'negate '(rational)
     (lambda (q)
       (make-rational (- (numer q)) (denom q))))
(put 'negate '(real)
     -)
(put 'negate '(complex)
     (lambda (z)
       (make-complex-from-real-imag (negate (real-part z))
                                    (negate (imag-part z)))))

(define (negate-terms terms)
  (if (empty-termlist? terms)
    (the-empty-termlist)
    (adjoin-term
      (make-term (order (first-term terms))
                 (negate (coeff (first-term terms))))
      (negate-terms (rest-terms terms)))))
(put 'negate '(polynomial)
     (lambda (p)
       (make-poly (variable p) (negate-terms (term-list p)))))

; TODO: Define sub-poly
