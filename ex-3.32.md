> Exercise 3.32.  The procedures to be run during each time segment of the
> agenda are kept in a queue. Thus, the procedures for each segment are called
> in the order in which they were added to the agenda (first in, first out).
> Explain why this order must be used.

The order of signal changes is important even in the same time segment.  If
procedures for each segment are not called in the FIFO order, simulation will
not be done in the right order and it causes wrong results.




> In particular, trace the behavior of an and-gate whose inputs change from 0,1
> to 1,0 in the same segment and say how the behavior would differ if we stored
> a segment's procedures in an ordinary list, adding and removing procedures
> only at the front (last in, first out).

> ```scheme
> (define (and-gate a1 a2 output)
>   (define (and-action-procedure)
>     (let ((new-value
>            (logical-and (get-signal a1) (get-signal a2))))
>       (after-delay and-gate-delay
>                    (lambda ()
>                      (set-signal! output new-value)))))
>   (add-action! a1 and-action-procedure)
>   (add-action! a2 and-action-procedure)
>   'ok)
> ```
>
> ```scheme
> (define inverter-delay 2)
> (define and-gate-delay 3)
> (define or-gate-delay 5)
> ```

Consider the following interation:

```scheme
(define a1 (make-wire))
(define a2 (make-wire))
(define ao (and-gate a1 a2 ao))
(propagate)         ; (*0)

(set-signal! a1 0)
(set-signal! a2 1)
(propagate)         ; (*1)

(set-signal! a1 1)
(set-signal! a2 0)
(propagate)         ; (*2)
```

After evaluating (*0), the agenda is empty and the simulated time is 3.

Before evaluating (*1), the agenda contains a segment with one
`and-action-procedure` added by `a2`, because `set-signal!` on `a1` does not
change its signal and no actions are run.  So that the order of calling
procedures in each segment does not matter at this point.

Before evaluating (*2),
the agenda contains a segment with two `and-action-procedure`s.
The former is added by `a1` and the latter is added by `a2`.

If procedures are called in in the FIFO order, `a1`'s action runs first then
`a2`'s action runs.  In `a1`'s action, both signals are set to 1, so that the
and-gate's output is set to 1.  In `a2`'s action, only `a1` is set to 1, so
that the and-gate's output is set to 0.  As a result, the and-gate's output is
not changed.

If procedures are called in in the LIFO order, `a2`'s action runs first then
`a1`'s action runs.  The and-gate's output is set to 0 by `a2`'s action then is
reset to 1 by `a1`'s action.  As a result, the and-gate's output is set to 1,
but this simulated result is not right.
