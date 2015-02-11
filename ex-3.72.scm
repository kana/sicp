;;; Exercise 3.72.  In a similar way to exercise 3.71 generate a stream of all
;;; numbers that can be written as the sum of two squares in three different
;;; ways (showing how they can be so written).

(load "./sec-3.5.scm")
(load "./ex-3.70.scm")

(define (group-by s key)
  (let go ([s (stream-cdr s)]
           [w0 (key (stream-car s))]
           [es (list (stream-car s))])
    (if (= w0 (key (stream-car s)))
      (go (stream-cdr s)
          w0
          (cons (stream-car s) es))
      (cons-stream (cons w0 es)
                   (go (stream-cdr s)
                       (key (stream-car s))
                       (list (stream-car s)))))))

(define (s-numbers)
  (define (weight ij)
    (+ (square (car ij))
       (square (cadr ij))))
  (stream-filter (lambda (k-es)
                   (= (length (cdr k-es)) 3))
                 (group-by (weighted-pairs integers integers weight)
                           weight)))

(use util.match)
(do ([i 0 (+ i 1)]
     [s (s-numbers) (stream-cdr s)])
  ((= i 10))
  (match (stream-car s)
         [(sum (a1 b1) (a2 b2) (a3 b3))
          (format #t "~4d = ~2d^2 + ~2d^2 = ~2d^2 + ~2d^2 = ~2d^2 + ~2d^2\n"
                  sum a1 b1 a2 b2 a3 b3)]))
