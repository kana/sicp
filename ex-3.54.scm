(load "./sec-3.5.scm")

;;; Exercise 3.54.  Define a procedure mul-streams, analogous to add-streams,
;;; that produces the elementwise product of its two input streams. Use this
;;; together with the stream of integers to complete the following definition
;;; of the stream whose nth element (counting from 0) is n + 1 factorial:
;;;
;;;     (define factorials (cons-stream 1 (mul-streams <??> <??>)))

(define (mul-streams s1 s2)
  (if (or (stream-null? s1) (stream-null? s2))
    the-empty-stream
    (cons-stream (* (stream-car s1) (stream-car s2))
                 (mul-streams (stream-cdr s1) (stream-cdr s2)))))

(define factorials (cons-stream 1 (mul-streams factorials (stream-cdr integers))))

(print (stream-ref factorials 0))
(print (stream-ref factorials 1))
(print (stream-ref factorials 2))
(print (stream-ref factorials 3))
(print (stream-ref factorials 4))
(print (stream-ref factorials 5))
