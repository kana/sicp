;;; Exercise 2.60.
;;;
;;; We specified that a set would be represented as a list with no duplicates.
;;; Now suppose we allow duplicates. For instance, the set {1,2,3} could be
;;; represented as the list (2 3 2 1 3 2 2).
;;;
;;; Design procedures element-of-set?, adjoin-set, union-set, and
;;; intersection-set that operate on this representation.
;;;
;;; How does the efficiency of each compare with the corresponding procedure
;;; for the non-duplicate representation?

; Since element-of-set? needs to scan the entire set to check whether an x is
; in the set or not, the implementation for the duplicate representation is the
; same as the one for the non-duplicate representation.
;
; So that the efficiency of element-of-set? is not changed; it is O(n).
(define (element-of-set? x set)
  (cond [(null? set) #f]
        [(equal? x (car set)) #t]
        [else (element-of-set? x (cdr set))]))

; With the duplicate representation, we don't have to check whether a set
; contains an x or not before adding the x into the set.  So that we can simply
; cons them to make a resulting set.  Therefore, the efficiency is changed from
; O(n) to O(1).
(define (adjoin-set x set)
  (cons x set))

; Similar to adjoin-set, union-set don't have to check duplicates too.  But
; union-set needs to concatenate lists.  So that we have to use append, and the
; efficiency of append is O(n).  Therefore, the efficiency is changed from
; O(n^2) to O(n).

(define (union-set set1 set2)
  (append set1 set2))

; Like element-of-set?, intersection-set needs to scan set2 for each element in
; set1 to find common elements.  So that the implementation is the same as the
; one for the non-duplicate representation.  The efficiency is not changed; it
; is O(n^2).
(define (intersection-set set1 set2)
  (cond [(or (null? set1) (null? set2)) '()]
        [(element-of-set? (car set1) set2)        
         (cons (car set1)
               (intersection-set (cdr set1) set2))]
        [else (intersection-set (cdr set1) set2)]))




;;; Are there applications for which you would use this representation in
;;; preference to the non-duplicate one?

; It depends on how many times each operation is used.
;
; * For applications like spell checkers, the most frequent operation is to
;   check whether a given word is in a dictionary.  This operation might be
;   implemented with element-of-set? like (element-of-set? word dictionary).
;   So that the efficiency of element-of-set? is the most important.  Though
;   the implementation of element-of-set? is the same for both representations,
;   sizes of sets in the non-duplicate representation are usually smaller than
;   the ones in the duplicate representation.  Therefore, the non-duplicate
;   representation should be used rather than the duplicate representation.
; * For applications which mainly log activities of something and rarely
;   analyze recorded activities, the most frequent operation is to record each
;   activity.  This operation might be implemented with adjoin-set like
;   (adjoin-set new-activity log).  So that the efficiency of adjoin-set is the
;   most important.  In this case, the duplicate representation is better than
;   the non-duplicate representation.
