;;; Exercise 4.57.  Define a rule that says that person 1 can replace person
;;; 2 if either person 1 does the same job as person 2 or someone who does
;;; person 1's job can also do person 2's job, and if person 1 and person 2 are
;;; not the same person. Using your rule, give queries that find the following:
;;;
;;; a.  all people who can replace Cy D. Fect;
;;;
;;; b.  all people who can replace someone who is being paid more than they
;;; are, together with the two salaries.

(load "./sec-4.4.4.scm")
(load "./sec-4.4.1-sample-db.scm")

(query-driver-loop-for-script '(

  (assert!
    (rule (can-replace ?person1 ?person2)
          (and (or (and (job ?person1 ?job1)
                        (job ?person2 ?job2)
                        (same ?job1 ?job2))
                   (and (job ?personx ?jobx)
                        (same ?jobx ?job1))
                   (same ?jobx ?job2))
               (not (same ?person1 ?person2)))))

  ; a
  (can-replace ?who (Fect Cy D))

  ; b
  (and (can-replace ?who ?someone)
       (salary ?who ?who-amount)
       (salary ?someone ?someone-amount)
       (lisp-value < ?who-amount ?someone-amount))

  ))
