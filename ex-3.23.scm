;;; Exercise 3.23.  A deque (``double-ended queue'') is a sequence in which
;;; items can be inserted and deleted at either the front or the rear.
;;; Operations on deques are the constructor make-deque, the predicate
;;; empty-deque?, selectors front-deque and rear-deque, and mutators
;;; front-insert-deque!, rear-insert-deque!, front-delete-deque!, and
;;; rear-delete-deque!. Show how to represent deques using pairs, and give
;;; implementations of the operations. [23]  All operations should be
;;; accomplished in Θ(1) steps.

; The most problematic operation is rear-delete-deque!.  To implement this
; operation to accomplished in Θ(1) steps, the previous item of the last item
; in a deque must be fetched in constant time.  But it's not possible to do
; with ordinary lists, because ordinary lists are one-way.
;
; So here I use doubly-linked lists instead of ordinary lists.  Each entry in
; a doubly-linked list consists of 3 pointers to a value, the next entry and
; the previous entry.  For example, a doubly-linked list consists of symbols A,
; B and C can be drawn as follows:
;
;     [o] --> [o] --> [/]
;     [/] <-- [o] <-- [o]
;     [o]     [o]     [o]
;      |       |       |
;      v       v       v
;      A       B       C
;
; With doubly-linked lists, a deque can be implemented like a queue.
