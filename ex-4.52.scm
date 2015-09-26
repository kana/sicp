;;; Exercise 4.52.  Implement a new construct called if-fail that permits the
;;; user to catch the failure of an expression. If-fail takes two expressions.
;;; It evaluates the first expression as usual and returns as usual if the
;;; evaluation succeeds. If the evaluation fails, however, the value of the
;;; second expression is returned, as in the following example:
;;;
;;;     ;;; Amb-Eval input:
;;;     (if-fail (let ((x (an-element-of '(1 3 5))))
;;;                (require (even? x))
;;;                x)
;;;              'all-odd)
;;;     ;;; Starting a new problem
;;;     ;;; Amb-Eval value:
;;;     all-odd
;;;     ;;; Amb-Eval input:
;;;     (if-fail (let ((x (an-element-of '(1 3 5 8))))
;;;                (require (even? x))
;;;                x)
;;;              'all-odd)
;;;     ;;; Starting a new problem
;;;     ;;; Amb-Eval value:
;;;     8

(require "./sec-4.3.3.scm")

(define if-normal? if?)
(define (if-fail? exp)
  (tagged-list? exp 'if-fail))
(define (if? exp)
  (or (if-normal? exp)
      (if-fail? exp)))

(define analyze-if-normal analyze-if)
(define (analyze-if-fail exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp))))
    (lambda (env succeed fail)
      (pproc env
             (lambda (value fail2)
               (succeed value fail2))
             (lambda ()
               (cproc env succeed fail))))))
(define (analyze-if exp)
  (cond ((if-normal? exp)
         (analyze-if-normal exp))
        ((if-fail? exp)
         (analyze-if-fail exp))
        (else
          (error "Unknown type of if" exp))))

(define (main args)
  (ambtest `(begin

              (define (an-element-of items)
                (require (not (null? items)))
                (amb (car items) (an-element-of (cdr items))))

              (define (test numbers)
                (print "Numbers = " numbers)
                (print (if-fail (let ((x (an-element-of numbers)))
                                  (require (even? x))
                                  x)
                                'all-odd)))

              (test '(1 3 5))

              ))

  (ambtest `(begin

              (test '(1 3 5 8))

              ))

  (ambtest `(begin

              (test '(10 20 30))

              ))
  )
