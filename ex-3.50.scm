;;; Exercise 3.50.  Complete the following definition, which generalizes
;;; stream-map to allow procedures that take multiple arguments, analogous to
;;; map in section 2.2.3, footnote 12.
;;;
;;; (define (stream-map proc . argstreams)
;;;   (if (<??> (car argstreams))
;;;       the-empty-stream
;;;       (<??>
;;;        (apply proc (map <??> argstreams))
;;;        (apply stream-map
;;;               (cons proc (map <??> argstreams))))))

(load "./sec-3.5.scm")

(define (stream-map proc . argstreams)
  (if (any stream-null? argstreams)
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define s
  (stream-map
    (lambda (x y) (+ (* x 2) (* y 3)))
    (stream-enumerate-interval 5 8)
    (stream-enumerate-interval 10 20)
    ))
(print s)
(display-stream s)
