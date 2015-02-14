;;; Exercise 3.75.  Unfortunately, Alyssa's zero-crossing detector in exercise
;;; 3.74 proves to be insufficient, because the noisy signal from the sensor
;;; leads to spurious zero crossings. Lem E. Tweakit, a hardware specialist,
;;; suggests that Alyssa smooth the signal to filter out the noise before
;;; extracting the zero crossings. Alyssa takes his advice and decides to
;;; extract the zero crossings from the signal constructed by averaging each
;;; value of the sense data with the previous value. She explains the problem
;;; to her assistant, Louis Reasoner, who attempts to implement the idea,
;;; altering Alyssa's program as follows:
;;;
;;; (define (make-zero-crossings input-stream last-value)
;;;   (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
;;;     (cons-stream (sign-change-detector avpt last-value)
;;;                  (make-zero-crossings (stream-cdr input-stream)
;;;                                       avpt))))
;;;
;;; This does not correctly implement Alyssa's plan. Find the bug that Louis
;;; has installed and fix it without changing the structure of the program.
;;; (Hint: You will need to increase the number of arguments to
;;; make-zero-crossings.)

; Let's denote
;
; * S = (S_i) as the sense data, and
; * A = (A_i) as the average values calculated from S,
;       where A_i = (S_i + S_{i-1}) / 2.
;
; Alyssa's plan is to extract zero crossings from A.
; But Louis's implementation does not correctly calculate A.
; It calculates A_i by (S_i + A_{i-1}) / 2.

(define (make-zero-crossings input-stream last-raw-value last-average-value)
  (let ((avpt (/ (+ (stream-car input-stream) last-raw-value) 2)))
    (cons-stream (sign-change-detector avpt last-average-value)
                 (make-zero-crossings (stream-cdr input-stream)
                                      (stream-car input-stream)
                                      avpt))))
