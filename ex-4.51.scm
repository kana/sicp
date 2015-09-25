;;; Exercise 4.51.  Implement a new kind of assignment called permanent-set!
;;; that is not undone upon failure. For example, we can choose two distinct
;;; elements from a list and count the number of trials required to make
;;; a successful choice as follows:
;;;
;;;     (define count 0)
;;;     (let ((x (an-element-of '(a b c)))
;;;           (y (an-element-of '(a b c))))
;;;       (permanent-set! count (+ count 1))
;;;       (require (not (eq? x y)))
;;;       (list x y count))
;;;     ;;; Starting a new problem
;;;     ;;; Amb-Eval value:
;;;     (a b 2)
;;;     ;;; Amb-Eval input:
;;;     try-again
;;;     ;;; Amb-Eval value:
;;;     (a c 3)
;;;
;;; What values would have been displayed if we had used set! here rather than
;;; permanent-set! ?

(require "./sec-4.3.3.scm")

(define temporary-assignment? assignment?)
(define (permanent-assignment? exp)
  (tagged-list? exp 'permanent-set!))
(define (assignment? exp)
  (or (temporary-assignment? exp)
      (permanent-assignment? exp)))

(define analyze-temporary-assignment analyze-assignment)
(define (analyze-permanent-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail)
               (set-variable-value! var val env)
               (succeed 'ok (lambda () (fail))))
             fail))))
(define (analyze-assignment exp)
  (cond ((temporary-assignment? exp)
         (analyze-temporary-assignment exp))
        ((permanent-assignment? exp)
         (analyze-permanent-assignment exp))
        (else
          (error "Unknown type of assignment:" exp))))

(define (make-test-code type)
  `((define (test-code)
      (define count 0)
      (let ((x (an-element-of '(a b c)))
            (y (an-element-of '(a b c))))
        (,type count (+ count 1))
        (require (not (eq? x y)))
        (list x y count)))
    (print "With " ',type)
    (print (test-code))))

(define (main args)
  (ambtest `(begin

              (define (an-element-of items)
                (require (not (null? items)))
                (amb (car items) (an-element-of (cdr items))))

              ,@(make-test-code 'permanent-set!)

              ))

  (ambtest `(begin

              ,@(make-test-code 'set!)

              ))
  )

; Output:
; ------------------------------------------------------------
; With permanent-set!
; (a b 2)
; (a c 3)
; (b a 4)
; (b c 6)
; (c a 7)
; (c b 8)
; *** No more values ***
; With set!
; (a b 1)
; (a c 1)
; (b a 1)
; (b c 1)
; (c a 1)
; (c b 1)
; *** No more values ***
; ------------------------------------------------------------
