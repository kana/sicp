;;; Exercise 3.28.  Define an or-gate as a primitive function box. Your or-gate
;;; constructor should be similar to and-gate.

(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let ([new-value (logical-or (get-signal o1) (get-signal o2))])
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
  'ok)

(define (logical-or s1 s2)
  (cond [(and (= s1 0) (= s2 0)) 0]
        [(and (= s1 1) (= s2 0)) 1]
        [(and (= s1 0) (= s2 1)) 1]
        [(and (= s1 1) (= s2 1)) 1]
        [else (error "Invalid signals" s1 s2)]))
