;;; Exercise 3.6.  It is useful to be able to reset a random-number generator
;;; to produce a sequence starting from a given value. Design a new rand
;;; procedure that is called with an argument that is either the symbol
;;; generate or the symbol reset and behaves as follows: (rand 'generate)
;;; produces a new random number; ((rand 'reset) <new-value>) resets the
;;; internal state variable to the designated <new-value>. Thus, by resetting
;;; the state, one can generate repeatable sequences. These are very handy to
;;; have when testing and debugging programs that use random numbers.

(define (rand-update x)
  (let ([m (expt 2 31)]
        [a 1103515245]
        [b 12345])
    (mod (+ (* a x) b) m)))

(define rand
  (let ([x 0])
    (lambda (message)
      (cond [(eq? message 'generate)
             (set! x (rand-update x))
             x]
            [(eq? message 'reset)
             (lambda (new-value)
               (set! x new-value))]
            [else
              (error "Unknown message for RAND: " message)]))))

((rand 'reset) 1024)
(print (rand 'generate))
;=> 423224377
(print (rand 'generate))
;=> 1581628030
(print (rand 'generate))
;=> 502725599

((rand 'reset) 1024)
(print (rand 'generate))
;=> 423224377
(print (rand 'generate))
;=> 1581628030
(print (rand 'generate))
;=> 502725599
