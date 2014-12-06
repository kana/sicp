> Exercise 3.44.  Consider the problem of transferring an amount from one
> account to another. Ben Bitdiddle claims that this can be accomplished with
> the following procedure, even if there are multiple people concurrently
> transferring money among multiple accounts, using any account mechanism that
> serializes deposit and withdrawal transactions, for example, the version of
> make-account in the text above.
>
> ```scheme
> (define (transfer from-account to-account amount)
>   ((from-account 'withdraw) amount)
>   ((to-account 'deposit) amount))
> ```
>
> Louis Reasoner claims that there is a problem here, and that we need to use
> a more sophisticated method, such as the one required for dealing with the
> exchange problem. Is Louis right? If not, what is the essential difference
> between the transfer problem and the exchange problem? (You should assume
> that the balance in `from-account` is at least amount.)

Louis is wrong.  The essential difference between the two problems is whether
each account's balance is accessed more than once.  The transfer problem
accesses each account's balance only once, while the exchange problem accesses
each account's balance two times --- the first time is to calculate the
difference of the two balances, and the second time is to transfer the
difference.  So that the whole steps of an exchange must be serialized.
