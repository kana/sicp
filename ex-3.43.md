> Exercise 3.43.  Suppose that the balances in three accounts start out as $10,
> $20, and $30, and that multiple processes run, exchanging the balances in the
> accounts.

> Argue that if the processes are run sequentially, after any number of
> concurrent exchanges, the account balances should be $10, $20, and $30 in
> some order.  Draw a timing diagram like the one in figure 3.29 to show how
> this condition can be violated if the exchanges are implemented using the
> first version of the account-exchange program in this section.

Let's consider the following interaction:

```scheme
(define a (make-account 10))
(define b (make-account 20))
(define c (make-account 30))
(parallel-execute (lambda () (exchange a b))   ; P1
                  (lambda () (exchange b c)))  ; P2
```

One possible scenario that resulting balances become incorrect is as follows:

```
 |        P1                 a      b      c              P2
 |        :                ($10)  ($20)  ($30)            :
 |        :  ________________|     | |     |              :
 |        :  |                     | |     |              :
 |  [Get a's balance]              | |     |              :
 |        :  |  ___________________| |     |              :
 |        v  |  |                    |     |              :
 |  [Get b's balance]                |     |              :
 |        :  |  |                    |_____|_________     :
 |        v  |  |                          |        |     v
 |  [Calculate diff (=-10)]                |     [Get b's balance]
 |        :  |  |                          |________|___  :
 |        v  |  |                                   |  |  v
 |  [Withdraw diff from a]                       [Get c's balance]
 |        :  |__|_____________                      |  |  :
 |        :     |            |                      |  |  v
 |        v     |          ($20)                 [Calculate diff (=-10)]
 |  [Deposit diff to b]                             |  |  :
 |              |____________________               |  |  v
 |                                  |            [Withdraw diff from b]
 |                                ($10)             |  |  :
 |                                  ________________|  |  :
 |                                  |                  |  v
 |                                ($20)           [Deposit diff to c]
 |                                         ____________|
 |                                         |
 |                                       ($20)
 v
time
```




> On the other hand, argue that even with this `exchange` program, the sum of
> the balances in the accounts will be preserved. Draw a timing diagram to show
> how even this condition would be violated if we did not serialize the
> transactions on individual accounts.

```
 |        P1                 a      b      c              P2
 |        :                ($10)  ($20)  ($30)            :
 |        :  ________________|     | |     |              :
 |        :  |                     | |     |              :
 |  [Get a's balance]              | |     |              :
 |        :  |  ___________________| |     |              :
 |        v  |  |                    |     |              :
 |  [Get b's balance]                |     |              :
 |        :  |  |                    |_____|_________     :
 |        v  |  |                          |        |     v
 |  [Calculate diff (=-10)]                |     [Get b's balance]
 |        :  |  |                          |________|___  :
 |        v  |  |                                   |  |  v
 |  [Withdraw diff from a]                       [Get c's balance]
 |        :  |__|_____________                      |  |  :
 |        :     |            |                      |  |  v
 |        :     |          ($20)                 [Calculate diff (=-10)]
 |        v     |                                   |  |  :
 |  [Deposit diff to b]                          [Withdraw diff from b]
 |  :           |     :                          :  |  |              :
 |  : [Get balance]   :                          : [Get balance]      :
 |  :           |     :                          :  |  |              :
 |  : [New value: 10] :                          : [New value: 30]    :
 |  :           |     :                          :  |  |              :
 |  : [Set balance]   :                          :  |  |              :
 |  :           |_____:_____________             :  |  |              :
 |  :.................:            |             : [Set balance]      :
 |                                ($10)          :  |  |              :
 |                                   ____________:__|  |              :
 |                                   |           :.....|..............:
 |                                ($30)                |  :
 |                                                     |  :
 |                                                     |  v
 |                                                [Deposit diff to c]
 |                                         ____________|
 |                                         |
 |                                       ($20)
 v
time
```
