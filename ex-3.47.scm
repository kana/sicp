;;; Exercise 3.47.  A semaphore (of size n) is a generalization of a mutex.
;;; Like a mutex, a semaphore supports acquire and release operations, but it
;;; is more general in that up to n processes can acquire it concurrently.
;;; Additional processes that attempt to acquire the semaphore must wait for
;;; release operations. Give implementations of semaphores

;;; a. in terms of mutexes

(define (make-semaphore n)
  (let ([mutex (make-mutex)]
        [c 0])
    (define (acquire)
      (mutex 'acquire)
      (cond [(< c n)
             (set! c (+ c 1))
             (mutex 'release)]
            [else
              (mutex 'release)
              (acquire)]))
    (define (release)
      (mutex 'acquire)
      (if (<= 1 c)
        (set! c (- c 1))
        (error "This semaphore is not acquired yet"))
      (mutex 'release))
    (define (dispatch m)
      (cond [(eq? m 'acquire) (acquire)]
            [(eq? m 'release) (release)]
            [else (error "Unknown message sent to a semaphore" m)]))
    dispatch))




;;; b. in terms of atomic test-and-set! operations.

(define (make-semaphore n)
  (let ([cell (list #f)]
        [c 0])
    (define (acquire)
      (if (test-and-set! cell)
        (acquire)
        (cond [(< c n)
               (set! c (+ c 1))
               (clear!)]
              [else
                (clear!)
                (acquire)])))
    (define (release)
      (cond [(test-and-set! cell)
             (release)]
            [else
              (if (<= 1 c)
                (set! c (- c 1))
                (error "This semaphore is not acquired yet"))
              (clear!)])
    (define (dispatch m)
      (cond [(eq? m 'acquire) (acquire)]
            [(eq? m 'release) (release)]
            [else (error "Unknown message sent to a semaphore" m)]))
    dispatch))
