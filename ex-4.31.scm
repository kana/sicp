;;; Exercise 4.31.  The approach taken in this section is somewhat unpleasant,
;;; because it makes an incompatible change to Scheme. It might be nicer to
;;; implement lazy evaluation as an upward-compatible extension, that is, so
;;; that ordinary Scheme programs will work as before. We can do this by
;;; extending the syntax of procedure declarations to let the user control
;;; whether or not arguments are to be delayed. While we're at it, we may as
;;; well also give the user the choice between delaying with and without
;;; memoization. For example, the definition
;;;
;;;     (define (f a (b lazy) c (d lazy-memo))
;;;       ...)
;;;
;;; would define f to be a procedure of four arguments, where the first and
;;; third arguments are evaluated when the procedure is called, the second
;;; argument is delayed, and the fourth argument is both delayed and memoized.
;;; Thus, ordinary procedure definitions will produce the same behavior as
;;; ordinary Scheme, while adding the lazy-memo declaration to each parameter
;;; of every compound procedure will produce the behavior of the lazy evaluator
;;; defined in this section. Design and implement the changes required to
;;; produce such an extension to Scheme. You will have to implement new syntax
;;; procedures to handle the new syntax for define. You must also arrange for
;;; eval or apply to determine when arguments are to be delayed, and to force
;;; or delay arguments accordingly, and you must arrange for forcing to memoize
;;; or not, as appropriate.

(load "./sec-4.1.1.scm")
(load "./sec-4.1.2.scm")
(load "./sec-4.1.3.scm")
(load "./sec-4.1.4.scm")
(load "./sec-4.2.2.scm")




(define (parameter-name param)
  (if (pair? param)
    (car param)
    param))

(define (parameter-lazy? param)
  (and (pair? param)
       (or (eq? (cadr param) 'lazy)
           (eq? (cadr param) 'lazy-memo))))

(define (parameter-memo? param)
  (and (pair? param)
       (eq? (cadr param) 'lazy-memo)))


(define (procedure-parameters-with-metadata p)
  (cadr p))

(define (procedure-parameter-names p)
  (map parameter-name (procedure-parameters-with-metadata p)))

(define procedure-parameters procedure-parameter-names)


(define (%apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))  ; nothing changed
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           (list-of-delayed-args                            ; changed
             (procedure-parameters-with-metadata procedure) ; changed
             arguments                                      ; changed
             env)                                           ; changed
           (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))

(define (list-of-delayed-args params exps env)
  (map (lambda (p e)
         (if (parameter-lazy? p)
           (delay-it e p env)
           (actual-value e env)))
       params
       exps))


(define (delay-it exp param env)
  (list 'thunk exp param env))

(define thunk-exp cadr)
(define thunk-param caddr)
(define thunk-env cadddr)
