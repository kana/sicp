> Exercise 3.39.  Which of the five possibilities in the parallel execution
> shown above remain if we instead serialize execution as follows:
>
> ```scheme
> (define x 10)
>
> (define s (make-serializer))
>
> (parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
>                   (s (lambda () (set! x (+ x 1)))))
> ```

To simplify description, let's call interleavable pieces of code as follows:

* A: (* x x)
* B: Assign the result of (* x x) to x
* P: (set! x (+ x 1))

Possible orderings are:

* A (10 * 10) -> B (x = 100) -> P (x = 100 + 1)
* A (10 * 10) -> P (x = 10 + 1) -> B (x = 100)
* P (x = 10 + 1) -> A (11 * 11) -> B (x = 121)

So that 100, 101 and 121 remain.
