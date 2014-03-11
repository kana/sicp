> Exercise 1.7.  The `good-enough?` test used in computing square roots will
> not be very effective for finding the square roots of very small numbers.
> Also, in real computers, arithmetic operations are almost always performed
> with limited precision. This makes our test inadequate for very large
> numbers. Explain these statements, with examples showing how the test fails
> for small and large numbers.

0.001 is not a good threshold for very small numbers.
For example:

	(square 0.03)
	0.0009

	(sqrt 0.0009)
	0.04030062264654547

Because 0.001 is relatively larger than a given number 0.0009.

TODO: 0.001 is not a good threshold also for very large numbers.
For example:

	(square ...)
	...

	(sqrt ...)
	...

> An alternative strategy for implementing `good-enough?` is to watch how guess
> changes from one iteration to the next and to stop when the change is a very
> small fraction of the guess. Design a square-root procedure that uses this
> kind of end test. Does this work better for small and large numbers?

Precision of numbers are limited in real computers.
In other words, there is a lower bound which real computers can operate.
If we iterate `improve` many times, we will reach a number which can not be `improve`d anymore.

	(define (good-enough? guess x)
	  (= guess (improve guess x)))

	(sqrt 0.0009)
	0.03

	(sqrt ...)
	TODO...
