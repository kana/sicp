> Exercise 4.15.  Given a one-argument procedure `p` and an object `a`, `p` is
> said to “halt” on `a` if evaluating the expression `(p a)` returns a value
> (as opposed to terminating with an error message or running forever). Show
> that it is impossible to write a procedure `halts?` that correctly determines
> whether `p` halts on `a` for any procedure `p` and object `a`. Use the
> following reasoning: If you had such a procedure `halts?`, you could
> implement the following program:
>
>     (define (run-forever) (run-forever))
>
>     (define (try p)
>       (if (halts? p p)
>           (run-forever)
>           'halted))
>
> Now consider evaluating the expression `(try try)` and show that any possible
> outcome (either halting or running forever) violates the intended behavior of
> `halts?`. [23]

The definition of `try` means:

* `try` runs forever if `(p p)` halts, and
* `try` halts if `(p p)` runs forever.

So that whether `try` halts or not depends on whether `(p p)` halts or not.

Suppose that `(try try)` halts.  But `try` must run forever by definition.
This result contradicts the assumption.

Suppose that `(try try)` runs forever.  But `try` must halt by definition.
This result contradicts the assumption too.

This contradictions are caused by assuming existence of `halts?`.  So that it
is not possible to write `halts?`.
