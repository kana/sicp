> Exercise 4.46.  The evaluators in sections 4.1 and 4.2 do not determine what
> order operands are evaluated in. We will see that the amb evaluator evaluates
> them from left to right. Explain why our parsing program wouldn't work if the
> operands were evaluated in some other order.

The parsing program uses the global variable `*unparsed*` to pass rest of
input.  And words in `*unparsed*` must be read from left to right.  Recall the
code of `parse-sentence`:

```scheme
(define (parse-sentence)
  (list 'sentence
        (parse-noun-phrase)
        (parse-verb-phrase)))
```

If the amb evaluator evaluates operands from right to left,
`(parse-verb-phrase)` will be evaluated before `(parse-noun-phrase)`.
So that the parsing program parses sentences in wrong order.

For example, "the cat eats" is not parsed as a right sentence, while "eats the
cat" is parsed as a right sentence.
