;;; Exercise 4.76.  Our implementation of `and` as a series combination of
;;; queries (figure 4.5) is elegant, but it is inefficient because in
;;; processing the second query of the `and` we must scan the data base for
;;; each frame produced by the first query. If the data base has N elements,
;;; and a typical query produces a number of output frames proportional to
;;; N (say N/k), then scanning the data base for each frame produced by the
;;; first query will require N2/k calls to the pattern matcher. Another
;;; approach would be to process the two clauses of the `and` separately, then
;;; look for all pairs of output frames that are compatible. If each query
;;; produces N/k output frames, then this means that we must perform N2/k2
;;; compatibility checks -- a factor of k fewer than the number of matches
;;; required in our current method.
;;;
;;; Devise an implementation of `and` that uses this strategy. You must
;;; implement a procedure that takes two frames as inputs, checks whether the
;;; bindings in the frames are compatible, and, if so, produces a frame that
;;; merges the two sets of bindings. This operation is similar to unification.

(load "./sec-4.4.4.scm")
(load "./sec-4.4.1-sample-db.scm")

(define test-queries-for-and '(
  ; TODO: Write.
  ))

(print "*** Results by the original AND")
(query-driver-loop-for-script test-queries-for-and)




(define (conjoin conjuncts frame-stream)
  ; TODO: Write.
  ;
  ; For empty conjuncts: the-empty-stream
  ; For single conjunct: results of qeval
  ; For two or more conjuncts: ...?
  )




(print "*** Results by the new AND")
(query-driver-loop-for-script test-queries-for-and)
