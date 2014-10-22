(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z3 (list 'a 'b 'c))
(define z4
  (let ([x (list 'a)])
    (list x x)))
(define z7
  (let* ([x (list 'a)]
         [y (cons x x)])
    (cons y y)))
(define z* (make-cycle (list 'a 'b 'c)))

(define (zap x)
  (with-output-to-string (lambda () (write/ss x))))
