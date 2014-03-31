;;; Exercise 2.65.  Use the results of exercises 2.63 and 2.64 to give O(n)
;;; implementations of union-set and intersection-set for sets implemented as
;;; (balanced) binary trees.

; Copied from "Sets as ordered lists".
(define (%intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1)) (x2 (car set2)))
      (cond [(= x1 x2)
             (cons x1
                   (%intersection-set (cdr set1)
                                     (cdr set2)))]
            [(< x1 x2)
             (%intersection-set (cdr set1) set2)]
            [(< x2 x1)
             (%intersection-set set1 (cdr set2))]))))

; Copied from ex-2.62.scm
(define (%union-set set1 set2)
  (cond [(null? set1) set2]
        [(null? set2) set1]
        [else
          (let ([x1 (car set1)]
                [x2 (car set2)])
            (cond ([= x1 x2]
                   (cons x1 (%union-set (cdr set1) (cdr set2))))
                  ([< x1 x2]
                   (cons x1 (%union-set (cdr set1) set2)))
                  ([< x2 x1]
                   (cons x2 (%union-set set1 (cdr set2))))))]))

(load "./ex-2.63.scm")
(define tree->list tree->list-2)

(load "./ex-2.64.scm")

(define (union-set set1 set2)
  (let ([list1 (tree->list set1)]
        [list2 (tree->list set2)])
    (list->tree (%union-set list1 list2))))

(define (intersection-set set1 set2)
  (let ([list1 (tree->list set1)]
        [list2 (tree->list set2)])
    (list->tree (%intersection-set list1 list2))))
