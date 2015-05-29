;;; Exercise 4.4.  Recall the definitions of the special forms and and or from
;;; chapter 1:
;;;
;;; * and: The expressions are evaluated from left to right. If any expression
;;;   evaluates to false, false is returned; any remaining expressions are not
;;;   evaluated. If all the expressions evaluate to true values, the value of
;;;   the last expression is returned. If there are no expressions then true is
;;;   returned.
;;; * or: The expressions are evaluated from left to right. If any expression
;;;   evaluates to a true value, that value is returned; any remaining
;;;   expressions are not evaluated. If all expressions evaluate to false, or
;;;   if there are no expressions, then false is returned.

;;; Install and and or as new special forms for the evaluator by defining
;;; appropriate syntax procedures and evaluation procedures eval-and and
;;; eval-or.

(define (eval exp env)
  (cond ; ...
        ((and? exp) (eval-and (and-exprs exp) env))
        ((or? exp) (eval-or (or-exprs exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(define (and? exp)
  (tagged-list? exp 'and))

(define and-exprs cdr)

(define (or? exp)
  (tagged-list? exp 'or))

(define or-exprs cdr)

(define (eval-and exps env)
  (let go ([last-result #t]
           [exps exps])
    (if (and last-result (not (null? exps)))
      (go (eval (car exps env)) (cdr exps env))
      last-result)))

(define (eval-or exps env)
  (let go ([last-result #f]
           [exps exps])
    (if (or last-result (null? exps))
      last-result
      (go (eval (car exps env)) (cdr exps env)))))


;;; Alternatively, show how to implement and and or as derived expressions.

(define (eval-and exps env)
  (eval (and->if exps) env))

(define (and->if exps)
  (if (null? (cdr exps))
    (car exps)
    (let ([%result (gensym)])
      `(let ([,%result ,(car exps)])
         (if ,%result
           ,(and-if (cdr exps))
           #f)))))

(define (eval-or exps env)
  (eval (or->if exps) env))

(define (or->if exps)
  (if (null? (cdr exps))
    (car exps)
    (let ([%result (gensym)])
      `(let ([,%result ,(car exps)])
         (if ,%result
           ,%result
           ,(or-if (cdr exps)))))))
