;;; Exercise 4.58.  Define a rule that says that a person is a ``big shot'' in
;;; a division if the person works in the division but does not have
;;; a supervisor who works in the division.

(rule (big-shot ?person)
      (and (job ?person (?division . ?person-job))
           (supervisor ?who ?supervisor)
           (not (job ?supervisor (?division . ?supervisor-job)))))
