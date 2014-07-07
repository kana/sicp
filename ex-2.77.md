> Exercise 2.77.  Louis Reasoner tries to evaluate the expression (magnitude z)
> where z is the object shown in figure 2.24. To his surprise, instead of the
> answer 5 he gets an error message from apply-generic, saying there is no method
> for the operation magnitude on the types (complex). He shows this interaction
> to Alyssa P. Hacker, who says ``The problem is that the complex-number
> selectors were never defined for complex numbers, just for polar and
> rectangular numbers. All you have to do to make this work is add the following
> to the complex package:''
>
>     (put 'real-part '(complex) real-part)
>     (put 'imag-part '(complex) imag-part)
>     (put 'magnitude '(complex) magnitude)
>     (put 'angle '(complex) angle)
>
> Describe in detail why this works.

Each operation was defined only for `(rectangular)` and `(polar)`.
So that applying these operations to `(complex)` objects failed.

After adding the work suggested by Alyssa, applying these operations to
`(complex)` objects will apply the same operations to contents extracted from
given arguments.  Such contents are typed as `(rectangular)` or `(polar)`.
So that the latter applications will return valid results.

> As an example, trace through all the procedures called in evaluating the
> expression (magnitude z) where z is the object shown in figure 2.24. In
> particular, how many times is apply-generic invoked? What procedure is
> dispatched to in each case?

1. (magnitude '(complex rectangular 3 . 4))
2. (apply-generic 'magnitude '(complex rectangular 3 . 4))
3. (apply magnitude '((rectangular 3 . 4)))
4. (magnitude '(rectangular 3 . 4))
5. (apply-generic 'magnitude '(rectangular 3 . 4))
6. (apply %rectanguler-magnitude% '((3 . 4))))
7. (%rectanguler-magnitude% '(3 . 4)))
8. 5

`apply-generic` is invoked twice.
The former dispatches its process to the generic `magnitude`.
The latter dispatches its process to `magnitude` defined in the rectanguler package.
