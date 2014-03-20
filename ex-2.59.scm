;;;; Exercise 2.59.  Implement the union-set operation for the unordered-list
;;;; representation of sets.

;;; Copied from the text:

(define (element-of-set? x set)
  (cond [(null? set) #f]
        [(equal? x (car set)) #t]
        [else (element-of-set? x (cdr set))]))

(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))

(define (intersection-set set1 set2)
  (cond [(or (null? set1) (null? set2)) '()]
        [(element-of-set? (car set1) set2)        
         (cons (car set1)
               (intersection-set (cdr set1) set2))]
        [else (intersection-set (cdr set1) set2)]))

;;; Answer:

(define (union-set set1 set2)
  (cond [(null? set1) set2]
        [(null? set2) set1]
        [(element-of-set? (car set1) set2) (union-set (cdr set1) set2)]
        [else (cons (car set1) (union-set (cdr set1) set2))]))
