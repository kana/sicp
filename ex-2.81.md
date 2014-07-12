> Exercise 2.81.  Louis Reasoner has noticed that `apply-generic` may try to
> coerce the arguments to each other's type even if they already have the same
> type.  Therefore, he reasons, we need to put procedures in the coercion table
> to "coerce" arguments of each type to their own type. For example, in
> addition to the `scheme-number->complex` coercion shown above, he would do:
>
> ```scheme
> (define (scheme-number->scheme-number n) n)
> (define (complex->complex z) z)
> (put-coercion 'scheme-number 'scheme-number
>               scheme-number->scheme-number)
> (put-coercion 'complex 'complex complex->complex)
> ```


> a. With Louis's coercion procedures installed, what happens if
> `apply-generic` is called with two arguments of type scheme-number or two
> arguments of type complex for an operation that is not found in the table for
> those types? For example, assume that we've defined a generic exponentiation
> operation:
>
> ```scheme
> (define (exp x y) (apply-generic 'exp x y))
> ```
>
> and have put a procedure for exponentiation in the Scheme-number package but
> not in any other package:
>
> ```scheme
> ;; following added to Scheme-number package
> (put 'exp '(scheme-number scheme-number)
>  (lambda (x y) (tag (expt x y)))) ; using primitive expt
> ```
>
> What happens if we call exp with two complex numbers as arguments?

In that case, such calls will be infinite loops.

New `apply-generic` calls `apply-generic` on the same operation with coerced
values if an appropriate procedure for the types of given arguments is not
found.  If we call `exp` with two complex numbers,

1. The first `apply-generic` looks up the table for an appropriate procedure,
   but it does not exist.
2. So the first `apply-generic` "coerces" given arguments to complex numbers,
   then calls the second `apply-generic` on `exp` with "coerced" arguments.
3. But "coerced" arguments are also complex numbers.  The second
   `apply-generic` are called with the same arguments as ones given to the
   first `apply-generic`.  So that the second `apply-generic` does the same job
   as the first `apply-generic`.  It is an infinite loop.


> b. Is Louis correct that something had to be done about coercion with
> arguments of the same type, or does `apply-generic` work correctly as is?

At this moment, Louis' idea causes infinite loops.  So that he is not correct.

But "coercing" a value to the same type might be a good idea to simplify
`apply-generic` implementation.  Currently `apply-generic` supports automatic
coercion only for generic operations with two arguments.  If we try to support
arbitrary number of arguments, Louis' idea might be helpful.


> c. Modify `apply-generic` so that it doesn't try coercion if the two
> arguments have the same type.
