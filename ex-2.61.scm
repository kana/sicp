;;; Exercise 2.61.
;;;
;;; Give an implementation of adjoin-set using the ordered representation.

(define (adjoin-set x set)
  (if (null? set)
    (list x)
    (let ([x1 (car set)])
      (cond [(= x x1) set]
            [(< x x1) (cons x set)]
            [(< x1 x) (cons x1 (adjoin-set x (cdr set)))]))))


;;; By analogy with element-of-set? show how to take advantage of the ordering
;;; to produce a procedure that requires on the average about half as many
;;; steps as with the unordered representation.

; If the item we want to add is the P-th item of the resulting set, the number
; of steps required is P.  Because we can reuse the items after the P-th item,
; but we have to cons each item before the P-th item and the P-th item itself
; to prepend them to the reused items.
;
; So that the average number of steps required will be about n/2.
