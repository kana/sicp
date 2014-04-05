(load "./sec-2.3.4.scm")

;;; Exercise 2.67.
;;;
;;; Define an encoding tree and a sample message:

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree (make-leaf 'D 1)
                                    (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;;; Use the decode procedure to decode the message, and give the result.

(print sample-tree)
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
;
;   (A B D C)-8
;    /     \
;  A-4   (B D C)-4
;         /   \
;       B-2  (D C)-1
;              / \
;            D-1 C-1

(print sample-message)
; ==> (0 1 1 0 0 1 0 1 0 1 1 1 0)

(print (decode sample-message sample-tree))
; ==> (A  D  A  B  B  C  A)
;      0 110 0 10 10 111 0
