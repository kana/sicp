> Exercise 3.9.  In section 1.2.1 we used the substitution model to analyze two
> procedures for computing factorials, a recursive version
>
> ```scheme
> (define (factorial n)
>   (if (= n 1)
>       1
>       (* n (factorial (- n 1)))))
> ```
>
> and an iterative version
>
> ```scheme
> (define (factorial n)
>   (fact-iter 1 1 n))
> (define (fact-iter product counter max-count)
>   (if (> counter max-count)
>       product
>       (fact-iter (* counter product)
>                  (+ counter 1)
>                  max-count)))
> ```
>
> Show the environment structures created by evaluating (factorial 6) using
> each version of the factorial procedure. [14]

For the recursive version:

```
  global env
      |
      v
----------------
|              |
| factorial: ----> @-@ --> parameters: n
|              |   |       body: (if ...)
| ...          |<--'
|              |   --------
|              |<--| n: 6 |<-- E1 (factorial 6)
|              |   --------
|              |   --------
|              |<--| n: 5 |<-- E2 (factorial 5)
|              |   --------
|              |   --------
|              |<--| n: 4 |<-- E3 (factorial 4)
|              |   --------
|              |   --------
|              |<--| n: 3 |<-- E4 (factorial 3)
|              |   --------
|              |   --------
|              |<--| n: 2 |<-- E5 (factorial 2)
|              |   --------
|              |   --------
|              |<--| n: 1 |<-- E6 (factorial 1)
----------------   --------
```

For the iterative version:

```
  global env
      |
      v
----------------
|              |
| factorial: ----> @-@ --> parameters: n
|              |   |       body: (fact-iter 1 1 n)
|              |<--'
| fact-iter: ----> @-@ --> parameters: product, counter, max-count
|              |   |       body: (if ...)
| ...          |<--'
|              |   --------
|              |<--| n: 6 |<-- E0 (factorial 6)
|              |   --------
|              |   ----------------
|              |   | product:   1 |
|              |<--| counter:   1 |<-- E1 (fact-iter 1 1 6)
|              |   | max-count: 6 |
|              |   ----------------
|              |   ----------------
|              |   | product:   1 |
|              |<--| counter:   2 |<-- E2 (fact-iter 1 2 6)
|              |   | max-count: 6 |
|              |   ----------------
|              |   ----------------
|              |   | product:   2 |
|              |<--| counter:   3 |<-- E3 (fact-iter 2 3 6)
|              |   | max-count: 6 |
|              |   ----------------
|              |   ----------------
|              |   | product:   6 |
|              |<--| counter:   4 |<-- E4 (fact-iter 6 4 6)
|              |   | max-count: 6 |
|              |   ----------------
|              |   ----------------
|              |   | product:  24 |
|              |<--| counter:   5 |<-- E5 (fact-iter 24 5 6)
|              |   | max-count: 6 |
|              |   ----------------
|              |   ----------------
|              |   | product: 120 |
|              |<--| counter:   6 |<-- E6 (fact-iter 120 6 6)
|              |   | max-count: 6 |
|              |   ----------------
|              |   ----------------
|              |   | product: 720 |
|              |<--| counter:   7 |<-- E7 (fact-iter 720 7 6)
|              |   | max-count: 6 |
|              |   ----------------
----------------
```

Both versions creates similar environments, but there is an important
difference which is not drawn in the above diagrams.

* To apply the recursive version of `factorial` while evaluating `factorial`,
  we have to keep the caller's frame until finishing application of the sub
  `factorial`.  For example, we have to keep E1, E2, ... and E5 until finishing
  application of `(factorial 1)` at E6.
* While the iterative version of `factorial` does not require to keep callers'
  frames, because we will never refer callers' frames after starting
  application of sub `fact-iter`.
