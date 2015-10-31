(load "./sec-4.4.4.scm")
(load "./sec-4.4.1-sample-db.scm")

(query-driver-loop-for-script '(

;;; Exercise 5.61.  The following rules implement a next-to relation that finds
;;; adjacent elements of a list:

  (assert! (rule (?x next-to ?y in (?x ?y . ?u))))

  (assert! (rule (?x next-to ?y in (?v . ?z))
                 (?x next-to ?y in ?z)))

;;; What will the response be to the following queries?
;;;
;;;     (?x next-to ?y in (1 (2 3) 4))
;;;
;;;     (?x next-to 1 in (2 1 3 1))

  (?x next-to ?y in (1 (2 3) 4))
  ; ==> (1 next-to (2 3) in (1 (2 3) 4))
  ;     ((2 3) next-to 4 in (1 (2 3) 4))

  (?x next-to 1 in (2 1 3 1))
  ; ==> (2 next-to 1 in (2 1 3 1))
  ;     (3 next-to 1 in (2 1 3 1))

  ))
