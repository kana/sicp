> Exercise 3.66.  Examine the stream `(pairs integers integers)`. Can you make
> any general comments about the order in which the pairs are placed into the
> stream? For example, about how many pairs precede the pair (1,100)? the pair
> (99,100)? the pair (100,100)? (If you can make precise mathematical
> statements here, all the better. But feel free to give more qualitative
> answers if you find yourself getting bogged down.)

For example, the first 20 pairs are enumerated in the following order:

1. (1 1)
2. (1 2)
3. (2 2)
4. (1 3)
5. (2 3)
6. (1 4)
7. (3 3)
8. (1 5)
9. (2 4)
10. (1 6)
11. (3 4)
12. (1 7)
13. (2 5)
14. (1 8)
15. (4 4)
16. (1 9)
17. (2 6)
18. (1 10)
19. (3 5)
20. (1 11)

```
 1(1 1)  2(1 2)  4(1 3)  6(1 4)  8(1 5) 10(1 6) 12(1 7) 14(1 8) 16(1 9) 18(1 10) 20(1 11)
         3(2 2)  5(2 3)  9(2 4) 13(2 5) 17(2 6)
                 7(3 3) 11(3 4) 19(3 5)
                        15(4 4)
```

TODO: So... so that...?
