; Exercise 1.5.  Ben Bitdiddle has invented a test to determine whether the
; interpreter he is faced with is using applicative-order evaluation or
; normal-order evaluation. He defines the following two procedures:

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

; Then he evaluates the expression
;
; (test 0 (p))
;
; What behavior will Ben observe with an interpreter that uses
; applicative-order evaluation? What behavior will he observe with an
; interpreter that uses normal-order evaluation?




; Short answer
; ============
;
; * With applicative-order evaluation,
;   the expression will never be evaluated in finite time.
; * With normal-order evaluation,
;   the expression is evaluated to 0.
;
; 
; Long answer
; ===========
; 
; With applicative-order
; ----------------------
;
; To evaluate the combination,
;
;     (test 0 (p))    ; ... [m0]
;
; we have to evaluate each subexpression.
; Let's evaluate subexpressions from left to right.
; The first subexpression is TEST.  TEST is bound to a procedure in this
; environment.  Use <test> to denote the procedure.
;
;     (<test> 0 (p))  ; ... [m1]
;
; The second subexpression is 0.  0 is evaluated to itself.
;
;     (<test> 0 (p))  ; ... [m2]
;
; The last subexpression is (p).  Since (p) is a combination, we have to
; recursively apply the rules to evaluate it.
;
;     (p)             ; ... [s0]
;
; Let's evaluate the subexpression.  Use <p> to denote the procedure which is
; bound to P.
;
;     (<p>)           ; ... [s1]
;
; Then substitute (<p>) with the body of <p>.
;
;     (p)             ; ... [s2]
;
; As a result, (p) is finally evaluated to (p).  In other words, it is an
; infinite loop.  Therefore the combination [m0] will never be evaluated in
; finite time.
; 
;
; With normal-order
; -----------------
;
; To evaluate the combination,
;
;     (test 0 (p))
;
; we have to substitute the combination with the body of <test>.
;
;     (if (= 0 0) 0 (p))
;
; Since IF is a special form.  It has the special evaluation rule.
; We have to evaluate the condition first.
;
;     (if #t 0 (p))
;
; Then we have to evaluate either expression.  In this case, the condition is
; evaluated to truth, so that we have to choose the former expression.
; As a result, the combination is finally evaluated to 0.
