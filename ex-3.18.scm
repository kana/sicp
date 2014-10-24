;;; Exercise 3.18.  Write a procedure that examines a list and determines
;;; whether it contains a cycle, that is, whether a program that tried to find
;;; the end of the list by taking successive cdrs would go into an infinite
;;; loop. Exercise 3.13 constructed such lists.

; With set!.
(define (circular? x)
  (define visited '())
  (define (go x)
    (if (pair? x)
      (if (memq x visited)
        #t
        (begin
          (set! visited (cons x visited))
          (go (cdr x))))
      #f))
  (go x))

; Without set!.
(define (circular? x)
  (let go ([x x]
           [visited '()])
    (if (pair? x)
      (if (memq x visited)
        #t
        (go (cdr x) (cons x visited)))
      #f)))




(load "./sec-3.3-sample-lists.scm")

(define (check x)
  (print (zap x) " ==> " (circular? x)))
(check z3)
(check z4)
(check z7)
(check z*)
