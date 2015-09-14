;;; Exercise 4.41.  Write an ordinary Scheme program to solve the multiple
;;; dwelling puzzle.

(define (multiple-dwelling)
  (define (distinct? items)
    (cond ((null? items) #t)
          ((null? (cdr items)) #t)
          ((member (car items) (cdr items)) #f)
          (else (distinct? (cdr items)))))
  (define (check baker cooper fletcher miller smith)
    (if (and (distinct? (list baker cooper fletcher miller smith))
             (not (= baker 5))
             (not (= cooper 1))
             (not (= fletcher 5))
             (not (= fletcher 1))
             (> miller cooper)
             (not (= (abs (- smith fletcher)) 1))
             (not (= (abs (- fletcher cooper)) 1)))
      (print "baker: " baker ", cooper: " cooper ", "
             "fletcher: " fletcher ", miller: " miller ", "
             "smith: " smith)))
  (let go-baker ((baker 1))
    (if (<= baker 5)
      (begin
        (let go-cooper ((cooper 1))
          (if (<= cooper 5)
            (begin
              (let go-fletcher ((fletcher 1))
                (if (<= fletcher 5)
                  (begin
                    (let go-miller ((miller 1))
                      (if (<= miller 5)
                        (begin
                          (let go-smith ((smith 1))
                            (if (<= smith 5)
                              (begin
                                (check baker cooper fletcher miller smith)
                                (go-smith (+ smith 1)))))
                          (go-miller (+ miller 1)))))
                    (go-fletcher (+ fletcher 1)))))
              (go-cooper (+ cooper 1)))))
        (go-baker (+ baker 1))))))

(multiple-dwelling)
