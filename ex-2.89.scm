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
  (make-term
    (- (length term-as-term-list) 1)
    (car term-as-term-list)))
(define (first-term term-list) (translate-into-term term-list))
(define (rest-terms term-list) (cdr term-list))

;; adjoin-term is not tricky except it has to fill zeros if necessary.
(define (adjoin-term term term-list)
  (define (pad-zeros tl n)
    (if (= n 0)
      tl
      (pad-zeros (cons 0 tl) (- n 1))))
  (if (=zero? (coeff term))
    term-list
    (let* ([new-order (order term)]
           [first-order (order (first-term term-list))]
           [order-diff (- new-order first-order)])
      (if (<= 1 order-diff)
        (cons (coeff term) (pad-zeros term-list (- order-diff 1)))
        (error "The order of TERM must be greater than all terms in TERM-LIST")]))))
