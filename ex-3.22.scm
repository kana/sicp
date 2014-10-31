;;; Exercise 3.22.  Instead of representing a queue as a pair of pointers, we
;;; can build a queue as a procedure with local state. The local state will
;;; consist of pointers to the beginning and the end of an ordinary list. Thus,
;;; the make-queue procedure will have the form
;;;
;;;     (define (make-queue)
;;;       (let ((front-ptr ...)
;;;             (rear-ptr ...))
;;;         <definitions of internal procedures>
;;;         (define (dispatch m) ...)
;;;         dispatch))
;;;
;;; Complete the definition of make-queue and provide implementations of the
;;; queue operations using this representation.

(define (make-queue)
  (let ([front-ptr '()]
        [rear-ptr '()])
    (define (empty-queue?)
      (null? front-ptr))
    (define (front-queue)
      (cond [(empty-queue?)
             (error "FRONT-QUEUE called with an empty queue")]
            [else
             (car front-ptr)]))
    (define (insert-queue! item)
      (let ([new-pair (cons item '())])
        (cond [(empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)]
              [else
               (set-cdr! rear-ptr new-pair)
               (set! rear-ptr new-pair)])))
    (define (delete-queue!)
      (cond [(empty-queue?)
             (error "DELETE-QUEUE! called with an empty queue")]
            [else
             (set! front-ptr (cdr front-ptr))]))
    (define (dispatch m)
      (cond [(eq? m 'empty-queue?) empty-queue?]
            [(eq? m 'front-queue) front-queue]
            [(eq? m 'insert-queue!) insert-queue!]
            [(eq? m 'delete-queue!) delete-queue!]
            [else (error "Unknown message -- " m)]))
    dispatch))

(define q (make-queue))
((q 'insert-queue!) 'a)
((q 'insert-queue!) 'b)
((q 'insert-queue!) 'c)
(print q)
(print ((q 'front-queue)))
((q 'delete-queue!))
(print ((q 'front-queue)))
((q 'delete-queue!))
(print ((q 'front-queue)))
(print ((q 'empty-queue?)))
((q 'delete-queue!))
(print q)
(print ((q 'empty-queue?)))
