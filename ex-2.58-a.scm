(load "./ex-2.57.scm")

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (sum? x)
  (and (pair? x)
       (pair? (cdr x))
       (eq? (cadr x) '+)))

(define (addend s)
  (car s))

(define (augend s)
  (caddr s))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (product? x)
  (and (pair? x)
       (pair? (cdr x))
       (eq? (cadr x) '*)))

(define (multiplier p)
  (car p))

(define (multiplicand p)
  (caddr p))

(define (make-exponentation base exponent)
  (cond
    ((=number? base 0) 0)
    ((=number? base 1) 1)
    ((=number? exponent 0) 1)
    ((=number? exponent 1) base)
    ((and (number? base) (number? exponent)) (expt base exponent))
    (else (list base '** exponent))))

(define (exponentation? x)
  (and (pair? x)
       (pair? (cdr x))
       (eq? (cadr x) '**)))

(define (base e)
  (car e))

(define (exponent e)
  (caddr e))
