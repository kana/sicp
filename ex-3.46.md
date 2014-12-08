> Exercise 3.46.  Suppose that we implement `test-and-set!` using an ordinary
> procedure as shown in the text, without attempting to make the operation
> atomic. Draw a timing diagram like the one in figure 3.29 to demonstrate how
> the mutex implementation can fail by allowing two processes to acquire the
> mutex at the same time.

```
 |   Process 1        cell       Process 2
 |                    (#f)
 |        _____________||_____________
 |        |                          |
 |  [acccess cell]                   |
 |        |                    [acccess cell]
 |        |                          |
 |        |                    [modify cell]
 |  [modify cell]       _____________|
 |        |             |
 |        |             v      [return false]
 |        |           (#t)
 |        |_____________
 |                     |
 |  [return false]     v
 |                    (#t)
 v
time
```
