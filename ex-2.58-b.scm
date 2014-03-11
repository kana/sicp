(load "./ex-2.58-a.scm")
(use srfi-1)

; (define (left-exp app op)
;   (define (go acc rest)
;     (if (or (null? rest) (eq? op (car rest)))
;       (reverse acc)
;       (go (cons (car rest) acc)
;           (cdr rest))))
;   (if (eq? op (cadr app))
;     (car app)
;     (go '() app)))

(define (left-exp app op)
  (if (eq? op (cadr app))
    (car app)
    (take-while (lambda (x) (not (eq? op x))) app)))

(define (right-exp app op)
  (let ((e (cdr (memq op app))))
    (if (null? (cdr e))
      (car e)
      e)))

(define (sum? x)
  (and (pair? x)
       (memq '+ x)))

(define (addend s)
  (left-exp s '+))

(define (augend s)
  (right-exp s '+))

; Assumption: x is not a sum.
(define (product? x)
  (and (pair? x)
       (memq '* x)))

(define (multiplier p)
  (left-exp p '*))

(define (multiplicand p)
  (right-exp p '*))
