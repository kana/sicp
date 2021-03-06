;;; Exercise 4.20.  Because internal definitions look sequential but are
;;; actually simultaneous, some people prefer to avoid them entirely, and use
;;; the special form letrec instead. Letrec looks like let, so it is not
;;; surprising that the variables it binds are bound simultaneously and have
;;; the same scope as each other. The sample procedure f above can be written
;;; without internal definitions, but with exactly the same meaning, as
;;;
;;;     (define (f x)
;;;       (letrec ((even?
;;;                 (lambda (n)
;;;                   (if (= n 0)
;;;                       true
;;;                       (odd? (- n 1)))))
;;;                (odd?
;;;                 (lambda (n)
;;;                   (if (= n 0)
;;;                       false
;;;                       (even? (- n 1))))))
;;;         <rest of body of f>))
;;;
;;; Letrec expressions, which have the form
;;;
;;;     (letrec ((<var1> <exp1>) ... (<varn> <expn>))
;;;       <body>)
;;;
;;; are a variation on let in which the expressions <expk> that provide the
;;; initial values for the variables <vark> are evaluated in an environment
;;; that includes all the letrec bindings. This permits recursion in the
;;; bindings, such as the mutual recursion of even? and odd? in the example
;;; above, or the evaluation of 10 factorial with
;;;
;;;     (letrec ((fact
;;;               (lambda (n)
;;;                 (if (= n 1)
;;;                     1
;;;                     (* n (fact (- n 1)))))))
;;;       (fact 10))




;;; a. Implement letrec as a derived expression, by transforming a letrec
;;; expression into a let expression as shown in the text above or in exercise
;;; 4.18. That is, the letrec variables should be created with a let and then
;;; be assigned their values with set!.

(define (letrec? expr)
  (tagged-list? 'letrec))

(define letrec-bindings cadr)

(define letrec-body cddr)

(define (letrec->let expr)
  (define (to-declaration binding)
    `(,(car binding) '*unassigned*))
  (define (to-assignment binding)
    `(set! ,(car binding) ,(cadr binding)))
  `(let ,(map to-declaration (letrec-bindings expr))
     ,@(map to-assignment (letrec-bindings expr))
     ,@(letrec-body expr)))




;;; b. Louis Reasoner is confused by all this fuss about internal definitions.
;;; The way he sees it, if you don't like to use define inside a procedure, you
;;; can just use let. Illustrate what is loose about his reasoning by drawing
;;; an environment diagram that shows the environment in which the <rest of
;;; body of f> is evaluated during evaluation of the expression (f 5), with
;;; f defined as in this exercise. Draw an environment diagram for the same
;;; evaluation, but with let in place of letrec in the definition of f.

; ---------------------------
; |                         | The environment where f is defined.
; ---------------------------
;        ^
;        |
; ---------------------------
; | x: 5                    | The environment to apply f.
; ---------------------------
;        ^
;        |
;      ----------------------
;      | even?: --------.   | The environment to evaluate <rest of body of f>
;      | odd:?: --.     |   | which is craeted by letrec.
;      -----------|-----|----
;               ^ |   ^ |
;               | |   | |
;               | |   `o=o
;               `o=o    |
;                  |    v
;                  v  [code...]
;            [code...]
;
; ---------------------------
; |                         | The environment where f is defined.
; ---------------------------
;        ^
;        |
; ---------------------------
; | x: 5                    | The environment to apply f.
; ---------------------------
;  ^ ^   ^
;  | |   |
;  | | ----------------------
;  | | | even?: --------.   | The environment to evaluate <rest of body of f>
;  | | | odd:?: --.     |   | which is craeted by let.
;  | | -----------|-----|----
;  | |            |     |
;  | |            |     |
;  | `------------|----o=o
;  `-------------o=o    |
;                  |    v
;                  v  [code...]
;            [code...]
;
; So that even? can't find add?, and vice versa.
