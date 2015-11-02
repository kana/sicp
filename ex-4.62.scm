;;; Exercise 4.62.  Define rules to implement the last-pair operation of
;;; exercise 2.17, which returns a list containing the last element of
;;; a nonempty list. Check your rules on queries such as (last-pair (3) ?x),
;;; (last-pair (1 2 3) ?x), and (last-pair (2 ?x) (3)). Do your rules work
;;; correctly on queries such as (last-pair ?x (3)) ?

(load "./sec-4.4.4.scm")
(load "./sec-4.4.1-sample-db.scm")

(query-driver-loop-for-script '(

  (assert! (rule (last-pair ?x ?x)
                 (same ?x (?e . ()))))
  (assert! (rule (last-pair (?z . ?y) ?x)
                 (last-pair ?y ?x)))

  (last-pair (3) ?x)
  ; ==> (last-pair (3) (3))

  (last-pair (1 2 3) ?x)
  ; ==> (last-pair (1 2 3) (3))

  (last-pair (2 ?x) (3))
  ; ==> (last-pair (2 3) (3))

  ; (last-pair ?x (3))
  ; ==> ...?  There are infinite instances.

  ))
