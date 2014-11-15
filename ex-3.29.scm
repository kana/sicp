;;; Exercise 3.29.  Another way to construct an or-gate is as a compound
;;; digital logic device, built from and-gates and inverters. Define
;;; a procedure or-gate that accomplishes this.

; A or B = not(not(A or B))
;        = not(not(A) and not(B))
;
;      ----------------------
;      |    no1 ___         |
; o1 ----|>o---|   \ a      |
;      |       |   |---|>o----- output
; o2 ----|>o---|__/         |
;      |    no2             |
;      ----------------------

(define (or-gate o1 o2 output)
  (let ([no1 (make-wire)]
        [no2 (make-wire)]
        [a   (make-wire)])
    (inverter o1 no1)
    (inverter o2 no2)
    (and-gate no1 no2 a)
    (inverter a output)
    'ok))

;;; What is the delay time of the or-gate in terms of and-gate-delay and
;;; inverter-delay?

; It is equal to (+ or-gate-delay and-gate-delay or-gate-delay).
