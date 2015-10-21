> Exercise 4.70.  What is the purpose of the `let` bindings in the procedures
> `add-assertion!` and `add-rule!`? What would be wrong with the following
> implementation of `add-assertion!`? Hint: Recall the definition of the
> infinite stream of ones in section 3.5.2: `(define ones (cons-stream
> 1 ones))`.
>
> ```scheme
> (define (add-assertion! assertion)
>   (store-assertion-in-index assertion)
>   (set! THE-ASSERTIONS
>         (cons-stream assertion THE-ASSERTIONS))
>   'ok)
> ```

The purpose of the `let` bindings is to refer assertions and rules before
additions.  If the `let` bindings are omitted, there is no way to refer
assertions and rules before additions.

And the second argument given to `cons-stream` is lazily evaluated.  After
evaluating `(set! THE-ASSERTIONS (cons-stream assertion THE-ASSERTIONS))`,
`THE-ASSERTIONS` is bound to a stream which consists of `assertion` and the
stream itself.
