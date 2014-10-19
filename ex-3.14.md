> Exercise 3.14.  The following procedure is quite useful, although obscure:
>
> ```scheme
> (define (mystery x)
>   (define (loop x y)
>     (if (null? x)
>         y
>         (let ((temp (cdr x)))
>           (set-cdr! x y)
>           (loop temp x))))
>   (loop x '()))
> ```
>
> `Loop` uses the “temporary” variable temp to hold the old value of the
> `cdr` of `x`, since the `set-cdr!` on the next line destroys the `cdr`.
> Explain what `mystery` does in general. Suppose `v` is defined by `(define
> v (list 'a 'b 'c 'd))`. Draw the box-and-pointer diagram that represents the
> list to which `v` is bound. Suppose that we now evaluate `(define w (mystery
> v))`. Draw box-and-pointer diagrams that show the structures `v` and `w`
> after evaluating this expression. What would be printed as the values of `v`
> and `w`?

Result of `(define v (list 'a 'b 'c 'd))` is as follows:

```
v---->[o][o]-->[o][o]-->[o][o]-->[o][/]
       |        |        |        |
       v        v        v        v
      [a]      [b]      [c]      [d]
```

Consider evaluating `(define w (mystery v))`.

1. Just after callling the first `loop`:

   ```
   x--.
      |
   v--*->[o][o]-->[o][o]-->[o][o]-->[o][/]
          |        |        |        |
          v        v        v        v
         [a]      [b]      [c]      [d]

   y---->[/]
   ```

2. Just before calling the second `loop`:

   ```
   x--.   temp --.
      |          |
   v--*->[o][/]  `->[o][o]-->[o][o]-->[o][/]
          |          |        |        |
          v          v        v        v
         [a]        [b]      [c]      [d]

   y---->[/]
   ```

3. Just after calling the second `loop`:

   ```
   y--.      x --.
      |          |
   v--*->[o][/]  `->[o][o]-->[o][o]-->[o][/]
          |          |        |        |
          v          v        v        v
         [a]        [b]      [c]      [d]
   ```

4. Just before calling the third `loop`:

   ```
            y--.
               |
            v--*
               |
   x-->[o][o]--*->[o][/]  temp-->[o][o]-->[o][/]
        |          |              |        |
        v          v              v        v
       [b]        [a]            [c]      [d]

5. Just after calling the third `loop`:

   ```
            v--.
               |
   y-->[o][o]--*->[o][/]     x-->[o][o]-->[o][/]
        |          |              |        |
        v          v              v        v
       [b]        [a]            [c]      [d]
   ```

6. Just before calling the fourth `loop`:

   ```
           y---.       v--.
               |          |
   x-->[o][o]--*->[o][o]--*->[o][/]    temp-->[o][/]
        |          |          |                |
        v          v          v                v
       [c]        [b]        [a]              [d]
   ```

7. Just after calling the fourth `loop`:

   ```
                       v--.
                          |
   y-->[o][o]---->[o][o]--*->[o][/]       x-->[o][/]
        |          |          |                |
        v          v          v                v
       [c]        [b]        [a]              [d]
   ```

8. Just before calling the fifth `loop`:

   ```
            y--.                  v--.
               |                     |
   x-->[o][o]--*->[o][o]---->[o][o]--*->[o][/]   temp-->[/]
        |          |          |          |
        v          v          v          v
       [d]        [c]        [b]        [a]
   ```

9. Just after calling the fifth `loop`:

   ```
                                  v--.
                                     |
   y-->[o][o]---->[o][o]---->[o][o]--*->[o][/]   x-->[/]
        |          |          |          |
        v          v          v          v
       [d]        [c]        [b]        [a]
   ```

10. After binding the result of `mystery` to `w`:

   ```
   w-->[o][o]---->[o][o]---->[o][o]--*->[o][/]   v-->[/]
        |          |          |          |
        v          v          v          v
       [d]        [c]        [b]        [a]
   ```

As a result, `()` will be printed as the value of `v`,
while `(d c b a)` will be printed as the value of `w`.

Therefore, `mystery` makes a reversed list **in-place**.
Cons cells will never be allocated in process of `mystery`.
