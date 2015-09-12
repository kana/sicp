> Exercise 4.39.  Does the order of the restrictions in the `multiple-dwelling`
> procedure affect the answer? Does it affect the time to find an answer? If
> you think it matters, demonstrate a faster program obtained from the given
> one by reordering the restrictions. If you think it does not matter, argue
> your case.

It depends on how `amb` and `require` are ordered.

The order of the restrictions in the `multiple-dwelling` procedure does not
matter for performance.  Combinations of `amb` and `require` can be treated as
a loop construct in C-like language like this:

```c
for (int baker = 1; baker <= 5; baker++)
{
    for (int cooper = 1; cooper <= 5; cooper++)
    {
        ....
            for (int smith = 1; smith <= 5; smith++)
            {
                if (baker == 5)
                    continue;
                if (cooper == 1)
                    continue;
                ...
                return makeResult(baker, cooper, ..., smith);
            }
        ....
    }
}
```

In this case all possible values are generated then are tested.  So that the
order of the restrictions does not matter.

If the `multiple-dwelling` procedure is rewritten like this:

```scheme
(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5)))
    (require (not (= baker 5)))
    (let ((cooper (amb 1 2 3 4 5)))
      (require (not (= cooper 1)))
      ...
      (let ((smith (amb 1 2 3 4 5)))
        (require
          (distinct? (list baker cooper fletcher miller smith)))
        (require (not (= (abs (- smith fletcher)) 1)))
        ...))))
```

C-like language equivalent for the above procedure would be like this:

```c
for (int baker = 1; baker <= 5; baker++)
{
    if (baker == 5)
        continue;
    for (int cooper = 1; cooper <= 5; cooper++)
    {
        if (cooper == 1)
            continue;
            for (int smith = 1; smith <= 5; smith++)
            {
                ...
            }
        ....
    }
}
```

This version does not generate all possible values.  Many possible values are
cut in early steps (like `baker == 5`, `cooper == 1`, etc).  So that this
version is faster than the original.
