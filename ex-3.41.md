> Exercise 3.41.  Ben Bitdiddle worries that it would be better to implement
> the bank account as follows (where the commented line has been changed):
>
> ```scheme
> (define (make-account balance)
>   (define (withdraw amount)
>     (if (>= balance amount)
>         (begin (set! balance (- balance amount))
>                balance)
>         "Insufficient funds"))
>   (define (deposit amount)
>     (set! balance (+ balance amount))
>     balance)
>   ;; continued on next page
>
>   (let ((protected (make-serializer)))
>     (define (dispatch m)
>       (cond ((eq? m 'withdraw) (protected withdraw))
>             ((eq? m 'deposit) (protected deposit))
>             ((eq? m 'balance)
>              ((protected (lambda () balance)))) ; serialized
>             (else (error "Unknown request -- MAKE-ACCOUNT"
>                          m))))
>     dispatch))
> ```
>
> because allowing unserialized access to the bank balance can result in
> anomalous behavior. Do you agree? Is there any scenario that demonstrates
> Ben's concern?

Execution of `protected` procedures will never be interleaved.  If an execution
of a procedure consists of a single step and cannot be interleaved, that
procedure is not worth to be `protected`.

So that Ben's change might be meaningless depending on how Scheme
interpreters are implemented.

If fetching the current value of a variable consists only one step,
Ben's change does nothing.

If it consists two or more steps, fetching `balance` might be interleaved.
Suppose that fetching `balance` requires two steps to complete;
(1) reading the first half part of a number; and
(2) reading the last half part of the same number.

Consider the following interaction:

```scheme
(define a (make-account 1000))
(parallel-execute (lambda () ((a 'deposit) 234)  ; P1
                  (lambda () (a 'balance)))      ; P2
```

This code might be executed as follows:

1. P2 reads the first half part of `balance`.
   Suppose that a number consists at most 4 digits.
   P2 has read only 10 at this step.
2. P1 deposits 234 to the account.  Now `balance` is 1234.
3. P2 reads the last half part of `balance`, that is 34.
   Then P2 combine read results and returns 1034 to its caller.

So that Ben's change does matter in this case.
