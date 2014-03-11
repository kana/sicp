> Exercise 1.10.  The following procedure computes a mathematical function
> called Ackermann's function.
>
>     (define (A x y)
>       (cond ((= y 0) 0)
>             ((= x 0) (* 2 y))
>             ((= y 1) 2)
>             (else (A (- x 1)
>                      (A x (- y 1))))))
>
> What are the values of the following expressions?
>
>     (A 1 10)

1024

>     (A 2 4)

65536

>     (A 3 3)

65536




> Consider the following procedures, where A is the procedure defined above:
>
>     (define (f n) (A 0 n))
>
>     (define (g n) (A 1 n))
>
>     (define (h n) (A 2 n))
>
>     (define (k n) (* 5 n n))
>
> Give concise mathematical definitions for the functions computed by the
> procedures f, g, and h for positive integer values of n. For example, (k n)
> computes 5n^2.

(A 0 n) is equivalent to (* 2 n), so that (f n) computes 2n.

(A 1 n) is equivalent to:

	(A (- 1 1) (A 1 (- n 1)))
	= (A 0 (A 1 (- n 1)))
	= (A 0 (g (n - 1)))
	= (f (g (n - 1)))
	...
	= (f (f ... (f (g 1))))
	  ~~~~~~~~~~~~
	      n - 1
	= (f (f ... (f 2)))
	  ~~~~~~~~~~~~
	      n - 1
	= 2 * 2 * ... * 2
	  ~~~~~~~~~~~~~~~
	         n
	= 2^n

Therefore (g n) computes 2^n.

(A 2 n) is equivalent to:

	(A 2 n)
	= (A (- 2 1) (A 2 (- n 1)))
	= (A 1 (A 2 (- n 1)))
	= (g (A 2 (- n 1)))
	= (g (g (A 2 (- n 2))))
	...
	= (g (g ... (g (A 2 1))))
	  ~~~~~~~~~~~~
	     n - 1
	= (g (g ... (g 2)))
	  ~~~~~~~~~~~~
	     n - 1
	= ((2^2)^2)^2...^2
	        ~~~~~~~~~~
		   n - 1
	= 2^(2^n)

Therefore (h n) computes 2^(2^n).
