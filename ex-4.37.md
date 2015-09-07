> Exercise 4.37.  Ben Bitdiddle claims that the following method for
> generating Pythagorean triples is more efficient than the one in exercise
> 4.35. Is he correct? (Hint: Consider the number of possibilities that must
> be explored.)
>
> ```scheme
> (define (a-pythagorean-triple-between low high)
>   (let ((i (an-integer-between low high))
>         (hsq (* high high)))
>     (let ((j (an-integer-between i high)))
>       (let ((ksq (+ (* i i) (* j j))))
>         (require (>= hsq ksq))
>         (let ((k (sqrt ksq)))
>           (require (integer? k))
>           (list i j k))))))
> ```

Ben is correct.  The original version enumerates many integers also for k, even
if there is no more triples that satisfies i^2 + j^2 = k^2 where values of
i and j are already defined.

While Ben's version does not enumerate values for k.  So that the number of
possibilities to be explored by Ben' version is smaller than the one by the
original version.
