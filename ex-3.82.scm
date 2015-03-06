;;; Exercise 3.82.  Redo exercise 3.5 on Monte Carlo integration in terms of
;;; streams. The stream version of estimate-integral will not have an argument
;;; telling how many trials to perform. Instead, it will produce a stream of
;;; estimates based on successively more trials.

(load "./ex-3.5.scm")
(load "./sec-3.5.scm")

(define (monte-carlo experiment)
  (let go ([passed 0]
           [total 0])
    (let* ([r (experiment)]
           [passed (+ passed (if r 1 0))]
           [total (+ total 1)])
      (cons-stream
        (/ passed total)
        (go passed total)))))

(define (estimate-integral P x1 y1 x2 y2)
  (define (region-test)
    (let ([x (random-in-range x1 x2)]
          [y (random-in-range y1 y2)])
      (P x y)))
  (stream-map
    (lambda (ratio)
      (* (- x2 x1) (- y2 y1) ratio))
    (monte-carlo region-test)))




(define (stream-sample-every s n)
  (cons-stream
    (stream-car s)
    (stream-sample-every (stream-drop s n) n)))

(define (stream-take s n)
  (if (<= 1 n)
    (cons-stream
      (stream-car s)
      (stream-take (stream-cdr s) (- n 1)))
    the-empty-stream))

(define (stream-drop s n)
  (if (<= 1 n)
    (stream-drop (stream-cdr s) (- n 1))
    s))

(define (main args)
  (define results
    (stream-map exact->inexact
                (stream-sample-every
                  (estimate-integral
                    (lambda (x y) (<= (+ (* x x) (* y y)) (* 1 1)))
                    -1 -1
                    1 1)
                  10000)))
  (stream-for-each print (stream-take results 10)))
