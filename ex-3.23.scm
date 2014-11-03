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

(define (make-dl-entry value)
  (list value '() '()))

(define dl-value car)
(define dl-next cadr)
(define dl-prev caddr)

(define (set-dl-next! dl-entry p*)
  (define p (cdr dl-entry))
  (set-car! p p*))
(define (set-dl-prev! dl-entry p*)
  (define p (cddr dl-entry))
  (set-car! p p*))




(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))




(define (make-deque)
  (cons '() '()))

(define (empty-deque? deque)
  (null? (front-ptr deque)))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (dl-value (front-ptr deque))))
(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an empty deque" deque)
      (dl-value (rear-ptr deque))))

(define (front-insert-deque! deque item)
  (let ([new-entry (make-dl-entry item)])
    (cond [(empty-deque? deque)
           (set-front-ptr! deque new-entry)
           (set-rear-ptr! deque new-entry)
           deque]
          [else
           (set-dl-next! new-entry (front-ptr deque))
           (set-dl-prev! (front-ptr deque) new-entry)
           (set-front-ptr! deque new-entry)
           deque])))
(define (rear-insert-deque! deque item)
  (let ([new-entry (make-dl-entry item)])
    (cond [(empty-deque? deque)
           (set-front-ptr! deque new-entry)
           (set-rear-ptr! deque new-entry)
           deque]
          [else
           (set-dl-prev! new-entry (rear-ptr deque))
           (set-dl-next! (rear-ptr deque) new-entry)
           (set-rear-ptr! deque new-entry)
           deque])))
(define (front-delete-deque! deque)
  (cond [(empty-deque? deque)
         (error "FRONT-DELETE! called with an empty deque" deque)]
        [else
         (set-front-ptr! deque (dl-next (front-ptr deque)))
         (if (null? (front-ptr deque))
           (set-rear-ptr! deque (front-ptr deque))
           (set-dl-prev! (front-ptr deque) '()))
         deque]))
(define (rear-delete-deque! deque)
  (cond [(empty-deque? deque)
         (error "REAR-DELETE! called with an empty deque" deque)]
        [else
         (set-rear-ptr! deque (dl-prev (rear-ptr deque)))
         (if (null? (rear-ptr deque))
           (set-front-ptr! deque (rear-ptr deque))
           (set-dl-next! (rear-ptr deque) '()))
         deque]))




(define (print-deque deque)
  (define (flatten deque)
    (let go ([acc '()]
             [dl (rear-ptr deque)])
      (if (null? dl)
        acc
        (go (cons (dl-value dl) acc)
            (dl-prev dl)))))
  (write (flatten deque))
  (newline))

(define dq (make-deque))
(print-deque dq)
;==> ()

(rear-insert-deque! dq 'a)
(print-deque dq)
;==> (a)

(rear-insert-deque! dq 'b)
(print-deque dq)
;==> (a b)

(rear-insert-deque! dq 'c)
(print-deque dq)
;==> (a b c)

(front-delete-deque! dq)
(print-deque dq)
;==> (b c)

(front-delete-deque! dq)
(print-deque dq)
;==> (c)

(front-delete-deque! dq)
(print-deque dq)
;==> ()

(front-insert-deque! dq 'x)
(print-deque dq)
;==> (x)

(front-insert-deque! dq 'y)
(print-deque dq)
;==> (y x)

(front-insert-deque! dq 'z)
(print-deque dq)
;==> (z y x)

(rear-delete-deque! dq)
(print-deque dq)
;==> (z y)

(rear-delete-deque! dq)
(print-deque dq)
;==> (z)

(rear-delete-deque! dq)
(print-deque dq)
;==> ()
