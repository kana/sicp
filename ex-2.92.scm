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
;;
;; A simple solution is to put variations of ADD and MUL for each combination
;; of polynomial and non-polynomial types.  But there are many combinations to
;; be put, so that it is not additive.
;;
;; Therefore, here we assume that polynomial is a supertype of complex.  With
;; this assumption, there is no need to put variations of ADD and MUL.  Numbers
;; are automatically coerced by apply-generic and results are automatically
;; simplified.

(load "./ex-2.85.scm")

(put 'raise (complex)
     (lambda (z)
       (make-poly 'fallback-variable
                  (adjoin-term (make-term 0 z) (the-empty-termlist))))

(put 'supertype 'complex 'poly)

(put 'project (poly)
     (lambda (p)
       (coeff (first-term p))))


;; Finally, we can redefine add-poly and mul-poly to support polynomials in
;; different variables.

(define (add-poly p1 p2)
  (let ([v1 (variable p1)]
        [v2 (variable p2)])
    (cond [(variable<? v1 v2)
           (add-poly
             p1
             (make-poly v1
                        (adjoin-term (make-term 0 p2) (the-empty-termlist))))]
          [(variable>? v1 v2)
           (add-poly p2 p1)]
          [else
            (make-poly v1
                       (add-terms (term-list p1)
                                  (term-list p2)))])))

(define (mul-poly p1 p2)
  (let ([v1 (variable p1)]
        [v2 (variable p2)])
    (cond [(variable<? v1 v2)
           (mul-poly
             p1
             (make-poly v1
                        (adjoin-term (make-term 0 p2) (the-empty-termlist))))]
          [(variable>? v1 v2)
           (mul-poly p2 p1)]
          [else
            (make-poly v1
                       (mul-terms (term-list p1)
                                  (term-list p2)))])))
