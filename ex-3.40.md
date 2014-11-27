> Exercise 3.40.  Give all possible values of `x` that can result from executing
>
> ```scheme
> (define x 10)
>
> (parallel-execute (lambda () (set! x (* x x)))
>                   (lambda () (set! x (* x x x))))
> ```

To simplify description, here I assume that subexpressions of a combination are
evaluated from left to right, because the order of evaluation does not matter
for these multiplications.

Let's call interleavable pieces of code as follows:

* P11: P1 accesss the value of the first `x`.
* P12: P1 accesss the value of the second `x`.
* P13: P1 sets the result of the multiplication.
* P21: P2 accesss the value of the first `x`.
* P22: P2 accesss the value of the second `x`.
* P23: P2 accesss the value of the third `x`.
* P24: P2 sets the result of the multiplication.

Possible orders of execution are:

* P11 ( 10) -> P12 ( 10) -> P13 (100) -> P21 ( 100) -> P22 ( 100) -> P23 ( 100) -> P24 (1000000)
* P11 ( 10) -> P12 ( 10) -> P21 ( 10) -> P13 ( 100) -> P22 ( 100) -> P23 ( 100) -> P24 (100000)
* P11 ( 10) -> P12 ( 10) -> P21 ( 10) -> P22 (  10) -> P13 ( 100) -> P23 ( 100) -> P24 (10000)
* P11 ( 10) -> P12 ( 10) -> P21 ( 10) -> P22 (  10) -> P23 (  10) -> P13 ( 100) -> P24 (1000)
* P11 ( 10) -> P12 ( 10) -> P21 ( 10) -> P22 (  10) -> P23 (  10) -> P24 (1000) -> P13 (100)
* P11 ( 10) -> P21 ( 10) -> P12 ( 10) -> P13 ( 100) -> P22 ( 100) -> P23 ( 100) -> P24 (100000)
* P11 ( 10) -> P21 ( 10) -> P12 ( 10) -> P22 (  10) -> P13 ( 100) -> P23 ( 100) -> P24 (10000)
* P11 ( 10) -> P21 ( 10) -> P12 ( 10) -> P22 (  10) -> P23 (  10) -> P13 ( 100) -> P24 (1000)
* P11 ( 10) -> P21 ( 10) -> P12 ( 10) -> P22 (  10) -> P23 (  10) -> P24 (1000) -> P13 (100)
* P11 ( 10) -> P21 ( 10) -> P22 ( 10) -> P12 (  10) -> P13 ( 100) -> P23 ( 100) -> P24 (10000)
* P11 ( 10) -> P21 ( 10) -> P22 ( 10) -> P12 (  10) -> P23 (  10) -> P13 ( 100) -> P24 (1000)
* P11 ( 10) -> P21 ( 10) -> P22 ( 10) -> P12 (  10) -> P23 (  10) -> P24 (1000) -> P13 (100)
* P11 ( 10) -> P21 ( 10) -> P22 ( 10) -> P23 (  10) -> P12 (  10) -> P13 ( 100) -> P24 (1000)
* P11 ( 10) -> P21 ( 10) -> P22 ( 10) -> P23 (  10) -> P12 (  10) -> P24 (1000) -> P13 (100)
* P11 ( 10) -> P21 ( 10) -> P22 ( 10) -> P23 (  10) -> P24 (1000) -> P12 (1000) -> P13 (10000)
* P21 ( 10) -> P11 ( 10) -> P12 ( 10) -> P13 ( 100) -> P22 ( 100) -> P23 ( 100) -> P24 (100000)
* P21 ( 10) -> P11 ( 10) -> P12 ( 10) -> P22 (  10) -> P13 ( 100) -> P23 ( 100) -> P24 (10000)
* P21 ( 10) -> P11 ( 10) -> P12 ( 10) -> P22 (  10) -> P23 (  10) -> P13 ( 100) -> P24 (1000)
* P21 ( 10) -> P11 ( 10) -> P12 ( 10) -> P22 (  10) -> P23 (  10) -> P24 (1000) -> P13 (100)
* P21 ( 10) -> P11 ( 10) -> P22 ( 10) -> P12 (  10) -> P13 ( 100) -> P23 ( 100) -> P24 (10000)
* P21 ( 10) -> P11 ( 10) -> P22 ( 10) -> P12 (  10) -> P23 (  10) -> P13 ( 100) -> P24 (1000)
* P21 ( 10) -> P11 ( 10) -> P22 ( 10) -> P12 (  10) -> P23 (  10) -> P24 (1000) -> P13 (100)
* P21 ( 10) -> P11 ( 10) -> P22 ( 10) -> P23 (  10) -> P12 (  10) -> P13 ( 100) -> P24 (1000)
* P21 ( 10) -> P11 ( 10) -> P22 ( 10) -> P23 (  10) -> P12 (  10) -> P24 (1000) -> P13 (100)
* P21 ( 10) -> P11 ( 10) -> P22 ( 10) -> P23 (  10) -> P24 (1000) -> P12 (1000) -> P13 (10000)
* P21 ( 10) -> P22 ( 10) -> P11 ( 10) -> P12 (  10) -> P13 ( 100) -> P23 ( 100) -> P24 (10000)
* P21 ( 10) -> P22 ( 10) -> P11 ( 10) -> P12 (  10) -> P23 (  10) -> P13 ( 100) -> P24 (1000)
* P21 ( 10) -> P22 ( 10) -> P11 ( 10) -> P12 (  10) -> P23 (  10) -> P24 (1000) -> P13 (100)
* P21 ( 10) -> P22 ( 10) -> P11 ( 10) -> P23 (  10) -> P12 (  10) -> P13 ( 100) -> P24 (1000)
* P21 ( 10) -> P22 ( 10) -> P11 ( 10) -> P23 (  10) -> P12 (  10) -> P24 (1000) -> P13 (100)
* P21 ( 10) -> P22 ( 10) -> P11 ( 10) -> P23 (  10) -> P24 (1000) -> P12 (1000) -> P13 (10000)
* P21 ( 10) -> P22 ( 10) -> P23 ( 10) -> P11 (  10) -> P12 (  10) -> P13 ( 100) -> P24 (1000)
* P21 ( 10) -> P22 ( 10) -> P23 ( 10) -> P11 (  10) -> P12 (  10) -> P24 (1000) -> P13 (100)
* P21 ( 10) -> P22 ( 10) -> P23 ( 10) -> P11 (  10) -> P24 (1000) -> P12 (1000) -> P13 (10000)
* P21 ( 10) -> P22 ( 10) -> P23 ( 10) -> P24 (1000) -> P11 (1000) -> P12 (1000) -> P13 (1000000)

So that possible values are:

* 100
* 1000
* 10000
* 100000
* 1000000

> Which of these possibilities remain if we instead use serialized procedures:
>
> ```scheme
> (define x 10)
>
> (define s (make-serializer))
>
> (parallel-execute (s (lambda () (set! x (* x x))))
>                   (s (lambda () (set! x (* x x x)))))
> ```

In this case, P1 and P2 are not interleaved.  So that possible combinations are:

* P11 ( 10) -> P12 ( 10) -> P13 (100) -> P21 ( 100) -> P22 ( 100) -> P23 ( 100) -> P24 (1000000)
* P21 ( 10) -> P22 ( 10) -> P23 ( 10) -> P24 (1000) -> P11 (1000) -> P12 (1000) -> P13 (1000000)

Therefore the only one possible value is 1000000.
