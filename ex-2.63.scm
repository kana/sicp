(load "./sec-2.3.3-sets-as-binary-trees.scm")

;;; Exercise 2.63.
;;;
;;; Each of the following two procedures converts a binary tree to a list.

(define (tree->list-1 tree)
  (if (null? tree)
    '()
    (append (tree->list-1 (left-branch tree))
            (cons (entry tree)
                  (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
      result-list
      (copy-to-list (left-branch tree)
                    (cons (entry tree)
                          (copy-to-list (right-branch tree)
                                        result-list)))))
  (copy-to-list tree '()))

;;; a. Do the two procedures produce the same result for every tree?
;;; If not, how do the results differ?

; tree->list-1 converts a given binary tree with the following steps:
;
; (1) Flatten the left branch,
; (2) Flatten the right branch,
; (3) Prepend the entry to the flattened right branch,
; (4) Then concatenate (1) and (3).
;
; tree->list-2 converts a given binary tree with the following steps:
;
; (1) Visit each node from right to left,
; (2) Accumulate visited nodes.
;
; Both procedures convert a binary tree with different strategies, but both
; accumulate nodes from right to left.  So that both produce the same result
; for every tree.

;;; What lists do the two procedures produce for the trees in figure 2.16?

;;;         7           3              5
;;;        / \         / \            / \
;;;       3   9       1   7          3   9
;;;      / \   \         / \        /   / \
;;;     1   5  11       5   9      1   7  11
;;;                          \
;;;                          11
;;;
;;; Figure 2.16: Various binary trees that represent the set {1,3,5,7,9,11}.

(define figure-2.16-a
  (make-tree 7
             (make-tree 3
                        (make-tree 1 '() '())
                        (make-tree 5 '() '()))
             (make-tree 9
                        '()
                        (make-tree 11 '() '()))))

(define figure-2.16-b
  (make-tree 3
             (make-tree 1 '() '())
             (make-tree 7
                        (make-tree 5 '() '())
                        (make-tree 9
                                   '()
                                   (make-tree 11 '() '())))))

(define figure-2.16-c
  (make-tree 5
             (make-tree 3
                        (make-tree 1 '() '())
                        '())
             (make-tree 9
                        (make-tree 7 '() '())
                        (make-tree 11 '() '()))))

(define-syntax check
  (syntax-rules ()
                [(check expr)
                 (print 'expr " ==> " expr)]))

(check figure-2.16-a)
; figure-2.16-a ==> (7 (3 (1 () ()) (5 () ())) (9 () (11 () ())))
(check figure-2.16-b)
; figure-2.16-b ==> (3 (1 () ()) (7 (5 () ()) (9 () (11 () ()))))
(check figure-2.16-c)
; figure-2.16-c ==> (5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ())))

(check (tree->list-1 figure-2.16-a))
; (tree->list-1 figure-2.16-a) ==> (1 3 5 7 9 11)
(check (tree->list-1 figure-2.16-b))
; (tree->list-1 figure-2.16-b) ==> (1 3 5 7 9 11)
(check (tree->list-1 figure-2.16-c))
; (tree->list-1 figure-2.16-c) ==> (1 3 5 7 9 11)

(check (tree->list-2 figure-2.16-a))
; (tree->list-2 figure-2.16-a) ==> (1 3 5 7 9 11)
(check (tree->list-2 figure-2.16-b))
; (tree->list-2 figure-2.16-b) ==> (1 3 5 7 9 11)
(check (tree->list-2 figure-2.16-c))
; (tree->list-2 figure-2.16-c) ==> (1 3 5 7 9 11)

; (define figure-2.17
;   (make-tree 1 '()
;     (make-tree 2 '()
;       (make-tree 3 '()
;         (make-tree 4 '()
;           (make-tree 5 '()
;             (make-tree 6 '()
;               (make-tree 7 '() '()))))))))
; (check (tree->list-1 figure-2.17))
; (check (tree->list-2 figure-2.17))

;;; b. Do the two procedures have the same order of growth in the number of
;;; steps required to convert a balanced tree with n elements to a list?  If
;;; not, which one grows more slowly?

; No.  tree->list-1 is slower than tree->list-2.
;
; tree->list-1 uses APPEND to concatenate flattend branches, and (append list1
; list2) makes a resulting list by prepending each item in list1 to list2 by
; CONS.  So that APPEND is O(n).  Suppose that a balanced binary tree with
; N nodes is given to tree->list-1.
;
; * Each node has a left branch,
; * Each i-th depth node has a left branch with N/(2^i) nodes.
;   (note that i=1 for the root node)
; * The number of i-th nodes is estimated to 2^(i-1).
;
; So that the number of CONS operations to tree->list-1 is:
;
;   sum_{i=1}^{log_2 N} 2^(i-1) * N/(2^i)
; = sum_{i=1}^{log_2 N} N/2
; = (log_2 N) * N/2
;
; Therefore, tree->list-1 is O(N log N).
;
; While tree->list-2 uses only CONS each node from right to left.
; So that it is just O(N).
