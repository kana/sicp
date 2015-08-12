> Exercise 4.23.  Alyssa P. Hacker doesn't understand why `analyze-sequence`
> needs to be so complicated. All the other analysis procedures are
> straightforward transformations of the corresponding evaluation procedures
> (or eval clauses) in section 4.1.1. She expected `analyze-sequence` to look
> like this:
>
> (define (analyze-sequence exps)
>   (define (execute-sequence procs env)
>     (cond ((null? (cdr procs)) ((car procs) env))
>           (else ((car procs) env)
>                 (execute-sequence (cdr procs) env))))
>   (let ((procs (map analyze exps)))
>     (if (null? procs)
>         (error "Empty sequence -- ANALYZE"))
>     (lambda (env) (execute-sequence procs env))))
>
> Eva Lu Ator explains to Alyssa that the version in the text does more of the
> work of evaluating a sequence at analysis time. Alyssa's sequence-execution
> procedure, rather than having the calls to the individual execution
> procedures built in, loops through the procedures in order to call them: In
> effect, although the individual expressions in the sequence have been
> analyzed, the sequence itself has not been.
>
> Compare the two versions of `analyze-sequence`. For example, consider the
> common case (typical of procedure bodies) where the sequence has just one
> expression.


> What work will the execution procedure produced by Alyssa's program do?

It loops over a single-element list `procs` and execute the element.


> What about the execution procedure produced by the program in the text above?

The execution procedure returned by `analyze-sequence` is the same as the
execution procedure returned by `(analyze (car exps))`.


> How do the two versions compare for a sequence with two expressions?

Alyssa's version still analyzes the sequence itself at each evaluation, while
the original version analyzes the sequence itself only once.  So that there is
no `null?` check in the execution procedure produced by the original version.
