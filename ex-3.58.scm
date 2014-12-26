(load "./sec-3.5.scm")

;;; Exercise 3.58.  Give an interpretation of the stream computed by the
;;; following procedure:

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

;;; (Quotient is a primitive that returns the integer quotient of two
;;; integers.) What are the successive elements produced by (expand 1 7 10)?
;;; What is produced by (expand 3 8 10)?

; Expand performs a long division and returns the resulting quotient as
; a stream of digits in a given radix.  But num must be less than den.
; Therefore,
;
; * (expand 1 7 10) produces an infinite stream of 1, 4, 2, 8, 5 and 7.
; * (expand 3 8 10) produces 3, 7, 5 then infinite 0s.

(let go ([parameters-list '((1 7 10) (3 8 10))])
  (if (not (null? parameters-list))
    (let* ([parameters (car parameters-list)]
           [s (apply expand parameters)])
      (write (cons 'expand parameters))
      (display " ==> ")
      (do ((i 0 (+ i 1)))
        ((= i 15))
        (display (stream-ref s i))
        (display ", "))
      (display "...\n")
      (go (cdr parameters-list)))))
