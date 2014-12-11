;;; Exercise 3.48.  Explain in detail why the deadlock-avoidance method
;;; described above, (i.e., the accounts are numbered, and each process
;;; attempts to acquire the smaller-numbered account first) avoids deadlock in
;;; the exchange problem.

; Deadlock occurs if two processes P1 and P2 try to exchange two accounts A1
; and A2 but each process try to acquire exclusive access rights in different
; order.  For example, if P1 try to acquire the rights for A1 then A2 while P2
; try to acquire the rights for A2 then A1, deadlock can be occurred when P1
; acquires A1 and P2 acquires A2.
;
; If both processes try to acquire accounts in the same order, deadlock will
; never be occurred.  For example, if P1 already acquires A1, P2 can't acquire
; A1 until P1 finishes.  And if P2 already acquires A1, P1 can't acquire A1
; until P2 finishes.




;;; Rewrite serialized-exchange to incorporate this idea. (You will also need
;;; to modify make-account so that each account is created with a number, which
;;; can be accessed by sending an appropriate message.)

; TODO
