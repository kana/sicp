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

(define (serialized-exchange account1 account2)
  (define (do-exchange account1 account2)
    (let ((serializer1 (account1 'serializer))
          (serializer2 (account2 'serializer)))
      ((serializer1 (serializer2 exchange))
       account1
       account2)))
  (if (<= (account1 'id) (account2 'id))
    (do-exchange account1 account2)
    (do-exchange account2 account1)))

(define generate-accout-id
  (let ([id 0]
        [s (make-serializer)])
    (s (lambda ()
         (set! id (+ id 1))
         id))))

(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer))
        (id (generate-accout-id)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            ((eq? m 'id) id)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))
