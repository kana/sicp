> Exercise 3.45.  Louis Reasoner thinks our bank-account system is
> unnecessarily complex and error-prone now that deposits and withdrawals
> aren't automatically serialized. He suggests that
> `make-account-and-serializer` should have exported the serializer (for use by
> such procedures as `serialized-exchange`) in addition to (rather than instead
> of) using it to serialize accounts and deposits as `make-account` did. He
> proposes to redefine accounts as follows:
>
> ```scheme
> (define (make-account-and-serializer balance)
>   (define (withdraw amount)
>     (if (>= balance amount)
>         (begin (set! balance (- balance amount))
>                balance)
>         "Insufficient funds"))
>   (define (deposit amount)
>     (set! balance (+ balance amount))
>     balance)
>   (let ((balance-serializer (make-serializer)))
>     (define (dispatch m)
>       (cond ((eq? m 'withdraw) (balance-serializer withdraw))
>             ((eq? m 'deposit) (balance-serializer deposit))
>             ((eq? m 'balance) balance)
>             ((eq? m 'serializer) balance-serializer)
>             (else (error "Unknown request -- MAKE-ACCOUNT"
>                          m))))
>     dispatch))
> ```
>
> Then deposits are handled as with the original make-account:
>
> ```scheme
> (define (deposit account amount)
>  ((account 'deposit) amount))
> ```
>
> Explain what is wrong with Louis's reasoning. In particular, consider what
> happens when `serialized-exchange` is called.

With Louis's change, we can't make complex operations such as
`serialized-exchange` which requires to get and set account balances.

For example, `serialized-exchange` consists of two steps; (1) calculate the
difference of two account balances; then (2) transfer the difference between
the two accounts.  These two steps must not be interleaved, so that
`serialized-exchange` must acquire the rights for exclusive access to the two
accounts before executing the two steps.

If each account's `withdraw` and `deposit` are automatically serialized,
`serialized-exchange` can't modify each account's balance.  Though `withdraw`
and `deposit` requires the rights for exclusive access, the rights are already
acquired by `serialized-exchange`.  `withdraw` and `deposit` in
`serialized-exchange` wait until the execution of the current
`serialized-exchange` is finished.  In other words, they waits forever.
