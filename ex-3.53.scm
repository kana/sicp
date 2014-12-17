(load "./sec-3.5.scm")

;;; Exercise 3.53.  Without running the program, describe the elements of the
;;; stream defined by

(define s (cons-stream 1 (add-streams s s)))

; Let's denote the n-th element of s as s(n).
;
; s(1) = 1, and
; s(n) = s(n - 1) + s(n - 1) by the definition.
;
; So,
;
; s(2) = s(1) + s(1) = 2
; s(3) = s(2) + s(2) = 4
; s(4) = s(3) + s(3) = 8
; s(5) = s(4) + s(4) = 16
; ...
; s(n) = s(n - 1) + s(n - 1) = 2^(n - 1)

(define (stream-take s n)
  (if (= n 0)
    the-empty-stream
    (cons-stream (stream-car s)
                 (stream-take (stream-cdr s) (- n 1)))))

(display-stream (stream-take s 10))
