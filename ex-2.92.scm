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


; TODO: Support addition and multiplication of numbers and polynomials.

; TODO: Redefine add-poly and mul-poly to support polynomials in different
;       variables.
