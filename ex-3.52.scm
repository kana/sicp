(load "./sec-3.5.scm")

;;; Exercise 3.52.  Consider the sequence of expressions

(define sum 0)
(define (accum x)                                                 ; E0
  (set! sum (+ x sum))
  sum)
(print "E0: " sum ";")
(define seq (stream-map accum (stream-enumerate-interval 1 20)))  ; E1
(print "E1: " sum ";")
(define y (stream-filter even? seq))                              ; E2
(print "E2: " sum ";")
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))       ; E3
                         seq))
(print "E3: " sum ";")
(stream-ref y 7)                                                  ; E4
(print "E4: " sum ";")
(display-stream z)                                                ; E5
(print "E5: " sum ";")

;;; What is the value of sum after each of the above expressions is evaluated?

; base   1  2  3  4  5  6  7  8  9 10 11 12 13  14  15  16  17  18  19  20
;       E1 E2 E2 E3
; seq    1  3  6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210
;       E1 E2 E2 E3
; y            6 10       28 36       66 78        120 136         190 210
;             E2 E3       E4 E4       E4 E4         E4  E4
; z              10 15          45 55              120             190 210
;                E3 E5          E5 E5               E5              E5  E5

; * After E0: 0, because seq is not processed yet.
; * After E1: 1, because stream-map delays evaluation only for non-first items.
;   So only the first item -- in this case, 1 -- is processed by accum.
; * After E2: 6, because stream-filter eagrly processes a given stream until
;   a proper item is found, and the first item of y is the third item of seq.
; * After E3: 10.  Like E2.
; * After E4: 136.  Like E2.
; * After E5: 210.  In this case, the base stream is completely enumerated.

;;; What is the printed response to evaluating the stream-ref and
;;; display-stream expressions?

; For stream-ref: 136
; For display-stream: 10, 15, 45, 55, 120, 190 and 210

;;; Would these responses differ if we had implemented (delay <exp>) simply as
;;; (lambda () <exp>) without using the optimization provided by memo-proc?
;;; Explain.

; Yes they differ, because seq is enumerated twice by y and z.
