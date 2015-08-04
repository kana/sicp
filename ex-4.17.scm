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

; Sequential version:
;
;     --------------------- The environment
;     |                   | when evaluating the lambda expression.
;     ---------------------
;               ^
;               |
;     ---------------------
;     | <vars>: ...       | The environment
;     | u: result of <e1> | when applying the lambda object, and
;     | v: result of <e2> | when evaluating <e3>.
;     ---------------------

; Scanned-out version:
;
;     --------------------- The environment
;     |                   | when evaluating the lambda expression.
;     ---------------------
;               ^
;               |
;     --------------------- The environment
;     | <vars>: ...       | when applying the lambda object.
;     ---------------------
;               ^
;               |
;     --------------------- The environment
;     | u: result of <e1> | when evaluating <e3>
;     | v: result of <e2> |
;     ---------------------




;;; Why is there an extra frame in the transformed program?

; Because the transformed program uses LET for U and V.




;;; Explain why this difference in environment structure can never make
;;; a difference in the behavior of a correct program.

; When evaluating <e3>, values of U and V must be results of <e1> and <e2>.
;
; If <vars> does not contain U and V, both environments are equivalent because
; no variable is overwritten.
;
; If <vars> contains U and/or V:
;
; * The sequential version overwrites values of U and/or V if <vars> contains
;   U and/or V.  So the two variables are bound to results of <e1> and <e2>
;   when evaluating <e3>.
;
; * The scanned-out version doesn't overwrite U and/or V, but the new frame
;   hides values of U and/or V in <vars>.  So the two variables are bound to
;   results of <e1> and <e2> when evaluating <e3>.
;
; Therefore both environment structures are equivalent to evaluate <e3>.




;;; Design a way to make the interpreter implement the ``simultaneous'' scope
;;; rule for internal definitions without constructing the extra frame.

; TODO
