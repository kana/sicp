;;; Exercise 4.50.  Implement a new special form ramb that is like amb except
;;; that it searches alternatives in a random order, rather than from left to
;;; right. Show how this can help with Alyssa's problem in exercise 4.49.

(load "./sec-4.3.2.scm")
(load "./sec-4.3.3.scm")

; To generate random sentences which consist of randomly structured words, all
; use of amb in the parser must be replaced with ramb.  To avoid a massive
; copy, I modify amb to act as ramb.

(use gauche.sequence)

(define (analyze-amb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
          (fail)
          (let ((choices (shuffle choices)))  ; *changed*
            ((car choices) env
                           succeed
                           (lambda ()
                             (try-next (cdr choices)))))))
      (try-next cprocs))))

(ambtest `(begin

            ,@parser-definitions

            (define (an-element-of items)
              (require (not (null? items)))
              (amb (car items) (an-element-of (cdr items))))

            (define (parse-word word-list)
              (list (car word-list) (an-element-of (cdr word-list))))

            (print (parse '()))

            ))
