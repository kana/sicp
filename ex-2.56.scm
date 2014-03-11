(load "./sec-2.3.2-v2.scm")

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentation? exp)
         (make-product
           (make-product
             (exponent exp)
             (make-exponentation (base exp) (- (exponent exp) 1)))
           (deriv (base exp) var)))
        (else
          (error "unknown expression type -- DERIV" exp))))

(define (make-exponentation base exponent)
  (cond
    ((=number? base 0) 0)
    ((=number? base 1) 1)
    ((=number? exponent 0) 1)
    ((=number? exponent 1) base)
    ((and (number? base) (number? exponent)) (expt base exponent))
    (else (list '** base exponent))))

(define (exponentation? exp)
  (and (pair? exp)
       (eq? (car exp) '**)))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))
