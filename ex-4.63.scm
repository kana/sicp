;;; Exercise 4.63.  The following data base (see Genesis 4) traces the
;;; genealogy of the descendants of Ada back to Adam, by way of Cain:
;;;
;;;     (son Adam Cain)
;;;     (son Cain Enoch)
;;;     (son Enoch Irad)
;;;     (son Irad Mehujael)
;;;     (son Mehujael Methushael)
;;;     (son Methushael Lamech)
;;;     (wife Lamech Ada)
;;;     (son Ada Jabal)
;;;     (son Ada Jubal)
;;;
;;; Formulate rules such as ``If S is the son of F, and F is the son of G, then
;;; S is the grandson of G'' and ``If W is the wife of M, and S is the son of
;;; W, then S is the son of M'' (which was supposedly more true in biblical
;;; times than today) that will enable the query system to find the grandson of
;;; Cain; the sons of Lamech; the grandsons of Methushael. (See exercise 4.69
;;; for some rules to deduce more complicated relationships.)

(load "./sec-4.4.4.scm")
(load "./sec-4.4.1-sample-db.scm")

(query-driver-loop-for-script '(

  (assert! (son Adam Cain))
  (assert! (son Cain Enoch))
  (assert! (son Enoch Irad))
  (assert! (son Irad Mehujael))
  (assert! (son Mehujael Methushael))
  (assert! (son Methushael Lamech))
  (assert! (wife Lamech Ada))
  (assert! (son Ada Jabal))
  (assert! (son Ada Jubal))

  (assert! (rule (grandson ?g ?s)
                 (and (son$ ?g ?f)
                      (son$ ?f ?s))))
  (assert! (rule (son$ ?m ?s)
                 (or (son ?m ?s)
                     (and (wife ?m ?w)
                          (son$ ?w ?s)))))

  (grandson Cain ?x)
  ; ==> (grandson Cain Irad)

  (son$ Lamech ?x)
  ; ==> (son$ Lamech Jabal)
  ;     (son$ Lamech Jubal)

  (grandson Methushael ?x)
  ; ==> (grandson Methushael Jabal)
  ;     (grandson Methushael Jubal)

  ))
