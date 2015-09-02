;;; Exercise 4.34.  Modify the driver loop for the evaluator so that lazy pairs
;;; and lists will print in some reasonable way. (What are you going to do
;;; about infinite lists?) You may also need to modify the representation of
;;; lazy pairs so that the evaluator can identify them in order to print them.

(load "./sec-4.1.1.scm")
(load "./sec-4.1.2.scm")
(load "./sec-4.1.3.scm")
(load "./sec-4.1.4.scm")
(load "./sec-4.2.2.scm")

(define E0 the-global-environment)

(define-variable! 'pcons (%eval 'cons E0) E0)
(define-variable! 'pcar (%eval 'car E0) E0)
(define-variable! 'pcdr (%eval 'cdr E0) E0)

(define-variable!
  'lcons
  (%eval
    '(lambda (x y)
       (pcons 'lazy-pair
              (lambda (m) (m x y))))
    E0)
  E0)
(define-variable!
  'lcar
  (%eval
    '(lambda (z) ((pcdr z) (lambda (p q) p)))
    E0)
  E0)
(define-variable!
  'lcdr
  (%eval
    '(lambda (z) ((pcdr z) (lambda (p q) q)))
    E0)
  E0)

(define-variable! 'cons (%eval 'lcons E0) E0)
(define-variable! 'car (%eval 'lcar E0) E0)
(define-variable! 'cdr (%eval 'lcdr E0) E0)

(define (lazy-pair? object)
  (tagged-list? object 'lazy-pair))

(define (lcar x)
  (%eval `(lcar ',x) E0))
(define (lcdr x)
  (%eval `(lcdr ',x) E0))

(define (%user-print object)
  (cond ((compound-procedure? object)
         (display (list 'compound-procedure
                      (procedure-parameters object)
                      (procedure-body object)
                      '<procedure-env>)))
        ((lazy-pair? object)
         (display "(")
         (%user-print (lcar object))
         (display " . ")
         (%user-print (lcdr object))
         (display ")"))
        ((evaluated-thunk? object)
         (display (thunk-value object)))
        ((thunk? object)
         (display "<thunk for ")
         (display (thunk-exp object))
         (display ">"))
        (else (display object))))

(define (user-print object)
  (%user-print object)
  (newline))

(define code
  '((define ones (cons 1 ones))
    (car ones)
    (car (cdr ones))
    (car (cdr (cdr ones)))
    ones
    (cdr ones)
    ))

(define (main args)
  (for-each
    (lambda (expr)
      (print expr)
      (display "==> ")
      (user-print (actual-value expr the-global-environment))
      (print))
    code))
