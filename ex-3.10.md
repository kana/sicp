> Exercise 3.10.  In the make-withdraw procedure, the local variable balance is
> created as a parameter of make-withdraw. We could also create the local state
> variable explicitly, using let, as follows:
>
> ```scheme
> (define (make-withdraw initial-amount)
>   (let ((balance initial-amount))
>     (lambda (amount)
>       (if (>= balance amount)
>           (begin (set! balance (- balance amount))
>                  balance)
>           "Insufficient funds"))))
> ```
>
> Recall from section 1.3.2 that let is simply syntactic sugar for a procedure
> call:
>
> ```scheme
> (let ((<var> <exp>)) <body>)
> ```
>
> is interpreted as an alternate syntax for
>
> ```scheme
> ((lambda (<var>) <body>) <exp>)
> ```
>
> Use the environment model to analyze this alternate version of make-withdraw,
> drawing figures like the ones above to illustrate the interactions
>
> ```scheme
> (define W1 (make-withdraw 100))
>
> (W1 50)
>
> (define W2 (make-withdraw 100))
> ```
>
> Show that the two versions of make-withdraw create objects with the same
> behavior. How do the environment structures differ for the two versions?


The environment after defining `make-withdraw`:

```
          ---------------------------
          |                         |
global -->| make-withdraw: --.      |
env       |                  |      |
          -------------------|-------
                             |   ^
                             |   |
                            @=@--'
                            |
                            v
                    parameters: initial-amount
                    body: (let ((...)) ...)
```

The environment after evaluating `(define W1 (make-withdraw 100))`,
here E1 is a frame created by applying `make-withdraw` and
E2 is a frame created by `let` in the body of `make-withdraw`:

```
          ----------------------------------------------------------
          | make-withdraw:----------------------------------.      |
global -->|                                                 |      |
env       | W1:--.                                          |      |
          -------|------------------------------------------|-------
                 |         ^                                |   ^
                 |         |                                |   |
                 |       -----------------------           @=@--'
                 |  E1-->| initial-amount: 100 |           |
                 |       -----------------------           v
                 |         ^                        parameters: initial-amount
                 |         |                        body: (let ((...)) ...)
                 |       -----------------------
                 |  E2-->| balance: 100        |
                 |       -----------------------
                 |         ^
                 |         |
                @=@--------'
                |
                v
           parameters: amount
           body: (if (>= ...) ...)
```

The environment while evaluating `(W1 50)`,
here E3 is the frame created by applying `W1`.

```
          ----------------------------------------------------------
          | make-withdraw: ...                                     |
global -->|                                                        |
env       | W1:--.                                                 |
          -------|--------------------------------------------------
                 |         ^
                 |         |
                 |       -----------------------
                 |  E1-->| initial-amount: 100 |
                 |       -----------------------
                 |         ^
                 |         |
                 |       -----------------------
                 |  E2-->| balance: 100        |
                 |       -----------------------
                 |         ^  ^
                 |         |  |
                @=@--------'  `--------------.
                |                            |
                v                            |
           parameters: amount              --------------
           body: (if (>= ...) ...)    E3-->| amount: 50 |
                                           --------------
```

The environment after evaluating `(W1 50)`:

```
          ----------------------------------------------------------
          | make-withdraw: ...                                     |
global -->|                                                        |
env       | W1:--.                                                 |
          -------|--------------------------------------------------
                 |         ^
                 |         |
                 |       -----------------------
                 |  E1-->| initial-amount: 100 |
                 |       -----------------------
                 |         ^
                 |         |
                 |       -----------------------
                 |  E2-->| balance: 50         |
                 |       -----------------------
                 |         ^
                 |         |
                @=@--------'
                |
                v
           parameters: amount
           body: (if (>= ...) ...)
```

The environment after evaluating `(define W2 (make-withdraw 100))`,
here E4 is a frame created by applying `make-withdraw` and
E5 is a frame created by `let` in the body of `make-withdraw`:

```
          ------------------------------------------------------
          | make-withdraw: ...                                 |
global -->|                                                    |
env       | W1:--.                                             |
          |      |                                             |
          | W2:--+---------------------------------.           |
          -------|---------------------------------|------------
                 |         ^                       |         ^
                 |         |                       |         |
                 |       -----------------------   |       -----------------------
                 |  E1-->| initial-amount: 100 |   |  E3-->| initial-amount: 100 |
                 |       -----------------------   |       -----------------------
                 |         ^                       |         ^
                 |         |                       |         |
                 |       -----------------------   |       -----------------------
                 |  E2-->| balance: 50         |   |  E4-->| balance: 100        |
                 |       -----------------------   |       -----------------------
                 |         ^                       |         ^
                 |         |                       |         |
                @=@--------'                      @=@--------'
                |                                 |
                |,--------------------------------'
                |
                v
           parameters: amount
           body: (if (>= ...) ...)
```

Therefore, both versions of `make-withdraw` creates objects with the same behavior,
but the environment structures created by the explicit `let` version have extra frames.
