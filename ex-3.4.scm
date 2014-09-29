;;; Exercise 3.4.  Modify the make-account procedure of exercise 3.3 by adding
;;; another local state variable so that, if an account is accessed more than
;;; seven consecutive times with an incorrect password, it invokes the
;;; procedure call-the-cops.

(load "./ex-3.3.scm")

(define make-account
  (let ([%make-account make-account])
    (lambda initial-args
      (let ([acc (apply %make-account initial-args)]
            [failed-count 0])
        (lambda dispatched-args
          (let* ([m (apply acc dispatched-args)]
                 [r (m 0)])
            (if (equal? r "Incorrect password")
              (begin
                (set! failed-count (+ failed-count 1))
                (if (> failed-count 7)
                  (call-the-cops)
                  m))
              (begin
                (set! failed-count 0)
                m))))))))

(define (call-the-cops)
  (error "wooooop wooooop"))

(define acc (make-account 100 'secret-password))

(print ((acc 'secret-password 'withdraw) 10))
;=> 90
(print ((acc 'wrong-password 'withdraw) 10))
;=> "Incorrect password"
(print ((acc 'wrong-password 'withdraw) 10))
;=> "Incorrect password"
(print ((acc 'wrong-password 'withdraw) 10))
;=> "Incorrect password"
(print ((acc 'wrong-password 'withdraw) 10))
;=> "Incorrect password"
(print ((acc 'wrong-password 'withdraw) 10))
;=> "Incorrect password"
(print ((acc 'wrong-password 'withdraw) 10))
;=> "Incorrect password"
(print ((acc 'wrong-password 'withdraw) 10))
;=> "Incorrect password"
(print ((acc 'wrong-password 'withdraw) 10))
;=> error: wooooop wooooop
