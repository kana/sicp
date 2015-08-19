;;; Exercise 4.28.  Eval uses actual-value rather than eval to evaluate the
;;; operator before passing it to apply, in order to force the value of the
;;; operator. Give an example that demonstrates the need for this forcing.

; Suppose that RANDOM returns a random number between [0, 1).
(define (choose-random . args)
  (let go ((args args)
           (i 1)
           (chosen #f))
    (if (null? args)
      chosen
      (go
        (cdr args)
        (+ i 1)
        (if (= (* i (random)) 0)
          (car args)
          chosen)))))

; Without forcing, eval uses a thunk as a operator.
((choose-random + - * /) 123 456)
