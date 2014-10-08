;;; Exercise 3.7.  Consider the bank account objects created by make-account,
;;; with the password modification described in exercise 3.3. Suppose that our
;;; banking system requires the ability to make joint accounts. Define
;;; a procedure make-joint that accomplishes this. Make-joint should take three
;;; arguments. The first is a password-protected account. The second argument
;;; must match the password with which the account was defined in order for the
;;; make-joint operation to proceed. The third argument is a new password.
;;; Make-joint is to create an additional access to the original account using
;;; the new password. For example, if peter-acc is a bank account with password
;;; open-sesame, then
;;;
;;;     (define paul-acc
;;;       (make-joint peter-acc 'open-sesame 'rosebud))
;;;
;;; will allow one to make transactions on peter-acc using the name paul-acc
;;; and the password rosebud. You may wish to modify your solution to exercise
;;; 3.3 to accommodate this new feature.

(define (make-account balance the-password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch password m)
    (cond [(eq? m 'authorize) (eq? password the-password)]
          [(eq? password the-password)
           (cond [(eq? m 'withdraw) withdraw]
                 [(eq? m 'deposit) deposit]
                 [else (error "Unknown request -- MAKE-ACCOUNT" m)])]
          [else (lambda _ "Incorrect password")]))
  dispatch)

(define (make-joint account old-password new-password)
  (define (dispatch password m)
    (if (eq? password new-password)
      (account old-password m)
      (lambda _ "Incorrect password")))
  (if (account old-password 'authorize)
    dispatch
    (error "Incorrect password")))



(define peter-acc (make-account 100 'open-sesame))
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

(print ((peter-acc 'open-sesame 'withdraw) 10))
;=> 90
(print ((paul-acc 'rosebud 'withdraw) 10))
;=> 80
(print ((peter-acc 'open-sesame 'withdraw) 15))
;=> 65
(print ((paul-acc 'rosebud 'withdraw) 10))
;=> 55

(print ((peter-acc 'rosebud 'withdraw) 10))
;=> Incorrect password
(print ((paul-acc 'open-sesame 'withdraw) 10))
;=> Incorrect password
