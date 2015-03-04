;;; Exercise 3.81.  Exercise 3.6 discussed generalizing the random-number
;;; generator to allow one to reset the random-number sequence so as to produce
;;; repeatable sequences of ``random'' numbers. Produce a stream formulation of
;;; this same generator that operates on an input stream of requests to
;;; generate a new random number or to reset the sequence to a specified value
;;; and that produces the desired stream of random numbers. Don't use
;;; assignment in your solution.

(load "./ex-3.6.scm")
(load "./sec-3.5.scm")

(define (rand requests)
  (define (generate-random-numbers seed)
    (define random-numbers
      (cons-stream seed
                   (stream-map rand-update random-numbers)))
    random-numbers)
  (define (dispatch requests numbers)
    (let ([r (stream-car requests)])
      (cond [(eq? r 'generate)
             (process requests numbers)]
            [(number? r)
             (process requests (stream-cdr (generate-random-numbers r)))]
            [else (error "Unknown request: " r)])))
  (define (process requests numbers)
    (cons-stream
      (stream-car numbers)
      (dispatch (stream-cdr requests) (stream-cdr numbers))))
  (define random-seed 0)
  (dispatch requests (generate-random-numbers random-seed)))




(define (stream-from-list xs)
  (define (go xs)
    (if (null? xs)
      the-empty-stream
      (cons-stream (car xs)
                   (go (cdr xs)))))
  (go xs))

(define (main args)
  (define requests '(1024 generate generate
                     1024 generate generate))
  (define ns (rand (stream-from-list requests)))
  (print (stream-ref ns 0) "\t" 423224377)
  (print (stream-ref ns 1) "\t" 1581628030)
  (print (stream-ref ns 2) "\t" 502725599)
  (print (stream-ref ns 3) "\t" 423224377)
  (print (stream-ref ns 4) "\t" 1581628030)
  (print (stream-ref ns 5) "\t" 502725599)
  )
