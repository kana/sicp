;;; Exercise 4.33.  Ben Bitdiddle tests the lazy list implementation given
;;; above by evaluating the expression
;;;
;;;     (car '(a b c))
;;;
;;; To his surprise, this produces an error. After some thought, he realizes
;;; that the ``lists'' obtained by reading in quoted expressions are different
;;; from the lists manipulated by the new definitions of cons, car, and cdr.
;;; Modify the evaluator's treatment of quoted expressions so that quoted lists
;;; typed at the driver loop will produce true lazy lists.

(load "./sec-4.1.1.scm")
(load "./sec-4.1.2.scm")
(load "./sec-4.1.3.scm")
(load "./sec-4.1.4.scm")
(load "./sec-4.2.2.scm")

(define (text-of-quotation exp)
  (let go ((raw-value (cadr exp)))
    (cond ((null? raw-value)
           '())
          ((pair? raw-value)
           (%eval `(cons ',(car raw-value) ',(go (cdr raw-value)))
                  the-global-environment  ; Dirty.
                  ))
          (else
            raw-value))))

(define code
  '((define (cons x y)
      (lambda (m) (m x y)))
    (define (car z)
      (z (lambda (p q) p)))
    (define (cdr z)
      (z (lambda (p q) q)))
    (car '(a b c))
    ))

(define (main args)
  (for-each
    (lambda (expr)
      (print expr)
      (print "==> " (actual-value expr the-global-environment)))
    code))
