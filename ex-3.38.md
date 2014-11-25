> Exercise 3.38.  Suppose that Peter, Paul, and Mary share a joint bank account
> that initially contains $100. Concurrently, Peter deposits $10, Paul
> withdraws $20, and Mary withdraws half the money in the account, by executing
> the following commands:
>
> * Peter: `(set! balance (+ balance 10))`
> * Paul: `(set! balance (- balance 20))`
> * Mary: `(set! balance (- balance (/ balance 2)))`

> a. List all the different possible values for balance after these three
> transactions have been completed, assuming that the banking system forces the
> three processes to run sequentially in some order.

Possible orders to run the three processes are:

* Peter ($110) -> Paul ($90) -> Mary ($45)
* Peter ($110) -> Mary ($55) -> Paul ($35)
* Paul ($80) -> Peter ($90) -> Mary ($45)
* Paul ($80) -> Mary ($40) -> Peter ($50)
* Mary ($50) -> Peter ($60) -> Paul ($40)
* Mary ($50) -> Paul ($30) -> Peter ($40)

So that possible values are $35, $40, $45 and $50.


> b. What are some other values that could be produced if the system allows the
> processes to be interleaved? Draw timing diagrams like the one in figure 3.29
> to explain how these values can occur.

A possible value can be produced as follows:

```
 |    Bank       Peter                   Paul                     Mary
 |
 |   ($100)
 |     |||
 |     ||`---------------------------------------------------------.
 |     |`----------------------------------.                       |
 |     `-----------.                       |                       |
 |                 |                       |                       |
 |                 v                       |                       |
 |       [Access balance: $100]            v                       |
 |                 |             [Access balance: $100]            v
 |                 v                       |             [Access balance: $100]
 |       [new value: 100-10=90]            v                       |
 |                 |             [new value: 100-20=80]            v
 |                 v                       |             [new value: 100/2=50]
 |       [set! balance to $90]             v                       |
 |                 |             [set! balance to $80]             v
 |    ($90)<-------'                       |             [set! balance to $50]
 |                                         |                       |
 |    ($50)<-------------------------------+-----------------------'
 |                                         |
 |    ($80)<-------------------------------'
 v
time
```
