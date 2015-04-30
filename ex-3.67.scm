(load "./sec-3.5.scm")
(load "./ex-3.66-test.scm")

;; (S0,T0) | (S0,T1) (S0,T2) ...
;; -----------------------------
;; (S1,T0)   (S1,T1) (S1,T2) ...
;; ...       ...     ...
(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (tj) (list (stream-car s) tj))
                  (stream-cdr t))
      (pairs (stream-cdr s) t))))

(define (main args)
  (define s (pairs integers integers))
  (do ([i 0 (+ i 1)])
    ((= i 20))
    (print (stream-ref s i)))
  )
; ==> (1 1)
;     (1 2)
;     (2 1)
;     (1 3)
;     (2 2)
;     (1 4)
;     (3 1)
;     (1 5)
;     (2 3)
;     (1 6)
;     (3 2)
;     (1 7)
;     (2 4)
;     (1 8)
;     (4 1)
;     (1 9)
;     (2 5)
;     (1 10)
;     (3 3)
;     (1 11)
;     ...
;
; (1 1) (1 2) (1 3) (1 4) (1 5) (1 6) (1 7) (1 8) (1 9) (1 10) (1 11)
; (2 1) (2 2) (2 3) (2 4) (2 5)
; (3 1) (3 2) (3 3)
; (4 1)
