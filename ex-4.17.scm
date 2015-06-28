;;; Exercise 4.17.  Draw diagrams of the environment in effect when evaluating
;;; the expression <e3> in the procedure in the text, comparing how this will
;;; be structured when definitions are interpreted sequentially with how it
;;; will be structured if definitions are scanned out as described.

; From the text:
;
; > For example, the procedure
; >
; >     (lambda <vars>
; >       (define u <e1>)
; >       (define v <e2>)
; >       <e3>)
; >
; > would be transformed into
; >
; >     (lambda <vars>
; >       (let ((u '*unassigned*)
; >             (v '*unassigned*))
; >         (set! u <e1>)
; >         (set! v <e2>)
; >         <e3>))

; TODO




;;; Why is there an extra frame in the transformed program?

; TODO




;;; Explain why this difference in environment structure can never make
;;; a difference in the behavior of a correct program.

; TODO




;;; Design a way to make the interpreter implement the ``simultaneous'' scope
;;; rule for internal definitions without constructing the extra frame.

; TODO
