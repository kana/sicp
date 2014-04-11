;;; Exercise 2.71.
;;;
;;; Suppose we have a Huffman tree for an alphabet of n symbols, and that the
;;; relative frequencies of the symbols are 1, 2, 4, ..., 2^(n-1).  Sketch the
;;; tree for n=5; for n=10.

(load "./ex-2.68.scm")
(load "./ex-2.69.scm")

(print "")
(print "Exercise 2.71:")

(define (nth-alphabet n)
  (string->symbol (string (integer->char (+ (char->integer #\A) n)))))

(for-each
  (^n
    (let* ([alphabet-frequencies (map (^i (list (nth-alphabet i) (expt 2 i)))
                                      (iota n))]
           [tree (generate-huffman-tree alphabet-frequencies)]
           )
      (print "")
      (print "n = " n)
      (print "alphabets = " alphabet-frequencies)
      (print "tree = " tree)
      ))
  '(5 10))

; The tree for n = 5 is as follows:
;
;                 (A B C D E)-31
;                   /     \
;            (A B C D)-15 E-16
;              /   \
;         (A B C)-7 D-8
;          /   \
;      (A B)-3 C-4
;       / \
;     A-1 B-2
;
; The tree for n = 10 is as follows:
;
;                                                   (A B C D E F G H I J)-1023
;                                                         /       \
;                                         (A B C D E F G H I)-511 J-512
;                                             /         \
;                                  (A B C D E F G H)-255 I-256
;                                      /       \
;                          (A B C D E F G)-127 H-128
;                              /     \
;                    (A B C D E F)-63 G-64
;                       /     \
;               (A B C D E)-31 F-32
;                 /     \
;           (A B C D)-15 E-16
;             /   \
;        (A B C)-7 D-8
;         /   \
;      (A B)-3 C-4
;       / \
;     A-1 B-2


;;; In such a tree (for general n) how many bits are required to encode the
;;; most frequent symbol?  the least frequent symbol?

; Only 1 bit is required to encode the most frequent symbol, while
; n-1 bits are required to encode the least frequent symbol.
