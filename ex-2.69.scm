;;; Exercise 2.69.
;;;
;;; The following procedure takes as its argument a list of symbol-frequency
;;; pairs (where no symbol appears in more than one pair) and generates
;;; a Huffman encoding tree according to the Huffman algorithm.

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;;; Make-leaf-set is the procedure given above that transforms the list of
;;; pairs into an ordered set of leaves.  Successive-merge is the procedure you
;;; must write, using make-code-tree to successively merge the smallest-weight
;;; elements of the set until there is only one element left, which is the
;;; desired Huffman tree.  (This procedure is slightly tricky, but not really
;;; complicated. If you find yourself designing a complex procedure, then you
;;; are almost certainly doing something wrong.  You can take significant
;;; advantage of the fact that we are using an ordered set representation.)

(load "./sec-2.3.4.scm")

(define (successive-merge leaf-set)
  (if (null? (cdr leaf-set))
    (car leaf-set)
    (let ([leaf1 (car leaf-set)]
          [leaf2 (cadr leaf-set)]
          [rest (cddr leaf-set)])
      (successive-merge (adjoin-set (make-code-tree leaf1 leaf2) rest)))))

(print '((A 4) (B 2) (C 1) (D 1)))
; ==> ((A 4) (B 2) (C 1) (D 1))
(print (make-leaf-set '((A 4) (B 2) (C 1) (D 1))))
; ==> ((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 4))
(print (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))))
; ==> ((leaf A 4)
;      ((leaf B 2)
;       ((leaf D 1)
;        (leaf C 1)
;        (D C)
;        2)
;       (B D C)
;       4)
;      (A B D C)
;      8)

(print (generate-huffman-tree
         '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1))))
; ==> ((leaf A 8)
;      ((((leaf H 1) (leaf G 1) (H G) 2)
;        ((leaf F 1) (leaf E 1) (F E) 2)
;        (H G F E)
;        4)
;       (((leaf D 1) (leaf C 1) (D C) 2)
;        (leaf B 3)
;        (D C B)
;        5)
;       (H G F E D C B)
;       9)
;      (A H G F E D C B)
;      17)
;
;     (A H G F E D C B)-17
;       /           \
;     A-8     (H G F E D C B)-9
;             /             \
;       (H G F E)-4       (D C B)-5
;       /       \           /     \
;    (H G)-2   (F E)-2  (D C)-2  B-3
;     / \       / \      / \
;   H-1 G-1   F-1 E-1  D-1 C-1
;
; This huffman tree is equivalent to Figure 2.18.
