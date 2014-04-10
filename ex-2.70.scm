;;; Exercise 2.70.
;;;
;;; The following eight-symbol alphabet with associated relative frequencies
;;; was designed to efficiently encode the lyrics of 1950s rock songs.  (Note
;;; that the ``symbols'' of an ``alphabet'' need not be individual letters.)
;;;
;;;     A      2        NA    16
;;;     BOOM   1        SHA    3
;;;     GET    2        YIP    9
;;;     JOB    2        WAH    1
;;;
;;; Use generate-huffman-tree (exercise 2.69) to generate a corresponding
;;; Huffman tree, and use encode (exercise 2.68) to encode the following
;;; message:
;;;
;;; > Get a job
;;; >
;;; > Sha na na na na na na na na
;;; >
;;; > Get a job
;;; >
;;; > Sha na na na na na na na na
;;; >
;;; > Wah yip yip yip yip yip yip yip yip yip
;;; >
;;; > Sha boom

(define word-frequencies
  '((A      2)        (NA    16)
    (BOOM   1)        (SHA    3)
    (GET    2)        (YIP    9)
    (JOB    2)        (WAH    1)))

(define lyric
  '(GET A JOB
    SHA NA NA NA NA NA NA NA NA
    GET A JOB
    SHA NA NA NA NA NA NA NA NA
    WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
    SHA BOOM))

(load "./ex-2.68.scm")
(load "./ex-2.69.scm")

(print "")
(print "Exercise 2.70:")

(define rock-tree (generate-huffman-tree word-frequencies))
(print rock-tree)
; ==> ((leaf NA 16)
;      ((leaf YIP 9)
;       (((leaf A 2)
;         ((leaf WAH 1) (leaf BOOM 1) (WAH BOOM) 2)
;         (A WAH BOOM)
;         4)
;        ((leaf SHA 3)
;         ((leaf JOB 2) (leaf GET 2) (JOB GET) 4)
;         (SHA JOB GET)
;         7)
;        (A WAH BOOM SHA JOB GET)
;        11)
;       (YIP A WAH BOOM SHA JOB GET)
;       20)
;      (NA YIP A WAH BOOM SHA JOB GET)
;      36)
;
;     (NA YIP A WAH BOOM SHA JOB GET)-36
;        /                      \
;     NA-16         (YIP A WAH BOOM SHA JOB GET)-20
;                        /              \
;                     YIP-9       (A WAH BOOM SHA JOB GET)-11
;                                   /                  \
;                            (A WAH BOOM)-4         (SHA JOB GET)-7
;                             /       \                /     \
;                           A-2   (WAH BOOM)-2      SHA-3 (JOB GET)-4
;                                   /    \                  /   \
;                                 WAH-1 BOOM-1           JOB-2 GET-2

(define encoded-lyric (encode lyric rock-tree))
(print encoded-lyric)
; ==> (1 1 1 1 1   1 1 0 0   1 1 1 1 0
;      1 1 1 0   0   0   0   0   0   0   0   0
;      1 1 1 1 1   1 1 0 0   1 1 1 1 0
;      1 1 1 0   0   0   0   0   0   0   0   0
;      1 1 0 1 0   1 0   1 0   1 0   1 0   1 0   1 0   1 0   1 0   1 0
;      1 1 1 0   1 1 0 1 1)

;;; How many bits are required for the encoding?

(print (length encoded-lyric))
; ==> 84

;;; What is the smallest number of bits that would be needed to encode this
;;; song if we used a fixed-length code for the eight-symbol alphabet?

; At least 3 bits are required to distinct 8 symbols.  And the lyric contains

(print (length lyric) " words.")
; ==> 36 words.

; So that at least 108 bits are required to encode the lyric with
; a fixed-length code.
