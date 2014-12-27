(load "./sec-3.5.scm")
(load "./ex-3.59.scm")
(load "./ex-3.60.scm")

(define s
  (add-streams
    (mul-series sine-series sine-series)
    (mul-series cosine-series cosine-series)))

(do ((i 0 (+ i 1)))
  ((= i 30))
  (display (stream-ref s i))
  (display ", "))
(display "...\n")
