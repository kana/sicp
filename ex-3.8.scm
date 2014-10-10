;;; Exercise 3.8.  When we defined the evaluation model in section 1.1.3, we
;;; said that the first step in evaluating an expression is to evaluate its
;;; subexpressions. But we never specified the order in which the
;;; subexpressions should be evaluated (e.g., left to right or right to left).
;;; When we introduce assignment, the order in which the arguments to
;;; a procedure are evaluated can make a difference to the result. Define
;;; a simple procedure f such that evaluating (+ (f 0) (f 1)) will return 0 if
;;; the arguments to + are evaluated from left to right but will return 1 if
;;; the arguments are evaluated from right to left.

(define (make-f)
  (let ([evaluated #f])
    (lambda (x)
      (if evaluated
        0
        (begin
          (set! evaluated #t)
          x)))))

;; Emulate left-to-right evaluated (+ (f 0) (f 1))
(define f1 (make-f))
(let* ([l (f1 0)]
       [r (f1 1)])
  (print (+ l r)))

;; Emulate right-to-left evaluated (+ (f 0) (f 1))
(define f2 (make-f))
(let* ([r (f2 1)]
       [l (f2 0)])
  (print (+ l r)))
