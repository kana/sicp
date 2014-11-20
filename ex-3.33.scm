;;; Exercise 3.33.  Using primitive multiplier, adder, and constant
;;; constraints, define a procedure averager that takes three connectors a, b,
;;; and c as inputs and establishes the constraint that the value of c is the
;;; average of the values of a and b.

(load "./sec-3.3.5.scm")


;;      a + b
;;  c = -----
;;        2
;;
;; 2c = a + b
;;
;;      ------------     ------------
;; c ---| m1       |  q  |       a1 |--- a
;;      |     *  p |-----| s  +     |
;;   ,--| m2       |     |       a2 |--- b
;;   |  ------------     ------------
;; r |
;;   |   -----
;;   `---| 2 |
;;       -----
(define (averager a b c)
  (let ([q (make-connector)]
        [r (make-connector)])
    (constant 2 r)
    (multiplier c r q)
    (adder a b q)
    'ok))

(define a (make-connector))
(probe "A" a)
(define b (make-connector))
(probe "B" b)
(define c (make-connector))
(probe "C" c)
(averager a b c)

(set-value! b 10 'user)
(set-value! c 30 'user)
; a will be set to 50.
