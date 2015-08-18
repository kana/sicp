;;; Exercise 4.27.  Suppose we type in the following definitions to the lazy
;;; evaluator:
;;;
;;;     (define count 0)
;;;     (define (id x)
;;;       (set! count (+ count 1))
;;;       x)
;;;
;;; Give the missing values in the following sequence of interactions, and
;;; explain your answers. [38]
;;;
;;;     (define w (id (id 10)))
;;;     ;;; L-Eval input:
;;;     count
;;;     ;;; L-Eval value:
;;;     <response>
;;;     ;;; L-Eval input:
;;;     w
;;;     ;;; L-Eval value:
;;;     <response>
;;;     ;;; L-Eval input:
;;;     count
;;;     ;;; L-Eval value:
;;;     <response>

; The first <response> is 1.  The outer call of id is already evaluated at that
; moment, but the inner call of id is delayed and it is not forced yet.
;
; The second <response> is 10.  id returns the given argument as is.  So that
; (id 10) returns 10, and (id (id 10)) returns 10 too.
;
; The third <response> is 2.  w is bound to the result of (id 10), and it is
; already forced to print the actual value of w.


(load "./sec-4.1.1.scm")
(load "./sec-4.1.2.scm")
(load "./sec-4.1.3.scm")
(load "./sec-4.1.4.scm")
(load "./sec-4.2.2.scm")

(for-each
  (lambda (expr)
    (print expr)
    (print "==> " (actual-value expr the-global-environment)))
  '((define count 0)
    (define (id x)
      (set! count (+ count 1))
      x)
    (define w (id (id 10)))
    count
    w
    count
    ; (define (unless p t e)
    ;   (if p e t))
    ; (unless true (+ 'a 'b) (+ 1 2))
    ))
