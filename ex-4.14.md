> Exercise 4.14.  Eva Lu Ator and Louis Reasoner are each experimenting with
> the metacircular evaluator. Eva types in the definition of `map`, and runs
> some test programs that use it. They work fine. Louis, in contrast, has
> installed the system version of `map` as a primitive for the metacircular
> evaluator. When he tries it, things go terribly wrong. Explain why Louis's
> `map` fails even though Eva's works.

`map` takes a procedure and one or more lists.  Lists of the underlying Lisp
system and lists of the metacircular Lisp are represented in the same way, but
procedures of both Lisp systems are (usually) represented in different ways.

Eva's `map` expects a procedure defined in the metacircular Lisp, while Louis's
`map` expects a procedure defined in the underlying Lisp.  And both `map`s are
applied with procedures defined in the metacircular Lisp.  That's why Louis's
`map` fails.

In short:

    ------------------------------------------------------------
    |                    | Eva's `map`      | Louis's `map`    |
    ------------------------------------------------------------
    | Expected procedure | Metacircular one | Underlying one   |
    | Given procedure    | Metacircular one | Metacircular one |
    ------------------------------------------------------------
