;;; Exercise 3.26.  To search a table as implemented above, one needs to scan
;;; through the list of records. This is basically the unordered list
;;; representation of section 2.3.3. For large tables, it may be more efficient
;;; to structure the table in a different manner. Describe a table
;;; implementation where the (key, value) records are organized using a binary
;;; tree, assuming that keys can be ordered in some way (e.g., numerically or
;;; alphabetically). (Compare exercise 2.66 of chapter 2.)




; The table can be described as follows:
;
; * A table is a pair of a value and a set of entries.
; * An entry is a pair of a key and a table.
;
; My answer to Exercise 3.25 is not good.  Because it does not abstract how to
; access a set.  If the abstraction is properly done, changing a representation
; of a set is fairly simple like examples in section 2.3.3.
;
; Let's revise the answer to Exercise 3.25 by abstracting access to sets:

(define (make-empty-set)
  '())
(define empty-set? null?)

(define (make-entry key)
  (cons key (make-table)))
(define entry-key car)
(define entry-table cdr)

(define (make-table)
  (cons #f (make-empty-set)))
(define table-value car)
(define set-table-value! set-car!)
(define table-set cdr)
(define set-table-set! set-cdr!)

(define (lookup keys table)
  (define (go keys table)
    (if (null? keys)
      (table-value table)
      (let ([entry (lookup-set (car keys) (table-set table))])
        (if entry
          (go (cdr keys) (entry-table entry))
          #f))))
  (go keys table))

(define (insert! keys value table)
  (define (go keys table)
    (if (null? keys)
      (set-table-value! table value)
      (let ([entry (lookup-set (car keys) (table-set table))])
        (cond
          [entry
            (go (cdr keys) (entry-table entry))]
          [else
            (let ([new-entry (make-entry (car keys))])
              (set-table-set! table (adjoin-set! new-entry (table-set table)))
              (go (cdr keys) (entry-table new-entry)))]))))
  (go keys table)
  'ok)




; If a set is represented as an unordered list, lookup-set and adjoin-set! can
; be defined as follows:

(define (lookup-set key set)
  (assoc key set))

(define (adjoin-set! entry set)
  (cons entry set))




; If a set is represented as a binary tree, lookup-set and adjoin-set! can be
; defined as follows:

; TODO




; Examples

(define t (make-table))
#?=t
#?=(lookup '(3) t)
#?=(lookup '(2 1 3) t)
#?=(lookup '(9) t)
(insert! '(2) 'A t)
(insert! '(2 1 3) 'ABC t)
(insert! '(9) 'Z t)
#?=t
#?=(lookup '(2) t)
#?=(lookup '(2 1 3) t)
#?=(lookup '(9) t)
