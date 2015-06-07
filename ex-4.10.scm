;;; Exercise 4.10.  By using data abstraction, we were able to write an eval
;;; procedure that is independent of the particular syntax of the language to
;;; be evaluated. To illustrate this, design and implement a new syntax for
;;; Scheme by modifying the procedures in this section, without changing eval
;;; or apply.

;; Let's introduce another syntax for assignment.
;; The original syntax is (set! <var> <value>),
;; while the new syntax is (<var> := <value>).

(define (assignment? exp)
  (cond ((tagged-list? exp 'set!) 'set!)
        ((and (pair? exp) (tagged-list? (cdr exp) ':=)) ':=)
        (else #f)))

(define (assignment-variable exp)
  (if (eq? (assignment? exp) 'set!)
    (cadr exp)
    (car exp)))

(define (assignment-value exp)
  (caddr exp))
