> Exercise 3.12.  The following procedure for appending lists was introduced in
> section 2.2.1:
>
> ```scheme
> (define (append x y)
>   (if (null? x)
>       y
>       (cons (car x) (append (cdr x) y))))
> ```
>
> `Append` forms a new list by successively consing the elements of `x` onto
> `y`. The procedure `append!` is similar to `append`, but it is a mutator
> rather than a constructor. It appends the lists by splicing them together,
> modifying the final pair of `x so` that its `cdr` is now `y`. (It is an error
> to call `append!` with an empty `x`.)
>
> ```scheme
> (define (append! x y)
>   (set-cdr! (last-pair x) y)
>   x)
> ```
>
> Here `last-pair` is a procedure that returns the last pair in its argument:
>
> ```scheme
> (define (last-pair x)
>   (if (null? (cdr x))
>       x
>       (last-pair (cdr x))))
> ```
>
> Consider the interaction
>
> ```scheme
> (define x (list 'a 'b))
> (define y (list 'c 'd))
> (define z (append x y))
> z
> (a b c d)
> (cdr x)
> <response>
> (define w (append! x y))
> w
> (a b c d)
> (cdr x)
> <response>
> ```
>
> What are the missing *<response>*s? Draw box-and-pointer diagrams to explain
> your answer.

The first <response> is `(b)`, because the environment is as follows:

```
x---->[o][o]-->[o][/]
       |        |
       v        v
      [a]      [b]

z---->[o][o]-->[o][o]--.
       |        |      |
       v        v      |
      [a]      [b]     |
                       |
                    y--*->[o][o]-->[o][/]
                           |        |
                           v        v
                          [c]      [d]
```

The second <response> is `(b c d)`, because the environment is as follows:

```
w--.
   |
x--*->[o][o]-->[o][o]--.
       |        |      |
       v        v      |
      [a]      [b]     |
                       |
z---->[o][o]-->[o][o]--*
       |        |      |
       v        v      |
      [a]      [b]     |
                       |
                    y--*->[o][o]-->[o][/]
                           |        |
                           v        v
                          [c]      [d]
```
