;;; Exercise 3.80.  A series RLC circuit consists of a resistor, a capacitor,
;;; and an inductor connected in series, as shown in figure 3.36. If R, L, and
;;; C are the resistance, inductance, and capacitance, then the relations
;;; between voltage (v) and current (i) for the three components are described
;;; by the equations
;;;
;;;     v_R = i_R R
;;;             di_L
;;;     v_L = L ----
;;;              dt
;;;             dv_C
;;;     i_C = C ----
;;;              dt
;;;
;;; and the circuit connections dictate the relations
;;;
;;;     i_R = i_L = -i_C
;;;     v_C = v_L + v_R
;;;
;;; Combining these equations shows that the state of the circuit (summarized
;;; by v_C, the voltage across the capacitor, and i_L, the current in the
;;; inductor) is described by the pair of differential equations
;;;
;;;     dv_C     i_L
;;;     ---- = - ---
;;;      dt       C
;;;     di_L    1         R
;;;     ---- = --- v_C - --- i_L
;;;      dt     L         L
;;;
;;; The signal-flow diagram representing this system of differential equations
;;; is shown in figure 3.37.
;;;
;;;            i_R  + v_R -
;;;          ,-->----^v^v^v----,
;;;          |         R       |
;;;          v i_C             v
;;;      +  _|_                3  +
;;;     v_C ___ C            L 3 v_L
;;;      -   |                 3  -
;;;          |                 |
;;;          `-----------------'
;;;
;;; Figure 3.36:  A series RLC circuit.
;;;
;;;                      -----------------
;;;    ,-----------------| scale: 1 / L  |<-.
;;;    |                 -----------------  |
;;;    |                                    |
;;;    |                 -----------------  | v_C
;;;    |         dv_C ,->|   integral    |--*----->
;;;    |              |  -----------------
;;;    |              |         ^
;;;    |              |         `-- v_C0
;;;    |              |
;;;    |              |  -----------------
;;;    |              `--| scale: -1 / C |<-.
;;;    |                 -----------------  |
;;;    |   ----.                            |
;;;    `-->|    \  di_L  -----------------  | i_L
;;;        | add |------>|   integral    |--*----->
;;;    ,-->|    /        -----------------  |
;;;    |   ----'                ^           |
;;;    |                        `-- i_L0    |
;;;    |                                    |
;;;    |                 -----------------  |
;;;    `-----------------| scale: -R / L |<-'
;;;                      -----------------
;;;
;;; Figure 3.37:  A signal-flow diagram for the solution to a series RLC
;;; circuit.
;;;
;;; Write a procedure RLC that takes as arguments the parameters R, L, and C of
;;; the circuit and the time increment dt. In a manner similar to that of the
;;; RC procedure of exercise 3.73, RLC should produce a procedure that takes
;;; the initial values of the state variables, v_C0 and i_L0, and produces
;;; a pair (using cons) of the streams of states v_C and i_L. Using RLC,
;;; generate the pair of streams that models the behavior of a series RLC
;;; circuit with R = 1 ohm, C = 0.2 farad, L = 1 henry, dt = 0.1 second, and
;;; initial values i_L0 = 0 amps and v_C0 = 10 volts.

(load "./sec-3.5.scm")
(load "./ex-3.77.scm")

(define (RLC R L C dt)
  (define (vs&is v_C0 i_L0)
    (define v_C (integral (delay dv_C) v_C0 dt))
    (define i_L (integral (delay di_L) i_L0 dt))
    (define dv_C (scale-stream i_L (/ -1 C)))
    (define di_L (add-streams (scale-stream v_C (/ 1 L))
                              (scale-stream i_L (/ (- R) L))))
    (cons v_C i_L))
  vs&is)

(define R 1)
(define L 1)
(define C 0.2)
(define dt 0.1)
(define i_L0 0)
(define i_C0 10)
(define vs&is ((RLC R L C dt) i_L0 i_C0))
(define vs (car vs&is))
(define is (cdr vs&is))

(let go ([vs vs]
         [is is]
         [n 30])
  (when (< 0 n)
    (format #t "v = ~a   i = ~a\n" (stream-car vs) (stream-car is))
    (go (stream-cdr vs) (stream-cdr is) (- n 1))))
