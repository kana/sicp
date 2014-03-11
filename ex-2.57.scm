(load "./ex-2.56.scm")

(define (augend s)
  (let ((rest (cddr s)))
    (if (null? (cdr rest))
      (car rest)
      (cons '+ rest))))

(define (multiplicand p)
  (let ((rest (cddr p)))
    (if (null? (cdr rest))
      (car rest)
      (cons '* rest))))
