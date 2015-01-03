(load "./sec-3.5.scm")
(load "./ex-3.64.scm")

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define s (sqrt-stream 10))
(print "0.1      ==> " (sqrt 10 0.1))
(print "0.01     ==> " (sqrt 10 0.01))
(print "0.001    ==> " (sqrt 10 0.001))
(print "0.000001 ==> " (sqrt 10 0.000001))
