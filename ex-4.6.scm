;;; Exercise 4.6.  Let expressions are derived expressions, because
;;;
;;;     (let ((<var1> <exp1>) ... (<varn> <expn>))
;;;       <body>)
;;;
;;; is equivalent to
;;;
;;;     ((lambda (<var1> ... <varn>)
;;;        <body>)
;;;      <exp1>
;;;        :
;;;      <expn>)
;;;
;;; Implement a syntactic transformation let->combination that reduces
;;; evaluating let expressions to evaluating combinations of the type shown
;;; above, and add the appropriate clause to eval to handle let expressions.

(define (let->combination let-exp)
  (define vars (map let-clause-var (let-clauses let-exp)))
  (define value-exps (map let-clause-value-exp (let-clauses let-exp)))
  (cons
    (make-lambda vars (let-body let-exp))
    value-exps))

(define (let? exp)
  (tagged-list? exp 'let))

(define (let-clauses exp)
  (cadr exp))

(define (let-clause-var clause)
  (car clause))

(define (let-clause-value-exp clause)
  (cadr clause))

(define (let-body exp)
  (cddr exp))

(define (eval exp env)
  (cond ; ...
        ((let? exp) (eval (let->combination exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))
