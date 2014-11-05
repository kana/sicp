;;; Exercise 3.25.  Generalizing one- and two-dimensional tables, show how to
;;; implement a table in which values are stored under an arbitrary number of
;;; keys and different values may be stored under different numbers of keys.
;;; The lookup and insert! procedures should take as input a list of keys used
;;; to access the table.

; Let's consider the following interaction:
;
;    (define t (make-table))
;    (insert! '(a) 'v1)
;    (insert! '(a b c) 'v2)
;
; If t was a one-dimensional table, we could assume that each key is paired
; with a value.  If t was a two-dimensional table, we could assume that each
; key is paired with a list of records, and the pairs can be treated as
; one-dimensional tables.  But t is not.  A key might have both a value and
; a subtable, as above.
;
; So that I chose the following represenation:
;
; * Each key is paired with a subtable
; * The car of that subtable points the value for the key
; * The car of each table points #f by default
;
;      t
;      |
;      v
;     [o][o]-->[o][/]
;      |        |
;      v        v
;     #f       [o][o]-->[o][o]-->[o][/]
;               |        |        |
;               v        v        v
;               a       v1       [o][o]-->[o][o]-->[o][/]
;                                 |        |        |
;                                 v        v        v
;                                 b       #f       [o][o]-->[o][/]
;                                                   |        |
;                                                   v        v
;                                                   c       v2


(define (make-table)
  (list #f))

(define (lookup keys table)
  (define (go keys table)
    (if (null? keys)
      (car table)
      (let ([pair (assoc (car keys) (cdr table))])
        (if pair
          (go (cdr keys) (cdr pair))
          #f))))
  (go keys table))

(define (insert! keys value table)
  (define (go keys table)
    (if (null? keys)
      (set-car! table value)
      (let ([pair (assoc (car keys) (cdr table))])
        (cond
          [pair
            (go (cdr keys) (cdr pair))]
          [else
            (let ([subtable (make-table)])
              (set-cdr! table (list (cons (car keys) subtable) (cdr table)))
              (go (cdr keys) subtable))]))))
  (go keys table)
  'ok)




(define t (make-table))
#?=t

#?=(lookup '(a) t)
(insert! '(a) 'v1 t)
#?=t
#?=(lookup '(a) t)

#?=(lookup '(a b c) t)
(insert! '(a b c) 'v2 t)
#?=t
#?=(lookup '(a b c) t)

#?=(lookup '(a b) t)
#?=(lookup '(z) t)
