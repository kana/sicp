; Exercise 1.3.  Define a procedure that takes three numbers as arguments and
; returns the sum of the squares of the two larger numbers.

(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (f a b c)
  (cond ((and (<= a b) (<= a c)) (sum-of-squares b c))
        ((and (<= b a) (<= b c)) (sum-of-squares a c))
        ((and (<= c a) (<= c b)) (sum-of-squares a b))))

(define (expect args expected)
  (define actual (apply f args))
  (for-each display
    (list
      "Expect " `(f ,@args) " to be evaluated to " expected ".\n"
      "Actual value is ... " actual ".\n"
      (if (= actual expected) "Okay" "Failed") ".\n"
      "\n")))

(expect '(1 2 3) 13)
(expect '(2 1 4) 20)
(expect '(6 4 1) 52)
(expect '(8 1 1) 65)
(expect '(2 8 2) 68)
(expect '(3 3 8) 73)
(expect '(5 5 5) 50)
