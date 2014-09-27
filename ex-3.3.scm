;;; Exercise 3.3.  Modify the make-account procedure so that it creates
;;; password-protected accounts. That is, make-account should take a symbol as
;;; an additional argument, as in
;;;
;;; (define acc (make-account 100 'secret-password))
;;;
;;; The resulting account object should process a request only if it is
;;; accompanied by the password with which the account was created, and should
;;; otherwise return a complaint:
;;;
;;; ((acc 'secret-password 'withdraw) 40)
;;; 60
;;;
;;; ((acc 'some-other-password 'deposit) 50)
;;; "Incorrect password"

(load "./sec-3.1.1.scm")

(define make-account
  (let ([%make-account make-account])
    (lambda (initial-balance the-password)
      (let ([acc (%make-account initial-balance)])
        (define (dispatch password message)
          (if (eq? password the-password)
            (acc message)
            (lambda _ "Incorrect password")))
        dispatch))))

; (define acc (make-account 100 'secret-password))
;
; (print ((acc 'secret-password 'withdraw) 40))
; ;==> 60
;
; (print ((acc 'some-other-password 'deposit) 50))
; ;==> "Incorrect password"
