> Exercise 4.25.  Suppose that (in ordinary applicative-order Scheme) we define
> `unless` as shown above and then define `factorial` in terms of `unless` as
>
> ```scheme
> (define (factorial n)
>   (unless (= n 1)
>           (* n (factorial (- n 1)))
>           1))
> ```


> What happens if we attempt to evaluate `(factorial 5)`?

It causes an infinite loop.  All arguments to `unless` must be evaluated before
applying `unless`.  So that another `factorial` is applied.  The same can be
said for the newly applied `factorial`.


> Will our definitions work in a normal-order language?

Yes.  `usual-value` to `unless` is evaluated if `condition` is evaluated to
false.  So that the recursion will be eventually terminated.
