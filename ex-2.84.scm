;;; Exercise 2.84.  Using the raise operation of exercise 2.83, modify the
;;; apply-generic procedure so that it coerces its arguments to have the same
;;; type by the method of successive raising, as discussed in this section. You
;;; will need to devise a way to test which of two types is higher in the
;;; tower. Do this in a manner that is ``compatible'' with the rest of the
;;; system and will not lead to problems in adding new levels to the tower.

(define (supertype type)
  (get 'supertype type))

(put 'supertype 'complex #f)
(put 'supertype 'real 'complex)
(put 'supertype 'rational 'real)
(put 'supertype 'integer 'rational)

(define (supertypes type)
  (let go ([acc '()]
           [t type])
    (let ([st (supertype t)])
      (if st
        (go (cons st acc) st)
        acc))))

(define (type<=? type1 type2)
  (or (eq? type1 type2)
      (memq type2 (supertypes type1))))

; TODO: Implement a modified version of apply-generic.
