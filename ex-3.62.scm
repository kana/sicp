;;; Exercise 3.62.  Use the results of exercises 3.60 and 3.61 to define
;;; a procedure div-series that divides two power series. Div-series should
;;; work for any two series, provided that the denominator series begins with
;;; a nonzero constant term. (If the denominator has a zero constant term, then
;;; div-series should signal an error.) Show how to use div-series together
;;; with the result of exercise 3.59 to generate the power series for tangent.

(load "./sec-3.5.scm")
(load "./ex-3.59.scm")
(load "./ex-3.60.scm")
(load "./ex-3.61.scm")

(define (div-series psn psd)
  (if (= (stream-car psd) 0)
    (error "div-series: Denominator must begin with a nonzero constant term"))
  (mul-series psn (invert-unit-series psd)))

(define tangent-series (div-series sine-series cosine-series))

(define s tangent-series)
(do ((i 0 (+ i 1)))
  ((= i 30))
  (display (stream-ref s i))
  (display ", "))
(display "...\n")
