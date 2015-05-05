;;; Exercise 4.3.  Rewrite eval so that the dispatch is done in data-directed
;;; style. Compare this with the data-directed differentiation procedure of
;;; exercise 2.73. (You may use the car of a compound expression as the type of
;;; the expression, as is appropriate for the syntax implemented in this
;;; section.) .

(define (eval exp env)
  ((or (get 'eval (exp-type exp))
       eval-application)
   exp
   env))

(define (exp-type exp)
  (cond ((self-evaluating? exp) '(self-evaluating))
        ((variable? exp) '(variable))
        ((pair? exp) (car exp))
        (else '(unknown))))

(put 'eval '(self-evaluating) (lambda (exp env) exp))
(put 'eval '(variable) lookup-variable-value)
(put 'eval '(unknown)
     (lambda (exp env)
       (error "Unknown expression type -- EVAL" exp)))

(put 'eval 'quote (lambda (exp env) (text-of-quotation exp)))
(put 'eval 'set! eval-assignment)
(put 'eval 'define eval-definition)
(put 'eval 'if eval-if)
(put 'eval 'lambda
     (lambda (exp env)
       (make-procedure (lambda-parameters exp)
                       (lambda-body exp)
                       env)))
(put 'eval 'begin
     (lambda (exp env)
       (eval-sequence (begin-actions exp) env)))
(put 'eval 'cond
     (lambda (exp env)
       ((cond? exp) (eval (cond->if exp) env))))

(define (eval-application exp env)
  (apply (eval (operator exp) env)
         (list-of-values (operands exp) env)))
