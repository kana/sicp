> Exercise 3.34.  Louis Reasoner wants to build a squarer, a constraint device
> with two terminals such that the value of connector `b` on the second
> terminal will always be the square of the value `a` on the first terminal. He
> proposes the following simple device made from a multiplier:
>
> ```scheme
> (define (squarer a b)
>   (multiplier a a b))
> ```
>
> There is a serious flaw in this idea. Explain.

Like an adder and a multiplier, a squarer must:

* Computes a square of `a` and set it to `b` if a new value is set to `a`, and
* Computes a square root of `b` and set it to `a` if a new value is set to `b`.

Louis' squarer meets the former, but it doesn't meet the latter.
If a value is set to `b` of Louis' squarer, nothing will be computed.
Because `multiplier` requires that two connectors have values to compute
a value for the last connector.

Try the following interaction:

```scheme
(define a (make-connector))
(define b (make-connector))
(squarer a b)
(probe "A" a)
(probe "B" b)
(set-value! b 9 'user)
```

`a` will not be computed.
