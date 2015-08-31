;;; Exercise 4.32.  Give some examples that illustrate the difference between
;;; the streams of chapter 3 and the ``lazier'' lazy lists described in this
;;; section. How can you take advantage of this extra laziness?

; We can construct linear lists of infinite length with the streams,
; but we can construct trees of infinite depth with the lazier lazy lists.
; For example...

(load "./sec-4.1.1.scm")
(load "./sec-4.1.2.scm")
(load "./sec-4.1.3.scm")
(load "./sec-4.1.4.scm")
(load "./sec-4.2.2.scm")

(define code
  '((define (cons x y)
      (lambda (m) (m x y)))
    (define (car z)
      (z (lambda (p q) p)))
    (define (cdr z)
      (z (lambda (p q) q)))

    (define (make-tree value left right)
      (cons value (cons left right)))

    (define nil-tree (make-tree "X" "X" "X"))

    (define (nil-tree? tree)
      (eq? tree nil-tree))

    (define (tree-value tree)
      (car tree))

    (define (tree-left tree)
      (car (cdr tree)))

    (define (tree-right tree)
      (cdr (cdr tree)))

    (define (make-random-tree value)
      (make-tree value
                 (if (= (modulo value 5) 0)
                   nil-tree
                   (make-random-tree (+ value 3)))
                 (if (= (modulo value 8) 0)
                   nil-tree
                   (make-random-tree (* value 2)))))

    (define (display-tree tree depth-limit)
      (define (go tree d)
        (cond ((nil-tree? tree)
               (print (indent d "-")))
              (else
                (print (indent d (tree-value tree)))
                (cond ((>= (+ d 1) depth-limit)
                       (print (indent d "...")))
                      (else
                        (print (indent d "Left:"))
                        (go (tree-left tree) (+ d 1))
                        (print (indent d "Right:"))
                        (go (tree-right tree) (+ d 1)))))))
      (go tree 0))

    (display-tree (make-random-tree 3) 3)
    (display-tree (make-random-tree 3) 8)
    ))

(define (main args)
  (for-each
    (lambda (expr)
      (print expr)
      (print "==> " (actual-value expr the-global-environment)))
    code))
