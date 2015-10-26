;;; Exercise 4.55.  Give simple queries that retrieve the following information
;;; from the data base:
;;;
;;; a. all people supervised by Ben Bitdiddle;
;;;
;;; b. the names and jobs of all people in the accounting division;
;;;
;;; c. the names and addresses of all people who live in Slumerville.

(load "./sec-4.4.4.scm")
(load "./sec-4.4.1-sample-db.scm")

(query-driver-loop-for-script '(

    ; a
    (supervisor ?person (Bitdiddle Ben))

    ; b
    (job ?name (accounting . ?type))

    ; c
    (address ?name (Slumerville . ?detail))

    ))
