> Exercise 3.27.  *Memoization* (also called *tabulation*) is a technique that
> enables a procedure to record, in a local table, values that have previously
> been computed. This technique can make a vast difference in the performance
> of a program. A memoized procedure maintains a table in which values of
> previous calls are stored using as keys the arguments that produced the
> values. When the memoized procedure is asked to compute a value, it first
> checks the table to see if the value is already there and, if so, just
> returns that value. Otherwise, it computes the new value in the ordinary way
> and stores this in the table. As an example of memoization, recall from
> section 1.2.2 the exponential process for computing Fibonacci numbers:
>
> ```scheme
> (define (fib n)
>   (cond ((= n 0) 0)
>         ((= n 1) 1)
>         (else (+ (fib (- n 1))
>                  (fib (- n 2))))))
> ```
>
> The memoized version of the same procedure is
>
> ```scheme
> (define memo-fib
>   (memoize (lambda (n)
>              (cond ((= n 0) 0)
>                    ((= n 1) 1)
>                    (else (+ (memo-fib (- n 1))
>                             (memo-fib (- n 2))))))))
> ```
>
> where the memoizer is defined as
>
> ```scheme
> (define (memoize f)
>   (let ((table (make-table)))
>     (lambda (x)
>       (let ((previously-computed-result (lookup x table)))
>         (or previously-computed-result
>             (let ((result (f x)))
>               (insert! x result table)
>               result))))))
> ```




> Draw an environment diagram to analyze the computation of `(memo-fib 3)`.

The environment before evaluating `(memo-fib 3)`:

```
         --------------------------------------
         |                                    |
global-->| memo-fib:--------------------------------------.
env      | memoize:--.                        |           |
         |           |                        |           |
         ------------|-------------------------           |
             ^       |     ^           ^                  |
             |       |     |           |                  |
          ,--+-------'  ,--+-----------+---.              |
          |  |          |  |           |   |              |
          v  |          v  |          -----|--            |
         @=@-'         @=@-'          |f:--' |<--E1       |
         |             |              --------            |
         v             v               ^                  |
   parameters: f    parameters: n      |                  |
   body: (let ...)  body: (cond ...)  -------------       |
                                      |table: ... |<--E2  |
                                      -------------       |
                                       ^                  |
                                       |                  |
                                    ,--+------------------'
                                    |  |
                                    v  |
                                   @=@-'
                                   |
                                   v
                              parameters: x
                              body: (let ...)
```

The environment while evaluating `(memo-fib 3)`:

```
         -------------------------------------------------------------
         |                                                           |
global-->| memoize: ...                                              |
env      | memo-fib:-.                                               |
         |          /                                                |
         ----------/--------------------------------------------------
           ^      |       ^           ^        ^        ^        ^
           |      |       |           |        |        |        |
        ,--+------+-------+---.     -------- -------- -------- --------
        |  |      |       |   |     | n: 3 | | n: 2 | | n: 1 | | n: 0 |
        v  |      |      -----|--   -------- -------- -------- --------
       @=@-'      | E1-->|f:--' |     ^        ^        ^        ^
       |          |      --------     |E4      |E6      |E8      |E10
       v          |       ^         (f 3)    (f 2)    (f 1)    (f 0)
 parameters: n    |       |
 body: (cond ...) |      -------------   -----------------
                  |      |           |   | 0: 0 (via E9) |
       ,----------' E2-->|table: ------->| 1: 1 (via E7) |
       |                 |           |   | 2: 1 (via E5) |
       |                 |           |   | 3: 2 (via E3) |
       |                 -------------   -----------------
       |                 ^ ^ ^ ^ ^ ^
       |                 | | | | | |
       |                 | | | | | `----------------------------------------.
       |                 | | | | `----------------------------.             |
       |  ,--------------' | | `----------------.             |             |
       |  |         ,------' `----.             |             |             |
       |  |         |             |             |             |             |
       |  |       --------      --------      --------      --------      --------
       |  |       | x: 3 |      | x: 2 |      | x: 1 |      | x: 0 |      | x: 1 |
       |  |       --------      --------      --------      --------      --------
      @=@-'        ^ ^           ^ ^           ^ ^           ^ ^           ^ ^
      |            | |E3         | |E5         | |E7         | |E9         | |E11
      |            |(memo-fib 3) |(memo-fib 2) |(memo-fib 1) |(memo-fib 0) |(memo-fib 1)
      |            |             |             |             |             |
      v           ------------- ------------- ------------- ------------- -------------
 parameters: x    | result: 2 | | result: 1 | | result: 1 | | result: 0 | | result: 1 |
 body: (let ...)  ------------- ------------- ------------- ------------- -------------
```

In this diagram, I assumed operands are evaluated from left to right, to
simplify analyzation.

The most important point is that `(memo-fib 1)` is evaluated twice.
The first time (E7) is evaluated from `(memo-fib 2)`, and
the second time (E11) is evaluated from `(memo-fib 3)`.
While the former calls `(f 1)` to compute the result,
the latter returns the previously computed result in the table (in E2).

The same can be said if operands are evaluated in any order.




> Explain why `memo-fib` computes the *n*th Fibonacci number in a number of
> steps proportional to *n*.

As described above, recalculation will never be happened.  So that required
steps to evaluate `(memo-fib n)` is proportional to *n*.  But its ratio depends
on the performance of looking up the table.




> Would the scheme still work if we had simply defined `memo-fib` to be
> `(memoize fib)`?

No.  `fib` calls `fib` recursively.  `fib` itself is not memoized.  If
`memo-fib` is defined by `(memoize fib)`, only the final result is recorded in
the table.  Intermediate calls of `fib` will never look up the table to avoid
recalculation.
