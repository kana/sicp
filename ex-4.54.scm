;;; Exercise 4.54.  If we had not realized that `require` could be implemented
;;; as an ordinary procedure that uses `amb`, to be defined by the user as part
;;; of a nondeterministic program, we would have had to implement it as
;;; a special form. This would require syntax procedures
;;;
;;;     (define (require? exp) (tagged-list? exp 'require))
;;;
;;;     (define (require-predicate exp) (cadr exp))
;;;
;;; and a new clause in the dispatch in `analyze`
;;;
;;;     ((require? exp) (analyze-require exp))
;;;
;;; as well the procedure `analyze-require` that handles require expressions.
;;; Complete the following definition of `analyze-require`.
;;;
;;;     (define (analyze-require exp)
;;;       (let ((pproc (analyze (require-predicate exp))))
;;;         (lambda (env succeed fail)
;;;           (pproc env
;;;                  (lambda (pred-value fail2)
;;;                    (if <??>
;;;                        <??>
;;;                        (succeed 'ok fail2)))
;;;                  fail))))

(load "./sec-4.3.3.scm")

(define (require? exp) (tagged-list? exp 'require))
(define (require-predicate exp) (cadr exp))

(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp)))
        ((let*? exp) (analyze (let*->let exp)))
        ((and? exp) (analyze (and->if exp)))
        ((amb? exp) (analyze-amb exp))
        ((require? exp) (analyze-require exp))  ; **changed**
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

(define (analyze-require exp)
  (let ((pproc (analyze (require-predicate exp))))
    (lambda (env succeed fail)
      (pproc env
             (lambda (pred-value fail2)
               (if (not (true? pred-value))
                 fail2
                 (succeed 'ok fail2)))
             fail))))

(ambtest
  '(begin

     (define (an-integer-between i j)
       (require (<= i j))
       (amb i (an-integer-between (+ i 1) j)))

     (let ((k (an-integer-between 13 19)))
       (print "k = " k))

     ))
