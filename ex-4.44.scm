;;; Exercise 4.44.  Exercise 2.42 described the ``eight-queens puzzle'' of
;;; placing queens on a chessboard so that no two attack each other. Write
;;; a nondeterministic program to solve this puzzle.

(load "./sec-4.3.3.scm")

(ambtest '(begin

            (define (valid? qs)
              (if (null? qs)
                true
                (and (valid-one? (car qs) (cdr qs) 1)
                     (valid? (cdr qs)))))

            (define (valid-one? q qs offset)
              (if (null? qs)
                true
                (and (not (= q    (car qs)        ))
                     (not (= q (+ (car qs) offset)))
                     (not (= q (- (car qs) offset)))
                     (valid-one? q (cdr qs) (+ offset 1)))
                ))

            (define (eight-queen)
              (let ((q1 (amb 1 2 3 4 5 6 7 8))
                    (q2 (amb 1 2 3 4 5 6 7 8))
                    (q3 (amb 1 2 3 4 5 6 7 8))
                    (q4 (amb 1 2 3 4 5 6 7 8))
                    (q5 (amb 1 2 3 4 5 6 7 8))
                    (q6 (amb 1 2 3 4 5 6 7 8))
                    (q7 (amb 1 2 3 4 5 6 7 8))
                    (q8 (amb 1 2 3 4 5 6 7 8)))
                (let ((qs (list q1 q2 q3 q4 q5 q6 q7 q8)))
                  (require (valid? qs))
                  qs
                  )))

            (print (eight-queen))

            ))
