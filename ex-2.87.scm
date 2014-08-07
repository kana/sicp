;;; Exercise 2.87.  Install =zero? for polynomials in the generic arithmetic
;;; package. This will allow adjoin-term to work for polynomials with
;;; coefficients that are themselves polynomials.

; Since our representation of term list is a list of nonzero terms.
; So that the zero polynomial is represented as the empty list.
(put '=zero? 'polynomial
     empty-termlist?)
