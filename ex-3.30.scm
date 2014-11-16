;;; Exercise 3.30.  Figure 3.27 shows a ripple-carry adder formed by stringing
;;; together n full-adders. This is the simplest form of parallel adder for
;;; adding two n-bit binary numbers. The inputs A1, A2, A3, ..., An and B1, B2,
;;; B3, ..., Bn are the two binary numbers to be added (each Ak and Bk is
;;; a 0 or a 1). The circuit generates S1, S2, S3, ..., Sn, the n bits of the
;;; sum, and C, the carry from the addition.

;;; Write a procedure ripple-carry-adder that generates this circuit. The
;;; procedure should take as arguments three lists of n wires each -- the Ak,
;;; the Bk, and the Sk -- and also another wire C.

; as = A1, A2, ..., An
; bs = B1, B2, ..., Bn
; ss = S1, S2, ..., Sn
(define (ripple-carry-adder as bs ss c)
  (let go ([as as]
           [bs bs]
           [ss ss]
           [cs (map as (lambda _ (make-wire)))]
           [c-out c])
    (if (not (null? as))
      (begin
        (full-adder (car as) (car bs) (car cs) (car ss) c-out)
        (go (cdr as) (cdr bs) (cdr ss) (cdr cs) (car cs))))))




;;; The major drawback of the ripple-carry adder is the need to wait for the
;;; carry signals to propagate. What is the delay needed to obtain the complete
;;; output from an n-bit ripple-carry adder, expressed in terms of the delays
;;; for and-gates, or-gates, and inverters?

; Suppose that a half-adder is implemented as drawn in Figure 3.25
; and or-gate is implemented as a primitive function.
;
; Da = and-gate-delay
; Do = or-gate-delay
; Di = inverter-delay
; Dhs = the delay of a half-adder to obtain a valid S
; Dhc = the delay of a half-adder to obtain a valid C
; Dfs = the delay of a full-adder to obtain a valid SUM
; Dfc = the delay of a full-adder to obtain a valid Cout
; Drsk = the delay of a ripple-carry adder to obtain a valid Sk
; Drck = the delay of a ripple-carry adder to obtain a valid Ck
; Drc0 = the delay of a ripple-carry adder to obtain a valid C
;
; Dhs = max(2Da + Di, Do + Da)
; Dhc = Da
; Dfs = 2Dhs
; Dfc = max(Dhc, Dhs + Dhc) + Do = Dhs + Dhc + Do = Dhs + Da + Do
;
; Drsn = Dfs
; Drc{n-1} = Dfc
; Drs{n-1} = Drc{n-1} + Dfs = Dfc + Dfs
; Drc{n-2} = Drc{n-1} + Dfc = 2Dfc
; ...
; Drs1 = (n-1)Dfc + Dfs
;      = (n-1)(Dhs + Da + Do) + 2Dhs
;      = (n+1)Dhs + (n-1)(Da + Do)
;      = max((n+1)(2Da + Di), (n+1)(Do + Da)) + (n-1)(Da + Do)
;      = max((n+1)(2Da + Di) + (n-1)(Da + Do), (n+1)(Do + Da) + (n-1)(Da + Do))
;      = max((n+1)2Da + (n+1)Di + (n-1)Da + (n-1)Do, 2n(Do + Da))
;      = max((3n+1)Da + (n+1)Di + (n-1)Do, 2n(Do + Da))
; Drs0 = n Dfc
;      = n (Dhs + Da + Do)
;      = nDhs + nDa + nDo
;      = n max(2Da + Di, Do + Da) + nDa + nDo
;      = max(2nDa + nDi, nDo + nDa) + nDa + nDo
;      = max(2nDa + nDi + nDa + nDo, nDo + nDa + nDa + nDo)
;      = max(3nDa + n(Di + Do), 2n(Do + Da))
