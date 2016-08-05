; (b^(n/2))^2 = (b^2)^(n/2)  (n mod 2 = 0)
; b (b^n-1)
;
; b^1 = b
; b^2 = b^1 * b^1
; b^4 = b^2 * b^2
; b^5 = b * b^2 * b^2
; b^9 = b * b^8 
;     = b * b^4 * b^4
;     = b * b^2 * b^2 * b^2 * b^2
; b7 = 1 6 = 1 (3 3)
;
; b^(n+1) = a * b^n
; b * b^n = a * b^n
; b * (b^(n/2))^2 = a * (b^2)^(n/2)
; b * (b^(n/2))^2 = a
; (b^2)^(n/2)
;
; b^(2n+1) = b * b^n * b^n
; b^(2n) = b^n * b^n

(define (fast-expt b n)
  (define (iter b a n)
    (print "--- b " b " a " a " n " n)
    (cond
      ((= n 0) a)
      ((even? n) (iter (square b) a (/ n 2)))
      (else (iter b (* a b) (- n 1)))))
  (print)
  (print "=== b " b " n " n)
  (iter b 1 n))

(print (fast-expt 2 1) " vs " (expt 2 1))
(print (fast-expt 2 2) " vs " (expt 2 2))
(print (fast-expt 2 3) " vs " (expt 2 3))
(print (fast-expt 2 4) " vs " (expt 2 4))
(print (fast-expt 2 5) " vs " (expt 2 5))
(print (fast-expt 2 8) " vs " (expt 2 8))
(print (fast-expt 2 19) " vs " (expt 2 19))
;(print (fast-expt 3 3) " vs " (expt 3 3))
;(print (fast-expt 5 5) " vs " (expt 5 5))
;(print (fast-expt 9 9) " vs " (expt 9 9))
