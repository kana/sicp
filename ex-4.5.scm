;;; Exercise 4.5.  Scheme allows an additional syntax for cond clauses, (<test>
;;; => <recipient>). If <test> evaluates to a true value, then <recipient> is
;;; evaluated. Its value must be a procedure of one argument; this procedure is
;;; then invoked on the value of the <test>, and the result is returned as the
;;; value of the cond expression. For example
;;;
;;; (cond ((assoc 'b '((a 1) (b 2))) => cadr)
;;;       (else false))
;;;
;;; returns 2. Modify the handling of cond so that it supports this extended
;;; syntax.

(define (expand-clauses clauses)
  (if (null? clauses)
    'false                          ; no else clause
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (cond [(cond-else-clause? first)
             (if (null? rest)
               (sequence->exp (cond-actions first))
               (error "ELSE clause isn't last -- COND->IF"
                      clauses))]
            [(cond-extended-clause? first)
             ; CONT
             (...)]
            [else
              (make-if (cond-predicate first)
                       (sequence->exp (cond-actions first))
                       (expand-clauses rest))]))))

(define (cond-extended-clause? clause)
  (tagged-list? (cdr clause) '=>))

(define (cond-recipient clause)
  (caddr clause))
