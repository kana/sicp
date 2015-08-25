> Exercise 4.30.  Cy D. Fect, a reformed C programmer, is worried that some
> side effects may never take place, because the lazy evaluator doesn't force
> the expressions in a sequence. Since the value of an expression in a sequence
> other than the last one is not used (the expression is there only for its
> effect, such as assigning to a variable or printing), there can be no
> subsequent use of this value (e.g., as an argument to a primitive procedure)
> that will cause it to be forced. Cy thus thinks that when evaluating
> sequences, we must force all expressions in the sequence except the final
> one. He proposes to modify `eval-sequence` from section 4.1.1 to use
> `actual-value` rather than `eval`:
>
> ```scheme
> (define (eval-sequence exps env)
>   (cond ((last-exp? exps) (eval (first-exp exps) env))
>         (else (actual-value (first-exp exps) env)
>               (eval-sequence (rest-exps exps) env))))
> ```


> a. Ben Bitdiddle thinks Cy is wrong. He shows Cy the `for-each` procedure
> described in exercise 2.23, which gives an important example of a sequence
> with side effects:
>
> ```scheme
> (define (for-each proc items)
>   (if (null? items)
>       'done
>       (begin (proc (car items))
>              (for-each proc (cdr items)))))
> ```
>
> He claims that the evaluator in the text (with the original `eval-sequence`)
> handles this correctly:
>
> ```scheme
> ;;; L-Eval input:
> (for-each (lambda (x) (newline) (display x))
>           (list 57 321 88))
> 57
> 321
> 88
> ;;; L-Eval value:
> done
> ```
>
> Explain why Ben is right about the behavior of `for-each`.

`eval` might returns a thunk to be forced.  For example, a compound procedure
returns a thunk if a given argument is returned as is like `(lambda (x) x)`.

Ben's example does not contain such code.  That's why Ben's example seems to
work with the original `eval-sequence`.




> b. Cy agrees that Ben is right about the `for-each` example, but says that
> that's not the kind of program he was thinking about when he proposed his
> change to `eval-sequence`. He defines the following two procedures in the
> lazy evaluator:
>
> ```scheme
> (define (p1 x)
>   (set! x (cons x '(2)))
>   x)
>
> (define (p2 x)
>   (define (p e)
>     e
>     x)
>   (p (set! x (cons x '(2)))))
> ```
>
> What are the values of `(p1 1)` and `(p2 1)` with the original
> `eval-sequence`? What would the values be with Cy's proposed change to
> `eval-sequence`?

The steps to evaluate `(p1 1)` with the original `eval-sequence` are:

1. `1` given to `p1` is delayed.  Then body of `p1` will be evaluated.
2. `(set! x (cons x '(2)))` is evaluated.  There is no compound procedure, so
   that nothing is delayed.  `x` is forced then bound to `(1 2)`.
3. `x` is evaluated.  Finally `p1` returns `(1 2)`.

The steps to evaluate `(p2 1)` with the original `eval-sequence` are:

1. `1` given to `p2` is delayed.  Then body of `p2` will be evaluated.
2. `(define ...)` is evaluated without delay.
3. `(p ...)` is evaluated.  The subexpression `(set! ...)` is delayed, then
   body of `p` will be evaluated.
4. `e` is evaluated.  `e` is bound to a delayed `(set! ...)`.  Nothing is
   forced at this timing.
5. `x` is evaluated.  Since `(set! ...)` is not evaluated, `x` is still bound
   to `1`.  So that `p2` returns `1`.

The steps to evaluate `(p1 1)` with Cy's `eval-sequence` are the same as ones
with the original `eval-sequence`.

The steps to evaluate `(p2 1)` with Cy's `eval-sequence` are similar to ones
with the original `eval-sequence`.  But `e` is forced with Cy's one.  So that
`x` is bound to `(1 2)`, then `x`'s value is returned from `p2`.




> c. Cy also points out that changing `eval-sequence` as he proposes does not
> affect the behavior of the example in part a. Explain why this is true.

Because the actual `proc` in Ben's example does not use delayed argument as is
in non-last expressions.  All arguments are forced even if Ben's example is
evaluated with the original `eval-sequence`.  So that the behavior of the
example is not changed with Cy's one.




> d. How do you think sequences ought to be treated in the lazy evaluator? Do
> you like Cy's approach, the approach in the text, or some other approach?

TODO
