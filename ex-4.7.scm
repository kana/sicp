;;; Exercise 4.7.  Let* is similar to let, except that the bindings of the let
;;; variables are performed sequentially from left to right, and each binding
;;; is made in an environment in which all of the preceding bindings are
;;; visible. For example
;;;
;;;     (let* ((x 3)
;;;            (y (+ x 2))
;;;            (z (+ x y 5)))
;;;       (* x z))
;;;
;;; returns 39.


;;; Explain how a let* expression can be rewritten as a set of nested let
;;; expressions,

; The example code can be rewritten as follows:

(let ((x 3))
  (let ((y (+ y 2)))
    (let ((z (+ x y 5)))
      (* x z))))


;;; and write a procedure let*->nested-lets that performs this transformation.

(require "./ex-4.6.scm")

(define (let*->nested-lets exp)
  (define (go clauses)
    (if (null? clauses)
      (let-body expr)
      (list 'let (list (list (let-clause-var (car clauses))
                             (let-clause-value-exp (car clauses))))
            (go (cdr clauses)))))
  (go (let-clauses exp)))


;;; If we have already implemented let (exercise 4.6) and we want to extend the
;;; evaluator to handle let*, is it sufficient to add a clause to eval whose
;;; action is
;;;
;;;     (eval (let*->nested-lets exp) env)
;;;
;;; or must we explicitly expand let* in terms of non-derived expressions?

; Our eval can handle LET as if it is a non-derived expression.  So that the
; above action is sufficient to support LET*.
