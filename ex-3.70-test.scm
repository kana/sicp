(load "./sec-3.5.scm")
(load "./ex-3.70.scm")

(define sa (weighted-pairs integers integers (lambda (ij) (apply + ij))))
(print "sa ==>")
(do ((i 0 (+ i 1)))
  ((= i 10))
  (print (stream-ref sa i)))

(print "sb ==>")
(do ((i 0 (+ i 1)))
  ((= i 30))
  (print (stream-ref sb i)))
