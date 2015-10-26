;;; Exercise 4.56.  Formulate compound queries that retrieve the following
;;; information:
;;;
;;; a. the names of all people who are supervised by Ben Bitdiddle, together
;;; with their addresses;
;;;
;;; b. all people whose salary is less than Ben Bitdiddle's, together with
;;; their salary and Ben Bitdiddle's salary;
;;;
;;; c. all people who are supervised by someone who is not in the computer
;;; division, together with the supervisor's name and job.

(load "./sec-4.4.4.scm")
(load "./sec-4.4.1-sample-db.scm")

(query-driver-loop-for-script '(

  ; a
  (and (supervisor ?person (Bitdiddle Ben))
       (address ?person ?address))

  ; b
  (and (salary (Bitdiddle Ben) ?ben-salary)
       (salary ?who ?who-salary)
       (lisp-value < ?who-salary ?ben-salary))

  ; c
  (and (supervisor ?employee ?supervisor)
       (not (job ?supervisor (computer . ?job-detail)))
       (job ?supervisor ?supervisor-job))

  ))
