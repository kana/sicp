;;; Exercise 4.8.  ``Named let'' is a variant of let that has the form
;;;
;;;     (let <var> <bindings> <body>)
;;;
;;; The <bindings> and <body> are just as in ordinary let, except that <var> is
;;; bound within <body> to a procedure whose body is <body> and whose
;;; parameters are the variables in the <bindings>. Thus, one can repeatedly
;;; execute the <body> by invoking the procedure named <var>. For example, the
;;; iterative Fibonacci procedure (section 1.2.2) can be rewritten using named
;;; let as follows:
;;;
;;;     (define (fib n)
;;;       (let fib-iter ((a 1)
;;;                      (b 0)
;;;                      (count n))
;;;         (if (= count 0)
;;;             b
;;;             (fib-iter (+ a b) a (- count 1)))))
;;;
;;; Modify let->combination of exercise 4.6 to also support named let.

(define (let? exp)
  (tagged-list? exp 'let))

(define (let-name exp)
  (if (symbol? (cadr exp))
    (cadr exp)
    #f))

(define (let-plain? exp)
  (not (let-name exp)))

(define (let-named? exp)
  (let-name exp))

(define (let-bindings exp)
  (if (let-plain? exp)
    (cadr exp)
    (caddr exp)))

(define (let-clauses exp)
  (if (let-plain? exp)
    (cddr exp)
    (cdddr exp)))

(define (let-clause-var clause)
  (car clause))

(define (let-clause-value-exp clause)
  (cadr clause))

(define (let->combination exp)
  (define name (let-name exp))
  (define vars (map let-clause-var (let-clauses exp)))
  (define value-exps (map let-clause-value-exp (let-clauses exp)))
  (define body (let-body exp))
  (if name
    (list 'let (list (list name (make-lambda vars body)))
       (cons name value-exps))
    (cons
      (list (make-lambda vars body))
      value-exps)))
