;;; Exercise 2.89.  Define procedures that implement the term-list
;;; representation described above as appropriate for dense polynomials.

;; Procedures for terms are the same as ones for the sparse representation.
(define (make-term order coeff)
  (list order coeff))
(define (order term)
  (car term))
(define (coeff term)
  (cadr term))

;; Procedures on empty term lists are the same too.
(define (the-empty-termlist) '())
(define (empty-termlist? term-list) (null? term-list))

;; But we have to take care with first-term.  Term lists in the dense
;; representation do not contain term orders explicitly.  And first-term is the
;; only one procedure to return a term from a term list.  There is a gap of
;; internal data formats between input and output of first-term.  So that we
;; have to fill the gap as follows:
(define (translate-into-term term-as-term-list)
  (list (- (length term-as-term-list) 1)
        (car term-as-term-list)))
(define (first-term term-list) (translate-into-term term-list))
(define (rest-terms term-list) (cdr term-list))

;; adjoin-term is not tricky except it has to fill zeros if necessary.
;;
;; Note that this implementation is not efficient.  Our first-term is O(N)
;; where N is the order of a given term, and adjoin-term is recursively called
;; many times depending on order-diff.  So that this adjoin-term should be
;; replaced with an optimized version if we want to make our system practical.
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
    term-list
    (let* ([new-order (order term)]
           [first-order (order (first-term term-list))]
           [order-diff (- new-order first-order)])
      (cond [(<= 2 order-diff)
             (adjoin-term term (cons 0 term-list))]
            [(= 1 order-diff)
             (cons (coeff term) term-list)]
            [else
              (error "The order of TERM must be greater than all terms in TERM-LIST")]))))
