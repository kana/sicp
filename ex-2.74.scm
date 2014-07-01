;;; Exercise 2.74.
;;;
;;; Insatiable Enterprises, Inc., is a highly decentralized conglomerate
;;; company consisting of a large number of independent divisions located all
;;; over the world. The company's computer facilities have just been
;;; interconnected by means of a clever network-interfacing scheme that makes
;;; the entire network appear to any user to be a single computer. Insatiable's
;;; president, in her first attempt to exploit the ability of the network to
;;; extract administrative information from division files, is dismayed to
;;; discover that, although all the division files have been implemented as
;;; data structures in Scheme, the particular data structure used varies from
;;; division to division. A meeting of division managers is hastily called to
;;; search for a strategy to integrate the files that will satisfy
;;; headquarters' needs while preserving the existing autonomy of the
;;; divisions.
;;;
;;; Show how such a strategy can be implemented with data-directed programming.
;;; As an example, suppose that each division's personnel records consist of
;;; a single file, which contains a set of records keyed on employees' names.
;;; The structure of the set varies from division to division. Furthermore,
;;; each employee's record is itself a set (structured differently from
;;; division to division) that contains information keyed under identifiers
;;; such as address and salary. In particular:




;;; a.  Implement for headquarters a get-record procedure that retrieves
;;; a specified employee's record from a specified personnel file. The
;;; procedure should be applicable to any division's file.  Explain how the
;;; individual divisions' files should be structured. In particular, what type
;;; information must be supplied?

; Each file can be treated as a set of records, so that each file must be
; tagged with a symbol which denotes the type of the representation of the set.
; For example, if division A's file uses an unordered list to contain records,
; the file is tagged like: (attach-tag 'unordered-list A-personnel-file)

(define (get-record employee-name tagged-personnel-file)
  ((get 'get-record (type-tag tagged-personnel-file))
   employee-name
   (contents tagged-personnel-file)))

(put 'get-record 'unordered-list
     (lambda (employee-name personnel-file)
       (define (go rest)
         (if (null? rest)
           #f
           (let ([record (car rest)])
             (if (eq? employee-name (get-employee-name record))
               record
               (go (cdr rest))))))
       (go personnel-file)))
; (put 'get-record 'ordered-list ...)

; Likewise, each employee's record can be treated as a set of key-value pairs.
; So that each record must be tagged with a symbol to denote the internal
; representation of the record.  For example, if a record is internally
; structured with an ordered list, the record should be tagged like:
; (attach-tag 'ordered-list a-record)

(define (get-value key tagged-record)
  ((get 'get-value (type-tag tagged-record))
   key
   (contents tagged-record)))

(put 'get-value 'unordered-list
     (lambda (key pairs)
       (and-let* ([value (assq key pairs)])
                 (cdr value))))
; (put 'get-value 'ordered-list ...)

(define (get-employee-name record)
  (get-value 'employee-name record))




;;; b.  Implement for headquarters a get-salary procedure that returns the
;;; salary information from a given employee's record from any division's
;;; personnel file. How should the record be structured in order to make this
;;; operation work?

; Each record is a key-value pairs, and the key for salary information is the
; symbol "salary".

(define (get-salary record)
  (get-value 'salary record))




;;; c.  Implement for headquarters a find-employee-record procedure. This
;;; should search all the divisions' files for the record of a given employee
;;; and return the record. Assume that this procedure takes as arguments an
;;; employee's name and a list of all the divisions' files.

(define (find-employee-record employee-name files)
  (define (try files)
    (if (null? files)
      #f
      (let ([record (get-record employee-name (car files))])
        (or record (try (cdr files))))))
  (try files))




;;; d.  When Insatiable takes over a new company, what changes must be made in
;;; order to incorporate the new personnel information into the central system?
