;;; Exercise 2.92.  By imposing an ordering on variables, extend the polynomial
;;; package so that addition and multiplication of polynomials works for
;;; polynomials in different variables. (This is not easy!)

;; Assumptions to solve this exercise:
;;
;; (a) Variables are compared in dictionary order.
;;     For example, x is "smaller" than y, and z is "greater" than x.
;;
;; (b) "Greater" variables are put into coefficients.
;;     For example, a single-term polynomial 4xy is structured as follows:
;;
;;     (make-poly 'x (adjoin-term (make-term 1 (make-poly 'y '((1 4))))
;;                                (the-empty-termlist)))
;;
;; (c) The order of variables in resulting polynomials are always sorted in
;;     dictionary order.  For example,
;;
;;     (define px (make-poly 'x '(1 2)))
;;     (define py (make-poly 'y '(1 3)))
;;     (define pxy (mul-poly px py))
;;     (define pyx (mul-poly py px))
;;
;;     Both pxy and pyx are structured as follows:
;;
;;     (make-poly 'x (adjoin-term (make-term 1 (make-poly 'y '((1 6))))
;;                                (the-empty-termlist)))

(define (variable<? v1 v2)
  (string<? (symbol->string v1) (symbol->string v2)))

(define (variable>? v1 v2)
  (variable<? v2 v1))


;; Suppose that we want to calculate 2x * 3y in our system.  First of all, we
;; have to "normalize" polynomials to ensure that both polynomials have the
;; same "type".  In this case, we have to "normalize" 3y as a polynomial in x,
;; that is, 3 y x^0.  After this "normalization", the steps to multiply
;; polynomials are the same as multiplication of polynomials in the same
;; variable.
;;
;; But there is a pitfall.  The coefficient of 2x is a plain number 2, while
;; the coefficient of 3 y x^0 is a polynomial 3y.  Polynomial multiplication
;; involves multiplication of coefficients.  So that we have to support
;; multiplication of numbers and polynomials.  The same can be said for
;; addition of polynomials in different variables.

(put 'add '(complex polynomial)
     (lambda (z p)
       (add-poly (make-poly (variable p)
                            (adjoin-term (make-term 0 z) (the-empty-termlist)))
                 p)))
(put 'add '(polynomial complex)
     (lambda (p z)
       (add z p)))

; TODO: Redefine add-poly and mul-poly to support polynomials in different
;       variables.
