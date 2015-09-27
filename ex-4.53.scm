;;; Exercise 4.53.  With permanent-set! as described in exercise 4.51 and
;;; if-fail as in exercise 4.52, what will be the result of evaluating
;;;
;;;     (let ((pairs '()))
;;;       (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
;;;                  (permanent-set! pairs (cons p pairs))
;;;                  (amb))
;;;                pairs))

(load "./ex-4.51.scm")
(load "./ex-4.52.scm")

(define (main args)
  (ambtest `(begin

              (define (square x)
                (* x x))

              (define (smallest-divisor n)
                (find-divisor n 2))
              (define (find-divisor n test-divisor)
                (cond ((> (square test-divisor) n) n)
                      ((divides? test-divisor n) test-divisor)
                      (else (find-divisor n (+ test-divisor 1)))))
              (define (divides? a b)
                (= (remainder b a) 0))
              (define (prime? n)
                (= n (smallest-divisor n)))

              (define (an-element-of items)
                (require (not (null? items)))
                (amb (car items) (an-element-of (cdr items))))

              (define (prime-sum-pair list1 list2)
                (let ((a (an-element-of list1))
                      (b (an-element-of list2)))
                  (require (prime? (+ a b)))
                  (list a b)))

              (define (test)
                (let ((pairs '()))
                  (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
                             (permanent-set! pairs (cons p pairs))
                             (amb))
                           pairs)))
              (print (test))

              ))
  )

; Output:
; ------------------------------------------------------------
; ((8 35) (3 110) (3 20))
; *** No more values ***
; ------------------------------------------------------------
