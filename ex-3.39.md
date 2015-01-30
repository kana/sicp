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

* A1: `(* x x)`
* A2: `(set! x <ressult of A1>)`
* B1: `(+ x 1)`)
* B2: `(set! x <ressult of B1>)`

Note that:

* A1, B1 and B2 are not interleaved.
* But A2 might be interleaved into B1 and B2.

Possible orderings are:

* A1 (10 * 10) -> A2 (x = 100) -> B1 (100 + 1) -> B2 (x = 101)
* A1 (10 * 10) -> B1 (10 +  1) -> A2 (x = 100) -> B2 (x =  11)
* A1 (10 * 10) -> B1 (10 +  1) -> B2 (x =  11) -> A2 (x = 100)
* B1 (10 +  1) -> B2 (x =  11) -> A1 (11 * 11) -> A2 (x = 121)

So that 11, 100, 101 and 121 remain.
