;;; Exercise 3.79.  Generalize the solve-2nd procedure of exercise 3.78 so that
;;; it can be used to solve general second-order differential equations d2
;;; y/dt2 = f(dy/dt, y).

(load "./sec-3.5.scm")
(load "./ex-3.77.scm")

(define (solve-2nd f dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (f dy y))
  y)

(define (ex-3.78 a b dt y0 dy0)
  (solve-2nd (lambda (dy y)
               (add-streams (scale-stream dy a)
                            (scale-stream y b)))
             dt
             y0
             dy0))
