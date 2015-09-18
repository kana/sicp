(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc) (cadr proc))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        ; <more primitives> ***
        (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list 'modulo modulo)
        (list '= =)
        (list '< <)
        (list '<= <=)
        (list '> >)
        (list '>= >=)
        (list 'not not)
        (list 'list list)
        (list 'member member)
        (list 'abs abs)
        (list 'indent (lambda (n x)
                        (string-append (make-string (* n 2) #\space)
                                       (x->string x))))
        (list 'print print)
        (list 'error error)
        (list 'eq? eq?)
        (list 'assq assq)
        (list 'distinct?
              (letrec ((distinct?
                         (lambda (items)
                           (cond ((null? items) true)
                                 ((null? (cdr items)) true)
                                 ((member (car items) (cdr items)) false)
                                 (else (distinct? (cdr items)))))))
                distinct?))
        ))
(define (primitive-procedure-names)
  (map car
       primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))

; (define apply-in-underlying-scheme apply)

(define the-global-environment (setup-environment))

(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))
