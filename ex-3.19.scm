;;; Exercise 3.19.  Redo exercise 3.18 using an algorithm that takes only
;;; a constant amount of space. (This requires a very clever idea.)

; Circular lists like z in Exercise 3.13 have loops.
; Taking successive CDRs of circular lists never ends.
; Likewise, taking successive CDDRs of circular lists never ends too.
; Once the former goes around a loop, the latter goes around the loop twice.
; These "visitors" eventually visit the same pair if a list is circular.
; Otherwise the latter visitor finishes taking CDDRs.
;
; So that we don't have to record already visited pairs to detect cycles.
; The two visitors are enought to detect cycles.

(define (circular? x)
  (define (next x)
    (if (pair? x)
      (cdr x)
      #f))
  (let go ([x1 x]
           [x2 (next x)])
    (if (and x1 x2)
      (if (eq? x1 x2)
        #t
        (go (next x1) (next (next x2))))
      #f)))




(load "./sec-3.3-sample-lists.scm")

(define (check x)
  (print (zap x) " ==> " (circular? x)))
(check z3)
(check z4)
(check z7)
(check z*)
(check (make-cycle (list #f #f #f)))
(check (cons #t #t))
(check (cons #f #f))
