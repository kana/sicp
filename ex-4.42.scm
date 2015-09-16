;;; Exercise 4.42.  Solve the following ``Liars'' puzzle (from Phillips 1934):
;;;
;;; Five schoolgirls sat for an examination. Their parents -- so they thought
;;; -- showed an undue degree of interest in the result. They therefore agreed
;;; that, in writing home about the examination, each girl should make one true
;;; statement and one untrue one. The following are the relevant passages from
;;; their letters:
;;;
;;; * Betty: ``Kitty was second in the examination. I was only third.''
;;; * Ethel: ``You'll be glad to hear that I was on top. Joan was second.''
;;; * Joan: ``I was third, and poor old Ethel was bottom.''
;;; * Kitty: ``I came out second. Mary was only fourth.''
;;; * Mary: ``I was fourth. Top place was taken by Betty.''
;;;
;;; What in fact was the order in which the five girls were placed?

(load "./sec-4.3.3.scm")

(ambtest '(begin

            (define (distinct? items)
              (cond ((null? items) true)
                    ((null? (cdr items)) true)
                    ((member (car items) (cdr items)) false)
                    (else (distinct? (cdr items)))))

            (define (id x) x)

            (define (say flag statement)
              (require ((if flag id not) (statement))))

            (define (liars)
              (let ((betty (amb 1 2 3 4 5))
                    (ethel (amb 1 2 3 4 5))
                    (joan (amb 1 2 3 4 5))
                    (kitty (amb 1 2 3 4 5))
                    (mary (amb 1 2 3 4 5))
                    (betty-state (amb false true))
                    (ethel-state (amb false true))
                    (joan-state (amb false true))
                    (kitty-state (amb false true))
                    (mary-state (amb false true)))

                (require
                  (distinct? (list betty ethel joan kitty mary)))

                (say      betty-state  (lambda () (= kitty 2)))
                (say (not betty-state) (lambda () (= betty 3)))

                (say      ethel-state  (lambda () (= ethel 1)))
                (say (not ethel-state) (lambda () (= joan  2)))

                (say      joan-state   (lambda () (= joan  3)))
                (say (not joan-state)  (lambda () (= ethel 5)))

                (say      kitty-state  (lambda () (= kitty 2)))
                (say (not kitty-state) (lambda () (= mary  4)))

                (say      mary-state   (lambda () (= mary  4)))
                (say (not mary-state)  (lambda () (= betty 1)))

                (list (list 'Betty betty betty-state)
                      (list 'Ethel ethel ethel-state)
                      (list 'Joan joan joan-state)
                      (list 'Kitty kitty kitty-state)
                      (list 'Mary mary mary-state))
                )
              )


            (let ((answer (liars)))
              (print answer))

            ))
