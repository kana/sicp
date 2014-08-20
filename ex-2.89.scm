;;; Exercise 2.89.  Define procedures that implement the term-list
;;; representation described above as appropriate for dense polynomials.

(define (the-empty-termlist) '())
(define (first-term term-list) term-list)
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (%internal-term? term)
  (and (pair? term)
       (eq? (car term) 'term)))

(define (make-term order coeff)
  (list 'term order coeff))
(define (order term)
  (if (%internal-term? term)
    (cadr term)
    (- (length term) 1)))
(define (coeff term)
  (if (%internal-term? term)
    (caddr term)
    (car term)))

(define (adjoin-term term term-list)
  (let* ([new-order (order term)]
         [first-order (order (first-term term-list))]
         [order-diff (- new-order first-order)])
    (cond [(<= 2 order-diff)
           (adjoin-term term (cons 0 term-list))]
          [(= 1 order-diff)
           (cons (coeff term) term-list)]
          [else
            (error "The order of TERM must be greater than all terms in TERM-LIST")])))
