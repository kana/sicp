;;; Exercise 3.17.  Devise a correct version of the `count-pairs` procedure of
;;; exercise 3.16 that returns the number of distinct pairs in any structure.
;;; (Hint: Traverse the structure, maintaining an auxiliary data structure that
;;; is used to keep track of which pairs have already been counted.)

(define (wrong-count-pairs x)
  (if (not (pair? x))
      0
      (+ (wrong-count-pairs (car x))
         (wrong-count-pairs (cdr x))
         1)))

; With set!.
(define (count-pairs x)
  (define visited '())
  (define (go x)
    (if (and (pair? x) (not (memq x visited)))
      (begin
        (set! visited (cons x visited))
        (+ (go (car x))
           (go (cdr x))
           1))
      0))
  (go x))

; Without set!.
(define (count-pairs x)
  (car
    (let go ([x x]
             [visited '()])
      (if (and (pair? x) (not (memq x visited)))
        (let* ([p-car (go (car x) (cons x visited))]
               [p-cdr (go (cdr x) (cdr p-car))])
          (cons (+ (car p-car) (car p-cdr) 1) (cdr p-cdr)))
        (cons 0 visited)))))




(load "./sec-3.3-sample-lists.scm")

(print (zap z3) " ==> " (count-pairs z3) " vs " (wrong-count-pairs z3))
(print (zap z4) " ==> " (count-pairs z4) " vs " (wrong-count-pairs z4))
(print (zap z7) " ==> " (count-pairs z7) " vs " (wrong-count-pairs z7))
(print (zap z*) " ==> " (count-pairs z*) " vs " "...")
