;;; Exercise 4.48.  Extend the grammar given above to handle more complex
;;; sentences. For example, you could extend noun phrases and verb phrases to
;;; include adjectives and adverbs, or you could handle compound sentences.
;;; [53]

(load "./sec-4.3.2.scm")
(load "./sec-4.3.3.scm")

(ambtest `(begin

            ,@parser-definitions

            (define adjectives '(adjective wise fool sane crazy hot black))
            (define adverbs '(adverb reluctantly always often seldom never))

            (define (parse-simple-noun-phrase)
              (amb (list 'simple-noun-phrase
                         (parse-word articles)
                         (parse-word nouns))
                   (list 'simple-noun-phrase
                         (parse-word articles)
                         (parse-word adjectives)
                         (parse-word nouns))))

            (define (parse-simple-verb-phrase)
              (amb (list 'simple-verb-phrase
                         (parse-word verbs))
                   (list 'simple-verb-phrase
                         (parse-word adverbs)
                         (parse-word verbs))))
            (define (parse-verb-phrase)
              (define (maybe-extend verb-phrase)
                (amb verb-phrase
                     (maybe-extend (list 'verb-phrase
                                         verb-phrase
                                         (parse-prepositional-phrase)))))
              (maybe-extend (parse-simple-verb-phrase)))

            (define the-sentence
              '(the wise professor lectures
                    to the crazy student in the hot class
                    with the black cat))

            (print (parse the-sentence))

            ))
