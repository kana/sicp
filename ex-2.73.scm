;;; Exercise 2.73.
;;;
;;; Section 2.3.2 described a program that performs symbolic differentiation:
;;;
;;;     (define (deriv exp var)
;;;       (cond ((number? exp) 0)
;;;             ((variable? exp) (if (same-variable? exp var) 1 0))
;;;             ((sum? exp)
;;;              (make-sum (deriv (addend exp) var)
;;;                        (deriv (augend exp) var)))
;;;             ((product? exp)
;;;              (make-sum
;;;                (make-product (multiplier exp)
;;;                              (deriv (multiplicand exp) var))
;;;                (make-product (deriv (multiplier exp) var)
;;;                              (multiplicand exp))))
;;;             <more rules can be added here>
;;;             (else (error "unknown expression type -- DERIV" exp))))
;;;
;;; We can regard this program as performing a dispatch on the type of the
;;; expression to be differentiated. In this situation the ``type tag'' of the
;;; datum is the algebraic operator symbol (such as +) and the operation being
;;; performed is deriv. We can transform this program into data-directed style
;;; by rewriting the basic derivative procedure as

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;;; a.  Explain what was done above.

; In the old DERIV, the rules to differentiate expressions are hardcoded.  The
; hardcoded rules are replaced in the new DERIV by using GET to an appropriate
; procedure to differentiate an expression.

;;; Why can't we assimilate the predicates number? and same-variable? into the
;;; data-directed dispatch?

; Because numbers and variables are represented by numbers and symbols, in
; other words, atoms.  And it's not possible to attach tags to atoms.
;
; But if we change the representations of numbers and variables to use tagged
; lists such as (number 123) and (variable x), it's possible to assimilate all
; rules into the data-directed dispatch.

;;; b.  Write the procedures for derivatives of sums and products, and the
;;; auxiliary code required to install them in the table used by the program
;;; above.

(define (=number? exp num)
  (and (number? exp)
       (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (install-sum-package)
  ;; internal procedures
  (define (deriv-sum operands var)
    (make-sum (deriv (addend operands) var)
              (deriv (augend operands) var)))
  (define (addend operands)
    (car operands))
  (define (augend operands)
    (cadr operands))
  ;; interface to the rest of the system
  (put 'deriv '+ deriv-sum)
  'done)

(define (install-product-package)
  ;; internal procedures
  (define (deriv-product operands var)
    (make-sum
      (make-product (multiplier operands)
                    (deriv (multiplicand operands) var))
      (make-product (deriv (multiplier operands) var)
                    (multiplicand operands))))
  (define (multiplier operands)
    (car operands))
  (define (multiplicand operands)
    (cadr operands))
  ;; interface to the rest of the system
  (put 'deriv '* deriv-product)
  'done)

;;; c.  Choose any additional differentiation rule that you like, such as the
;;; one for exponents (exercise 2.56), and install it in this data-directed
;;; system.

(define (make-exponentation base exponent)
  (cond
    ((=number? base 0) 0)
    ((=number? base 1) 1)
    ((=number? exponent 0) 1)
    ((=number? exponent 1) base)
    ((and (number? base) (number? exponent)) (expt base exponent))
    (else (list '** base exponent))))

(define (install-exponentation-package)
  ;; internal procedures
  (define (deriv-exponentation operands var)
    (make-product
      (make-product
        (exponent exp)
        (make-exponentation (base exp) (- (exponent exp) 1)))
      (deriv (base exp) var)))
  (define (base operands)
    (car operands))
  (define (exponent operands)
    (cadr operands))
  ;; interface to the rest of the system
  (put 'deriv '** deriv-exponentation)
  'done)

;;; d.  In this simple algebraic manipulator the type of an expression is the
;;; algebraic operator that binds it together. Suppose, however, we indexed the
;;; procedures in the opposite way, so that the dispatch line in deriv looked
;;; like
;;;
;;;     ((get (operator exp) 'deriv) (operands exp) var)
;;;
;;; What corresponding changes to the derivative system are required?

; We have to change the code to install procedures to differentiate various
; expressions such as sums and products.  Before the change on use of GET, the
; installation code looks like:
;
;     (put 'deriv '+ deriv-sum)
;
; After the change, the installation code looks like:
;
;     (put '+ 'deriv deriv-sum)
