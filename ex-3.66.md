> Exercise 3.66.  Examine the stream `(pairs integers integers)`. Can you make
> any general comments about the order in which the pairs are placed into the
> stream?

       A   |           B
    (1, 1) | (1, 2) (1, 3) (1, 4) ...
    ---------------------------------
           |           C
           | (2, 2) (2, 3) (2, 4) ...
           |        (3, 3) (3, 4) ...
           |               (4, 4) ...

`(pairs integers integers)` enumerates the pair A, then enumerates pairs from
`interleave`d stream of B and C.  C is also enumerated like `pairs`.

       A   |             B
    (1, 1) | (1, 2)   (1, 3) (1, 4) ...
    ---------------------------------
           |             C
           |   Ca   |          Cb
           | (2, 2) | (2, 3) (2, 4) ...
           | --------------------------
           |        |          Cc
           |        | (3, 3) (3, 4) ...
           |        |        (4, 4) ...

Likewise B and C, Cb and Cc are `interleave`d.  So that enumeration of B is
roughly twice as fast as enumeration of C.

The first 15 pairs of `(pairs integers integers)` are:

1.  (1, 1)
2.  (1, 2)
3.  (2, 2)
4.  (1, 3)
5.  (2, 3)
6.  (1, 4)
7.  (3, 3)
8.  (1, 5)
9.  (2, 4)
10. (1, 6)
11. (3, 4)
12. (1, 7)
13. (2, 5)
14. (1, 8)
15. (4, 4)

    1(1, 1)  2(1, 2)  4(1, 3)  6(1, 4)  8(1, 5) 10(1, 6) 12(1, 7) 14(1, 8)
             3(2, 2)  5(2, 3)  9(2, 4) 13(2, 5)
                      7(3, 3) 11(3, 4)
                              15(4, 4)

Let f(i, j) = n for the n-th pair (i, j).  From the above result,

* f(i, i) seems to be 2^i - 1
* f(i, i+1) seems to be f(i, i) + 2^(i-1)
* For n >= 2, f(i, i+n) seems to be f(i, i+1) + (2^i) * (n - (i+1))

So that f(6, 6) should be 31, and f(6, 10) should be 287.

> For example, about how many pairs precede the pair (1,100)? the pair
> (99,100)? the pair (100,100)? (If you can make precise mathematical
> statements here, all the better. But feel free to give more qualitative
> answers if you find yourself getting bogged down.)

* For (1, 100), there are 197 preceding pairs.
* For (99, 100), there are 950,737,950,171,172,051,122,527,404,031 pairs.
* For (1, 100), there are 1,267,650,600,228,229,401,496,703,205,375 pairs.
