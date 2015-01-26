> Exercise 3.57.  How many additions are performed when we compute the *n*th
> Fibonacci number using the definition of `fibs` based on the `add-streams`
> procedure? Show that the number of additions would be exponentially greater
> if we had implemented `(delay <exp>)` simply as `(lambda () <exp>)`, without
> using the optimization provided by the `memo-proc` procedure described in
> section 3.5.1. [64]

```scheme
(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))
```

Let's denote a(n) for the number of additions to compute the n-th Fibonacci number.

* The number of additions performed by `(add-streams s1 s2)` is equal to the
  minimum length of `s1` and `s2`.  If the minimum length is n, the number of
  additions is also n.
* `cons-stream` delays evaluation of its cdr.  And the result of a delayed
  expression is memoized.

So that

* a(1) = a(2) = 0
* a(n) = n - 2

If `cons-stream` doesn't memoize its cdr part,

* a(1) = a(2) = 0
* a(n) = a(n - 1) + a(n - 2) + 1

For example,

* a(3) = a(2) + a(1) + 1 = 0 + 0 + 1
* a(4) = a(3) + a(2) + 1 = 1 + 0 + 1 = 2
* a(5) = a(4) + a(3) + 1 = 2 + 1 + 1 = 4
* a(6) = a(5) + a(4) + 1 = 4 + 2 + 1 = 7
* a(7) = a(6) + a(5) + 1 = 7 + 4 + 1 = 12
* a(8) = a(7) + a(6) + 1 = 12 + 7 + 1 = 20
* a(9) = a(8) + a(7) + 1 = 20 + 12 + 1 = 33
* ...

It is a series of sums of Fibonacci numbers,
and it is exponentially greater than memoized one.
