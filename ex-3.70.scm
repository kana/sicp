(load "./sec-3.5.scm")

;;; Exercise 3.70.  It would be nice to be able to generate streams in which
;;; the pairs appear in some useful order, rather than in the order that
;;; results from an ad hoc interleaving process. We can use a technique similar
;;; to the merge procedure of exercise 3.56, if we define a way to say that one
;;; pair of integers is ``less than'' another. One way to do this is to define
;;; a ``weighting function'' W(i,j) and stipulate that (i1,j1) is less than
;;; (i2,j2) if W(i1,j1) < W(i2,j2).

;;; Write a procedure merge-weighted that is like merge, except that
;;; merge-weighted takes an additional argument weight, which is a procedure
;;; that computes the weight of a pair, and is used to determine the order in
;;; which elements should appear in the resulting merged stream. [69]

(define (merge-weighted s1 s2 weight)
  (cond [(stream-null? s1) s2]
        [(stream-null? s2) s1]
        [else
         (let* ([s1car (stream-car s1)]
                [s2car (stream-car s2)]
                [w1 (weight s1car)]
                [w2 (weight s2car)])
           (cond [(< w1 w2)
                  (cons-stream s1car
                               (merge-weighted (stream-cdr s1) s2 weight))]
                 [(> w1 w2)
                  (cons-stream s2car
                               (merge-weighted s1 (stream-cdr s2) weight))]
                 [else
                  (cons-stream s1car
                               (cons-stream s2car
                                            (merge-weighted (stream-cdr s1)
                                                            (stream-cdr s2)
                                                            weight)))]))]))

;;; Using this, generalize pairs to a procedure weighted-pairs that takes two
;;; streams, together with a procedure that computes a weighting function, and
;;; generates the stream of pairs, ordered according to weight.

(define (weighted-pairs s1 s2 weight)
  (cons-stream
    (list (stream-car s1) (stream-car s2))
    (merge-weighted
      (stream-map (lambda (s2j) (list (stream-car s1) s2j))
                  (stream-cdr s2))
      (weighted-pairs (stream-cdr s1) (stream-cdr s2) weight)
      weight)))

;;; Use your procedure to generate

;;; a. the stream of all pairs of positive integers (i,j) with i < j ordered
;;; according to the sum i + j

(define sa (weighted-pairs integers integers (lambda (ij) (apply + ij))))
(print "sa ==>")
(do ((i 0 (+ i 1)))
  ((= i 10))
  (print (stream-ref sa i)))

;;; b. the stream of all pairs of positive integers (i,j) with i < j, where
;;; neither i nor j is divisible by 2, 3, or 5, and the pairs are ordered
;;; according to the sum 2 i + 3 j + 5 i j.

(define not235s (stream-filter
                  (lambda (n) (and (not (= (mod n 2) 0))
                                   (not (= (mod n 3) 0))
                                   (not (= (mod n 5) 0))))
                  integers))
(define sb (weighted-pairs not235s
                           not235s
                           (lambda (ij)
                             (+ (* 2 (car ij))
                                (* 3 (cadr ij))
                                (* 5 (car ij) (cadr ij))))))
(print "sb ==>")
(do ((i 0 (+ i 1)))
  ((= i 30))
  (print (stream-ref sb i)))
