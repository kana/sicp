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

; This apply-generic tries raising the leftmost argument with the lowest type
; if an appropriate procedure is not found.
;
; But this strategy has a problem  If a generic operation foo is defined only
; for (integer rational) and foo is called with two integers, this strategy
; tries looking up many versions of foo in the following order:
;
; (1) (integer integer)
; (2) (rational integer)
; (3) (rational rational)
; (4) (real rational)
; (5) (real real)
; (6) (complex real)
; (7) (complex complex)
;
; So that the (integer rational) version will never be tried.  If generic
; operations take 3 or more arguments, similar problems will frequently happen.
; To avoid this problem, we have to try every combination of raised arguments.

(define (apply-generic op . args)
  (define (raise-one-level args)
    (let go ([rest args])
      (if (null? rest)
         (error "No method for these types"
                (list op types))
         (let ([a0 (car rest)])
           (if (and (supertype a0)
                    (every (lambda (a) (type<=? (type-tag a0) (type-tag a)))
                           args))
             (cons (raise a0) (cdr rest))
             (cons a0 (go (cdr rest)))))))
  (let* ([types (map type-tag args)]
         [proc (get op types)])
    (if proc
      (apply proc (map contents args))
      (apply apply-generic op (raise-one-level args)))))
