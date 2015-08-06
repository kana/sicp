> Exercise 4.18.  Consider an alternative strategy for scanning out
> definitions that translates the example in the text to
>
> ```scheme
> (lambda <vars>
>   (let ((u '*unassigned*)
>         (v '*unassigned*))
>     (let ((a <e1>)
>           (b <e2>))
>       (set! u a)
>       (set! v b))
>     <e3>))
> ```
>
> Here a and b are meant to represent new variable names, created by the
> interpreter, that do not appear in the user's program. Consider the solve
> procedure from section 3.5.4:
>
> ```scheme
> (define (solve f y0 dt)
>   (define y (integral (delay dy) y0 dt))
>   (define dy (stream-map f y))
>   y)
> ```
>
> Will this procedure work if internal definitions are scanned out as shown
> in this exercise? What if they are scanned out as shown in the text?
> Explain.

It depends on the order of evaluation on arguments to a procedure.
`solve` works if arguments are evaluated from left to right.
Otherwise it does not work.  Because:

* The scanned-out code in this exercise uses `let`.  `let` is defined by
  a combination of a `lambda`.  And the order of evaluation on subexpressions
  of a combination depends on how the interpreter is implemented.
* But `y` must be defined when evaluating `dy`.

`solve` works if the internal definitions are scanned out as shown in the text,
because `<e1>` is always evaluated before `<e2>` in the scanned-out code.
