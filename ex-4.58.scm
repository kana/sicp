;;; Exercise 4.58.  Define a rule that says that a person is a ``big shot'' in
;;; a division if the person works in the division but does not have
;;; a supervisor who works in the division.

(load "./sec-4.4.4.scm")
(load "./sec-4.4.1-sample-db.scm")

(query-driver-loop-for-script '(

  (assert! (rule (big-shot ?person)
                 (and (job ?person (?division . ?person-job))
                      (supervisor ?person ?supervisor)
                      (not (job ?supervisor (?division . ?supervisor-job)))))) 

  (big-shot ?who)

  ))
