;;; Exercise 4.16.  In this exercise we implement the method just described for
;;; interpreting internal definitions. We assume that the evaluator supports
;;; let (see exercise 4.6).

;;; a.  Change `lookup-variable-value` (section 4.1.3) to signal an error if
;;; the value it finds is the symbol *unassigned*.

(define lookup-variable-value
  (let ((%lookup-variable-value lookup-variable-value))
    (lambda (var env)
      (let ((val (%lookup-variable-value var env)))
        (if (eq? val '*unassigned*)
          (error "Unassigned variable" var)
          val)))))

;;; b.  Write a procedure `scan-out-defines` that takes a procedure body and
;;; returns an equivalent one that has no internal definitions, by making the
;;; transformation described above.

(define (scan-out-defines body)
  (define (split-defines body)
    (let go ((body body)
             (defines '())
             (non-defines '()))
      (cond ((null? body)
             (cons (reverse defines) (reverse non-defines)))
            ((definition? (car body))
             (go (cdr body) (cons (car body) defines) non-defines))
            (else
              (go (cdr body) defines (cons (car body) non-defines))))))
  (define (to-declaration def)
    (list (definition-variable def)
          '*unassigned*))
  (define (to-assignment def)
    (list 'set!
          (definition-variable def)
          (definition-value def)))
  ;; `(let ,(map to-declaration defines)
  ;;    ,@(map to-assignment defines)
  ;;    ,@non-defines)
  (append
    (list 'let (map to-declaration defines))
    (append
      (map to-assignment defines)
      non-defines)))

;;; c.  Install `scan-out-defines` in the interpreter, either in
;;; `make-procedure` or in `procedure-body` (see section 4.1.3). Which place is
;;; better? Why?

(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))

(define (procedure-body p)
  (scan-out-defines (caddr p)))

;; Each has its own merit:
;;
;; * In make-procedure: scan-out-defines is applied only once for each
;;   procedure.  It would improve performance of the metacircular evaluator,
;;   because procedure-body is expected to be applied for each application of
;;   compound procedures (in the metacircular evaluator), and scan-out-defines
;;   returns the equivalent result for each application with the same
;;   arguments.
;;
;; * In procedure-body: this keeps the original body.  If the metacircular
;;   evaluator found an error while applying a compound procedure, it would be
;;   useful for users to show where the error happens.  The original body must
;;   be kept to provide useful information to users.
