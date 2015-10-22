> Exercise 4.73.  Why does `flatten-stream` use `delay` explicitly? What would
> be wrong with defining it as follows:
>
> ```scheme
> (define (flatten-stream stream)
>   (if (stream-null? stream)
>       the-empty-stream
>       (interleave
>        (stream-car stream)
>        (flatten-stream (stream-cdr stream)))))
> ```

`flatten-stream` is an ordinary procedure, so that its argument is evaluated
before evaluating the body of `flatten-stream`.  The same can be said for
`interleave`.  Without explicit `delay`, `flatten-stream` runs forever if
`stream` is an infinite stream.
