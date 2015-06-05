;;; Exercise 4.9.  Many languages support a variety of iteration constructs,
;;; such as do, for, while, and until. In Scheme, iterative processes can be
;;; expressed in terms of ordinary procedure calls, so special iteration
;;; constructs provide no essential gain in computational power. On the other
;;; hand, such constructs are often convenient. Design some iteration
;;; constructs, give examples of their use, and show how to implement them as
;;; derived expressions.

;; Let's implement C language-like `for` statement.  It can be used as follows:
;;
;;     (for (i 0) (< i 5) (+ i 1)
;;       (display i)
;;       (newline))
;;
;; The above expression can be translated as follows:
;;
;;     (let go ((i 0))
;;        (if (< i 5)
;;          (begin
;;            (display i)
;;            (newline)
;;            (go (+ i 1)))))

(define (for? exp)
  (tagged-list? exp 'for))

(define (for-var exp)
  (car (cadr exp)))

(define (for-initial exp)
  (cadr (cadr exp)))

(define (for-condition exp)
  (caddr exp))

(define (for-update exp)
  (cadddr exp))

(define (for-body exp)
  (cddddr exp))

(define (for->named-let exp)
  (list 'let 'go (list (list (for-var exp) (for-initial exp)))
        (list 'if (for-condition exp)
              (cons
                (cons 'begin (for-body exp))
                (list 'go (for-update exp))))))
