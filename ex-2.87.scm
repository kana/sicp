;;; Exercise 2.87.  Install =zero? for polynomials in the generic arithmetic
;;; package. This will allow adjoin-term to work for polynomials with
;;; coefficients that are themselves polynomials.

(put '=zero? 'polynomial
     (lambda (p)
       (let go ([ts (term-list p)])
         (cond [(empty-termlist? ts)
                #t]
               [(=zero? (coeff (first-term ts)))
                (go (rest-terms ts))]
               [else
                 #f]))))
