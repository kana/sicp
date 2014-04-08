(load "./sec-2.3.4.scm")

;;; Exercise 2.68.
;;;
;;; The encode procedure takes as arguments a message and a tree and produces
;;; the list of bits that gives the encoded message.

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

;;; Encode-symbol is a procedure, which you must write, that returns the list
;;; of bits that encodes a given symbol according to a given tree.  You should
;;; design encode-symbol so that it signals an error if the symbol is not in
;;; the tree at all.  Test your procedure by encoding the result you obtained
;;; in exercise 2.67 with the sample tree and seeing whether it is the same as
;;; the original sample message.

(define (encode-symbol symbol tree)
  (cond [(leaf? tree)
         '()]
        [(memq symbol (symbols (left-branch tree)))
         (cons 0
               (encode-symbol symbol (left-branch tree)))]
        [(memq symbol (symbols (right-branch tree)))
         (cons 1
               (encode-symbol symbol (right-branch tree)))]
        [else
          (error "Unknown symbol -- ENCODE-SYMBOL" symbol)]))

(load "./ex-2.67.scm")

(print (encode (decode sample-message sample-tree) sample-tree))
(print (equal? sample-message
               (encode (decode sample-message sample-tree) sample-tree)))
(print (encode '(A B C D) sample-tree))
; (print (encode '(A B C D E) sample-tree))
; ==> gosh: "error": Unknown symbol -- ENCODE-SYMBOL E
