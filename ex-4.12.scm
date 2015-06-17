;;; Exercise 4.12.  The procedures set-variable-value!, define-variable!, and
;;; lookup-variable-value can be expressed in terms of more abstract procedures
;;; for traversing the environment structure. Define abstractions that capture
;;; the common patterns and redefine the three procedures in terms of these
;;; abstractions.

;; The original procedures are:

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))


;; These procedures have similar `scan` procedure to traverse the environment
;; structure.  The difference of `scan`s are
;;
;; * What to do when a target variable is found in a frame, and
;; * What to do when a target variable is found in a frame.
;;
;; So that it can be abstracted as follows:

(define (scan-environment var env found not-found-in-frame not-found-in-env)
  (define frame (first-frame env))
  (let go ((vars (frame-variables frame))
           (vals (frame-values frame)))
    (cond ((null? vars)
           (not-found-in-frame frame))
          ((eq? var (car vars))
           (found vars vals))
          (else
            (go (cdr vars) (cdr vals))))))


;; And the procedure can be redefined as follows:

(define (lookup-variable-value var env)
  (scan-environment
    var
    env
    (lambda (vars vals)
      (car vals))
    (lambda (frame)
      (lookup-variable-value var (enclosing-environment env)))
    (lambda ()
      (error "Unbound variable" var))))

(define (set-variable-value! var val env)
  (scan-environment
    var
    env
    (lambda (vars vals)
      (set-car! vals val))
    (lambda (frame)
      (set-variable-value! var val (enclosing-environment env)))
    (lambda ()
      (error "Unbound variable -- SET!" var))))

(define (define-variable! var val env)
  (scan-environment
    var
    env
    (lambda (vars vals)
      (set-car! vals val))
    (lambda (frame)
      (add-binding-to-frame! var val frame))
    #f))
