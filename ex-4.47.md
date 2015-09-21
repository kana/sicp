> Exercise 4.47.  Louis Reasoner suggests that, since a verb phrase is either
> a verb or a verb phrase followed by a prepositional phrase, it would be much
> more straightforward to define the procedure parse-verb-phrase as follows
> (and similarly for noun phrases):
>
> ```scheme
> (define (parse-verb-phrase)
>   (amb (parse-word verbs)
>        (list 'verb-phrase
>              (parse-verb-phrase)
>              (parse-prepositional-phrase))))
> ```
>
> Does this work? Does the program's behavior change if we interchange the
> order of expressions in the amb?

It does not work.  Using `parse-verb-phrase` in itself causes an infinite loop
after enumerating some valid parsing results.

Things get worse if the order of expressions in the amb is changed.  The amb
evaluator evaluates operands from left to right.  So that `parse-verb-phrase`
falls into an infinite loop before enumerating any valid parsing result.
