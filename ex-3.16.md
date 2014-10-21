> Exercise 3.16.  Ben Bitdiddle decides to write a procedure to count the
> number of pairs in any list structure. “It's easy,” he reasons. “The
> number of pairs in any structure is the number in the car plus the number in
> the cdr plus one more to count the current pair.” So Ben writes the
> following procedure:
>
> ```scheme
> (define (count-pairs x)
>   (if (not (pair? x))
>       0
>       (+ (count-pairs (car x))
>          (count-pairs (cdr x))
>          1)))
> ```


> Show that this procedure is not correct.

This procedure is not correct, because it counts shared data structures many
times.  For example, consider the following list:

```
z-->[o][o]
     |  |
     v  v
x-->[o][o]-->[o][o]-->[o][/]
     |        |        |
     v        v        v
    [a]      [b]      [c]
```

As the above diagram shows, there are 5 pairs in `z`.
But `(count-paris z)` returns 7, because it counts `x` twice.


> In particular, draw box-and-pointer diagrams representing list structures
> made up of exactly three pairs for which Ben's procedure would return 3;
> return 4; return 7; never return at all.

```scheme
(define z3 (list 'a 'b 'c))
```

```
z3-->[o][o]-->[o][o]-->[o][/]
      |        |        |
      v        v        v
     [a]      [b]      [c]
```

```scheme
(define z4
  (let ([x (list 'a)])
    (list x x)))
```

```
z4-->[o][o]-->[o][/]
      |        |
      |  ,-----'
      |  |
      v  v
 x-->[o][/]
      |
      v
     [a]
```

```scheme
(define z7
  (let* ([x (list 'a)]
         [y (cons x x)])
    (cons y y)))
```

```
z7-->[o][o]   car=3, cdr=3, total=7
      |  |
      v  v
 y-->[o][o]   car=1, cdr=1, total=3
      |  |
      v  v
 x-->[o][/]   car=0, cdr=0, total=1
      |
      v
     [a]
```

```scheme
; Note that make-cycle is defined in Exercise 3.13.
(define z* (make-cycle (list 'a 'b 'c)))
```

```
      ,--------------------.
      |                    |
      v                    |
z*-->[o][o]-->[o][o]-->[o][/]
      |        |        |
      v        v        v
     [a]      [b]      [c]
```
