;;; Exercise 3.60.  With power series represented as streams of coefficients
;;; as in exercise 3.59, adding series is implemented by add-streams. Complete
;;; the definition of the following procedure for multiplying series:
;;;
;;; (define (mul-series s1 s2)
;;;   (cons-stream <??> (add-streams <??> <??>)))
;;;
;;; You can test your procedure by verifying that sin^2 x + cos^2 x = 1, using
;;; the series from exercise 3.59.

(define (mul-series s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams
      (scale-stream (stream-cdr s2) (stream-car s1))
      (mul-series (stream-cdr s1) s2))))
