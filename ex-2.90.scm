;;; Exercise 2.90.  Suppose we want to have a polynomial system that is
;;; efficient for both sparse and dense polynomials. One way to do this is to
;;; allow both kinds of term-list representations in our system. The situation
;;; is analogous to the complex-number example of section 2.4, where we allowed
;;; both rectangular and polar representations. To do this we must distinguish
;;; different types of term lists and make the operations on term lists
;;; generic. Redesign the polynomial system to implement this generalization.
;;; This is a major effort, not a local change.


;; Redefine operations for terms and term lists.

; Nothing has changed for procedures to manipulate terms.  Becasue the
; representation of terms is the same for both representations of term lists.
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

; Accessors and the predicate for term lists must be generic operations.
(define (first-term term-list) (apply-generic 'first-term term-list))
(define (rest-terms term-list) (apply-generic 'rest-terms term-list))
(define (empty-termlist? term-list) (apply-generic 'empty-termlist? term-list))

; THE-EMPTY-TERMLIST makes a term list, so its result must be tagged as
; "sparse" or "dense".  But it takes no argument.  For ease of implementation
; and for compatibility with existing code such as ADD-TERMS, here I assume
; that THE-EMPTY-TERMLIST always returns a value in the sparse representation.
(define (the-empty-termlist)
  ((get 'the-empty-termlist 'sparse-termlist)))

; ADJOIN-TERM takes takes TERM and TERM-LIST.  While TERM-LIST might be formed
; in one of the two representations, TERM is always formed in the only one
; representation.  To simplify implementation, I chose not to tag terms.  So
; that ADJOIN-TERM cannot be implemented as a simple wrapper of APPLY-GENERIC,
; like FIRST-TERM and others.  Given arguments must be manually "dispatched" to
; a right procedure.
(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list))
   term
   (contents term-list)))


;; Implement the generic operations for the "sparse" representation.

; TODO


;; Implement the generic operations for the "dense" representation.

; TODO
