> Exercise 3.63.  Louis Reasoner asks why the `sqrt-stream` procedure was not
> written in the following more straightforward way, without the local variable
> guesses:
>
> ```scheme
> (define (sqrt-stream x)
>   (cons-stream 1.0
>                (stream-map (lambda (guess)
>                              (sqrt-improve guess x))
>                            (sqrt-stream x))))
> ```
>
> Alyssa P. Hacker replies that this version of the procedure is considerably
> less efficient because it performs redundant computation. Explain Alyssa's
> answer. Would the two versions still differ in efficiency if our
> implementation of `delay` used only `(lambda () <exp>)` without using the
> optimization provided by `memo-proc` (section 3.5.1)?

The original version is:

```scheme
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)
```

Though Louis' version produces the same result as the original version,
Louis' version doesn't reuse an existing stream to compute more terms.
To compute the n-th term with Louis' version, streams are created
1 + 2 + ... + n-1 + n times.  So that it's very inefficient.

If results of `delay`ed expressions are not memoized,
it means that terms of streams are not memoized.
Therefore two versions does not differ.  Both become inefficient.
