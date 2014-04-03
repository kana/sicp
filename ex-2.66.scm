;;; Exercise 2.66.  Implement the lookup procedure for the case where the set
;;; of records is structured as a binary tree, ordered by the numerical values
;;; of the keys.

(load "./sec-2.3.3-sets-as-binary-trees.scm")

(define (make-record key value)
  (cons key value))

(define (key record)
  (car record))

(define (lookup given-key set-of-records)
  (if (null? set-of-records)
    #f
    (let* ([record (entry set-of-records)]
           [current-key (key record)])
      (cond
        [(= given-key current-key)
         record]
        [(< given-key current-key)
         (lookup given-key (left-branch set-of-records))]
        [else
          (lookup given-key (right-branch set-of-records))]))))

(define database
  (make-tree
    (make-record 5 'Fortran)
    (make-tree
      (make-record 3 'C++)
      (make-tree (make-record 1 'Ada) '() '())
      (make-tree (make-record 4 'Dylan) '() '()))
    (make-tree
      (make-record 7 'Haskell)
      (make-tree (make-record 6 'Go) '() '())
      (make-tree (make-record 9 'JavaScript) '() '()))))
(print database)
(map (lambda (i)
       (print "(lookup " i " database) ==> " (lookup i database)))
     '(0 1 2 3 4 5 6 7 8 9 10))
