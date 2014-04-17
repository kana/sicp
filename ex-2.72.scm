;;; Exercise 2.72.
;;;
;;; Consider the encoding procedure that you designed in exercise 2.68.  What
;;; is the order of growth in the number of steps needed to encode a symbol?
;;; Be sure to include the number of steps needed to search the symbol list at
;;; each node encountered.
;;;
;;; To answer this question in general is difficult.  Consider the special case
;;; where the relative frequencies of the n symbols are as described in
;;; exercise 2.71, and give the order of growth (as a function of n) of the
;;; number of steps needed to encode the most frequent and least frequent
;;; symbols in the alphabet.

; The order to encode the most frequent symbol is O(N), because:
;
; * The most frequent symbol is in the right branch of the root of the tree,
;   and the branch is a leaf.
; * ENCODE-SYMBOL scans symbols of each branch to decide which branch to be
;   looked up for the next ENCODE-SYMBOL.  Since the symbol is in the right
;   branch, the number of symbols to be scanned is N.
;
; The order to encode the least frequent symbol is also O(N), because:
;
; * The least frequent symbol is in the most left branch of the tree.
;   So that ENCODE-SYMBOL drills down the tree N-1 times.
; * At i-th step, ENCODE-SYMBOL scans N-i symbols.
;   But the first symbol in each step is always the least frequent symbol.
;   So that memq ends in O(1).
