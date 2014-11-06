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

; TODO




; If a set is represented as an unordered list, lookup-set and adjoin-set! can
; be defined as follows:

; TODO




; If a set is represented as a binary tree, lookup-set and adjoin-set! can be
; defined as follows:

; TODO




; Examples

; TODO
