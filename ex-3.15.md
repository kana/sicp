> Exercise 3.15.  Draw box-and-pointer diagrams to explain the effect of
> `set-to-wow!` on the structures `z1` and `z2` above.

> ```scheme
> (define (set-to-wow! x)
>   (set-car! (car x) 'wow)
>   x)
>
> (define x (list 'a 'b))
> (define z1 (cons x x))
>
> (define z2 (cons (list 'a 'b) (list 'a 'b)))
> ```

The environment after evaluating `(set-to-wow! z1)` is as follows:

```
z1-->[o][o]-->[o][/]
      |        |
      |  ,-----'
      |  |
      v  v
 x-->[o][o]-->[o][/]
      |        |
      v        v
    [wow]     [b]
```

The environment after evaluating `(set-to-wow! z2)` is as follows:

```
z2-->[o][o]-->[o][o]-->[o][/]
      |        |        |
      |        v        v
      |       [a]      [b]
      |                 ^
      |                 |
      `------>[o][o]-->[o][/]
               |
               v
             [wow]
```
