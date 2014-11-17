> Exercise 3.31.   The internal procedure `accept-action-procedure!` defined in
> `make-wire` specifies that when a new action procedure is added to a wire,
> the procedure is immediately run. Explain why this initialization is
> necessary.

1. The simulation is driven by `propagate`.
2. `propagate` operates on `the-agenda`.
3. New items are added to `the-agenda` only by `after-delay`.
4. `after-delay` is called only by procedures added with `add-action!`.

Therefore, `the-agenda` is never updated if `accept-action-procedure!` does not
do the initialization.  This means nothing will be simulated by `propagate`.


> In particular, trace through the half-adder example in the paragraphs above
> and say how the system's response would differ if we had defined
> `accept-action-procedure!` as
>
> ```scheme
> (define (accept-action-procedure! proc)
>   (set! action-procedures (cons proc action-procedures)))
> ```

Since new items are never added to `the-agenda` with this version,
`(propagate)` simulates nothing and just returns `done`.
