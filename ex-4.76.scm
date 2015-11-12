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
  ; TODO: Write a proper query.
  (and (job ?person (?division . ?person-job))
       (supervisor ?person ?supervisor)
       (not (job ?supervisor (?division . ?supervisor-job))))
  ))

(print "*** Results by the original AND")
(query-driver-loop-for-script test-queries-for-and)




(define (conjoin conjuncts frame-stream)
  (define (compatible-frames? f1 f2)
    (every (lambda (b1)
             (let ((b2 (binding-in-frame (binding-value b1) f2)))
               (if b2
                 (equal? (binding-value b1) (binding-value b2))
                 #t)))
           f1))
  (define (merge-compatible-frames f1 f2)
    (let go ((bindings f1)
             (merged-frame f2))
      (if (null? bindings)
        merged-frame
        (let* ((b (car bindings))
               (variable (binding-variable b))
               (value (binding-value b)))
          (go (cdr bindings)
              (if (binding-in-frame variable merged-frame)
                merged-frame
                (extend-frame variable value merged-frame)))))))
  (define (merge-compatible-frame-streams fs1 fs2)
    (stream-map
      (lambda (fp)
        (merge-compatible-frames (car fp) (cdr fp)))
      (stream-filter
        (lambda (fp)
          (compatible-frames? (car fp) (cdr fp)))
        (stream-flatmap
          (lambda (f1)
            (stream-map
              (lambda (f2)
                (cons f1 f2))
              fs2))
          fs1))))
  (if (empty-conjunction? conjuncts)
    frame-stream
    (let ((new-frame-stream (qeval (first-conjunct conjuncts) frame-stream)))
      (merge-compatible-frame-streams
        new-frame-stream
        (conjoin (rest-conjuncts conjuncts) frame-stream)))))




(print "*** Results by the new AND")
(query-driver-loop-for-script test-queries-for-and)
