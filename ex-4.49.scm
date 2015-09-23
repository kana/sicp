;;; Exercise 4.49.  Alyssa P. Hacker is more interested in generating
;;; interesting sentences than in parsing them. She reasons that by simply
;;; changing the procedure parse-word so that it ignores the ``input sentence''
;;; and instead always succeeds and generates an appropriate word, we can use
;;; the programs we had built for parsing to do generation instead. Implement
;;; Alyssa's idea, and show the first half-dozen or so sentences generated.
;;; [54]

(load "./sec-4.3.2.scm")
(load "./sec-4.3.3.scm")

(ambtest `(begin

            ,@parser-definitions

            (define (an-element-of items)
              (require (not (null? items)))
              (amb (car items) (an-element-of (cdr items))))

            (define (parse-word word-list)
              (list (car word-list) (an-element-of (cdr word-list))))

            (print (parse '()))

            ))

; Warning: Run this script with head(1) like "gosh ex-4.49.scm | head -n6".
;
; The first half-dozen sentences are:
;
;     (sentence (simple-noun-phrase (article the) (noun student)) (verb studies))
;     (sentence (simple-noun-phrase (article the) (noun student)) (verb-phrase (verb studies) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))))
;     (sentence (simple-noun-phrase (article the) (noun student)) (verb-phrase (verb-phrase (verb studies) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))))
;     (sentence (simple-noun-phrase (article the) (noun student)) (verb-phrase (verb-phrase (verb-phrase (verb studies) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))))
;     (sentence (simple-noun-phrase (article the) (noun student)) (verb-phrase (verb-phrase (verb-phrase (verb-phrase (verb studies) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))))
;     (sentence (simple-noun-phrase (article the) (noun student)) (verb-phrase (verb-phrase (verb-phrase (verb-phrase (verb-phrase (verb studies) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))))
