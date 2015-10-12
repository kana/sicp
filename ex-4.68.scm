;;; Exercise 4.68.  Define rules to implement the reverse operation of exercise
;;; 2.18, which returns a list containing the same elements as a given list in
;;; reverse order. (Hint: Use append-to-form.) Can your rules answer both
;;; (reverse (1 2 3) ?x) and (reverse ?x (1 2 3)) ?

(rule (reverse (?x) (?x)))
(rule (reverse (?x . (?y)) (?y . (?x))))
(rule (reverse (?x . ?y) (?a . ?b))
      ; TODO
      )
