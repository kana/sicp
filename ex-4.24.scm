;;; Exercise 4.24.  Design and carry out some experiments to compare the speed
;;; of the original metacircular evaluator with the version in this section.
;;; Use your results to estimate the fraction of time that is spent in analysis
;;; versus execution for various procedures.

(load "./sec-4.1.1.scm")
(load "./sec-4.1.2.scm")
(load "./sec-4.1.3.scm")
(load "./sec-4.1.4.scm")

(define eval-original eval)

(load "./sec-4.1.7.scm")

(define eval-analyzed eval)

(define sample-codes
  '((begin (define (fib n)
             (cond ((= n 1) 1)
                   ((= n 2) 1)
                   (else (+ (fib (- n 1)) (fib (- n 2))))))
           (print (fib 26)))
    (begin (define (loop n)
             (if (= n 0)
               'done
               (begin (+ 1 1)
                      (loop (- n 1)))))
           (loop 100000))
    ))

(for-each (lambda (code)
            (print "================================")
            (print "Code: " code)
            (print "Original:")
            (time (eval-original code the-global-environment))
            (print "Analyzed:")
            (time (eval-analyzed code the-global-environment)))
          sample-codes)
