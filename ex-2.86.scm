;;; Exercise 2.86.  Suppose we want to handle complex numbers whose real parts,
;;; imaginary parts, magnitudes, and angles can be either ordinary numbers,
;;; rational numbers, or other numbers we might wish to add to the system.
;;; Describe and implement the changes to the system needed to accommodate
;;; this. You will have to define operations such as sine and cosine that are
;;; generic over ordinary numbers and rational numbers.

; To simplify implementation, here we assume that MAKE-FROM-REAL-IMAG and
; MAKE-FROM-MAG-ANG always take integers, rational numbers or real numbers.
; In other words, both constructors don't check types of given arguments.
;
; All we have to do is to replace several functions used in rectangular and
; polar packages with generic versions.  These functions fall into two
; categories:
;
;     A
;         sqrt    (used by rectangular magnitude)
;         square  (used by rectangular magnitude)
;         atan    (used by rectangular angle)
;         cos     (used by polar real-part)
;         sin     (used by polar imag-part)
;
;     B
;         +       (used by rectangular magnitude)
;         *       (used by polar real-part and imag-part)
;
; Necessary changes for functions in the category A are simple.  We can replace
; existing functions with generic versions in the global namespace.  And we
; don't have to define these functions for each type.  As of Exercise 2.84, our
; APPLY-GENERIC automatically coerces arguments if necessary.  So that we have
; to define these functions only for real numbers.  For example:

(define %sqrt sqrt)
(define (sqrt x)
  (apply-generic 'sqrt x))
(put 'sqrt '(real) %sqrt)

(define %square square)
(define (square x)
  (apply-generic 'square x))
(put 'square '(real) %square)

(define %atan atan)
(define (atan x y)
  (apply-generic 'atan x y))
(put 'atan '(real real) %atan)

(define %cos cos)
(define (cos x)
  (apply-generic 'cos x))
(put 'cos '(real) %cos)

(define %sin sin)
(define (sin x)
  (apply-generic 'sin x))
(put 'sin '(real) %sin)

; But the same method cannot be used for function in the category B.  SQRT and
; others are defined only for real numbers, while + and * must be defined for
; many types.  If we "rename" + and * like sqrt and %sqrt shown in the above,
; most packages must be rewritten to use %+ and %*.  It's tedious.  So that
; it's better to explicitly use generic + and * instead of renaming + and *.
;
; Therefore, we have to change rectangular and polar packages a bit as follows:

(define (install-rectangular-package)
  ; ...
  (define (magnitude z)
    (sqrt (add (square (real-part z))
               (square (imag-part z)))))
  ; ...
  'done)
(define (install-polar-package)
  ; ...
  (define (real-part z)
    (mul (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (mul (magnitude z) (sin (angle z))))
  ; ...
  'done)
