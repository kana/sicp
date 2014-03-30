(load "./sec-2.3.3-sets-as-binary-trees.scm")

;;; Exercise 2.64.
;;;
;;; The following procedure list->tree converts an ordered list to a balanced
;;; binary tree.  The helper procedure partial-tree takes as arguments an
;;; integer n and list of at least n elements and constructs a balanced tree
;;; containing the first n elements of the list.  The result returned by
;;; partial-tree is a pair (formed with cons) whose car is the constructed tree
;;; and whose cdr is the list of elements not included in the tree.

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

;;; a. Write a short paragraph explaining as clearly as you can how
;;; partial-tree works.

; To simplify description, suppose that a list given to partial-tree has 2N+1
; elements.  At first, partial-tree divides a given list into three segments;
; a left part (N elements), a center part (1 element) and a right part (N
; elements).  Then it converts the left and the right parts into balanced
; trees.  Finally, it makes a root node which has the center part as its entry
; and the partial trees as left and right branches.

;;; Draw the tree produced by list->tree for the list (1 3 5 7 9 11).

; (list->tree '(1 3 5 7 9 11))
; = (car (partial-tree '(1 3 5 7 9 11) 6))
;   left-size = 2
;   left-result = (partial-tree '(1 3 5 7 9 11) 2)
;                 ==> left-size = 0
;                     left-result = (() (1 3 5 7 9 11))
;                     right-size = 1
;                     this-entry = 1
;                     right-result = (partial-tree '(3 5 7 9 11) 1)
;                                    ==> left-size = 0
;                                        left-result = (() (3 5 7 9 11))
;                                        right-size = 0
;                                        this-entry = 3
;                                        right-result = (() (5 7 9 11))
;                                        ((3 () ()) (5 7 9 11))
;                     ((1 () (3 () ())) (5 7 9 11))
;   right-size = 3
;   this-entry = 5
;   right-result = (partial-tree '(7 9 11) 3)
;                  ==> left-size = 1
;                      left-result = (partial-tree '(7 9 11) 1)
;                                    ==> left-size = 0
;                                        left-result = (() (7 9 11))
;                                        right-size = 0
;                                        this-entry = 7
;                                        right-result = (() (9 11))
;                                        ((7 () ()) (9 11))
;                      right-size = 1
;                      this-entry = 9
;                      right-result = (partial-tree '(11) 1)
;                                     ==> left-size = 0
;                                         left-result = (() '(11))
;                                         right-size = 0
;                                         this-entry = 11
;                                         right-result = (() ())
;                                         ((11 () ()) ())
;                      ((9 (7 () ()) (11 () ())) ())
;   ((5 (1 () (3 () ())) (9 (7 () ()) (11 () ()))) ())
; = (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))
;
;       __5__
;      /     \
;     1       9
;      \     / \
;       3   7  11

;;; b. What is the order of growth in the number of steps required by
;;; list->tree to convert a list of n elements?

; Like tree->list-2 in Exercise 2.63, list->tree is O(N).  Because
;
; * list->tree scans each element in a given list only once.
; * list->tree makes a tree by constructing nodes from left to right.
; * partial-tree uses only operations which are O(1).
