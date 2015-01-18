> Exercise 3.68.  Louis Reasoner thinks that building a stream of pairs from
> three parts is unnecessarily complicated. Instead of separating the pair
> (S0,T0) from the rest of the pairs in the first row, he proposes to work with
> the whole first row, as follows:
>
> ```scheme
> (define (pairs s t)
>   (interleave
>    (stream-map (lambda (x) (list (stream-car s) x))
>                t)
>    (pairs (stream-cdr s) (stream-cdr t))))
> ```
>
> Does this work?  Consider what happens if we evaluate `(pairs integers
> integers)` using Louis's definition of `pairs`.

Louis's `pairs` does not work.  It recursively calls itself forever.
Because not all procedures are lazily evaluated.
The steps to evaluate `(pairs integers integers)` will be as follows:

1. `pairs` calls `interleave`.
2. `interleave` is an ordinary procedure, so its arguments are evaluated before calling `interleave`.
3. One of subexpressions for `interleave` is `(pairs (stream-cdr s) (stream-cdr t))`.  So the second `pairs` is called.
4. And the second `pairs` behaves the same as the first `pairs`.  The third `pairs` is called, and so on.
