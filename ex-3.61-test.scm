(load "./sec-3.5.scm")
(load "./ex-3.59.scm")
(load "./ex-3.60.scm")
(load "./ex-3.61.scm")

(define s (mul-series exp-series (invert-unit-series exp-series)))

(do ((i 0 (+ i 1)))
  ((= i 30))
  (display (stream-ref s i))
  (display ", "))
(display "...\n")

