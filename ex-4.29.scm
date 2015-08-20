;;; Exercise 4.29.  Exhibit a program that you would expect to run much more
;;; slowly without memoization than with memoization.

(define (average numbers)
  (/ (sum numbers) (length numbers)))

(define (sum numbers)
  (let go ((acc 0)
           (numbers numbers))
    (if (null? numbers)
      acc
      (go (+ acc (car numbers))
          (cdr numbers)))))

(define (sleep seconds)
  ; ...
  )

(define (list-numbers-slowly)
  (sleep 5)
  '(869 12 72 1127 197 37931 91 73 91301 1 51 11 1999))

; Delayed (list-numbers-slowly) is passed to AVERAGE, and AVERAGE uses the
; given numbers twice.  So that LIST-NUMBERS-SLOWLY is called twice.
;
; Likewise, if a procedure uses a given argument multiple times, thunks are
; evaluated that many times.
(average (list-numbers-slowly))




;;; Also, consider the following interaction, where the id procedure is defined
;;; as in exercise 4.27 and count starts at 0:
;;;
;;; (define (square x)
;;;   (* x x))
;;; ;;; L-Eval input:
;;; (square (id 10))
;;; ;;; L-Eval value:
;;; <response>
;;; ;;; L-Eval input:
;;; count
;;; ;;; L-Eval value:
;;; <response>
;;;
;;; Give the responses both when the evaluator memoizes and when it does not.

;                   | With memoization |  Without memoization
; ------------------+------------------+----------------------
; First <response>  |        100       |         100
; Second <response> |          1       |           2
;
; In SQUARE, X = delayed (id 10) is passed to *.  * is a primitive procedure,
; so that X is immediately forced.  So that the first <response> is 100 for
; both evaluators.
;
; But the second <response> is different. Because X is referred twice in
; SQUARE.  So that (id 10) is evaluated twice.

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
    (define (square x)
      (* x x))
    (square (id 10))
    count
    ))
