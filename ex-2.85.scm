;;; Exercise 2.85.  This section mentioned a method for ``simplifying'' a data
;;; object by lowering it in the tower of types as far as possible.  Design
;;; a procedure drop that accomplishes this for the tower described in exercise
;;; 2.83. The key is to decide, in some general way, whether an object can be
;;; lowered. For example, the complex number 1.5 + 0i can be lowered as far as
;;; real, the complex number 1 + 0i can be lowered as far as integer, and the
;;; complex number 2 + 3i cannot be lowered at all. Here is a plan for
;;; determining whether an object can be lowered: Begin by defining a generic
;;; operation project that ``pushes'' an object down in the tower. For example,
;;; projecting a complex number would involve throwing away the imaginary part.
;;; Then a number can be dropped if, when we project it and raise the result
;;; back to the type we started with, we end up with something equal to what we
;;; started with. Show how to implement this idea in detail, by writing a drop
;;; procedure that drops an object as far as possible. You will need to design
;;; the various projection operations[53] and install project as a generic
;;; operation in the system. You will also need to make use of a generic
;;; equality predicate, such as described in exercise 2.79. Finally, use drop
;;; to rewrite apply-generic from exercise 2.84 so that it ``simplifies'' its
;;; answers.

(load "./ex-2.84.scm")




; PUSH-DOWN is an internal utility for APPLY-GENERIC, and APPLY-GENERIC might
; coerce arguments if an appropriate procedure is not found.  PUSH-DOWN is
; a converter.  If automatic coercion happens while converting a given value,
; PUSH-DOWN's results are not reliable.
;
; Therefore, PUSH-DOWN should be implemented without APPLY-GENERIC.
(define (push-down x)
  (let ([proc (get 'push-down (type-tag x))])
    (if proc
      (proc (contents x))
      #f)))

(put 'push-down 'complex
     (lambda (z)
       (attach-tag 'real (real-part z))))
(put 'push-down 'real
     (lambda (r)
       (make-rational (round r) 1)))
(put 'push-down 'rational
     (lambda (q)
       (attach-tag 'integer
                   (round (/ (numer q) (denom q))))))




; Like PUSH-DOWN, DROP is also a converter.  Automatic coercion must not be
; happened in its process.  But DROP cannot be implemented without generic
; operations -- PUSH-DOWN, RAISE, EQU?.  So that we have to investigate whether
; all generic operations in DROP will never trigger automatic coercion.
;
; * PUSH-DOWN is implement without APPLY-GENERIC.  Automatic coercion will
;   never happen.
; * RAISE always takes a PUSH-DOWN'ed value.  So that RAISE always finds an
;   appropriate procedure without automatic coercion.
; * EQU? always takes two values with the same type.  Like RAISE, automatic
;   coercion will never happen.
;
; Therefore automatic coercion will never happen while dropping, as far as
; appropriate versions of PUSH-DOWN, RAISE and EQU? are defined.
(define (drop x)
  (let ([xd (push-down x)])
    (if (and xd (equ? x (raise xd)))
      (drop xd)
      x)))




; TODO: Implement a new apply-generic.
