;;; Exercise 4.13.  Scheme allows us to create new bindings for variables by
;;; means of `define`, but provides no way to get rid of bindings. Implement
;;; for the evaluator a special form `make-unbound!` that removes the binding
;;; of a given symbol from the environment in which the `make-unbound!`
;;; expression is evaluated. This problem is not completely specified. For
;;; example, should we remove only the binding in the first frame of the
;;; environment? Complete the specification and justify any choices you make.

;; The best behavior varies for each situation.  So that I chose to implement
;; both versions.

(require "./ex-4.12")

(define (make-unbound-first! var env)
  (define undef (if #f #t))
  (scan-environment
    var
    env
    (lambda (vars vals)
      ; TODO: The binding should be removed from the frame.
      (set-car! vars undef)
      (set-car! vals undef))
    (lambda (frame)
      #f)
    (lambda ()
      #f)))

(define (make-unbound-all! var env)
  (define undef (if #f #t))
  (scan-environment
    var
    env
    (lambda (vars vals)
      ; TODO: The binding should be removed from the frame.
      (set-car! vars undef)
      (set-car! vals undef))
    (lambda (frame)
      (make-unbound-all! var (enclosing-environment env)))
    (lambda ()
      #f)))
