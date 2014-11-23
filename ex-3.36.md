> Exercise 3.36.  Suppose we evaluate the following sequence of expressions in
> the global environment:
>
> ```scheme
> (define a (make-connector))
> (define b (make-connector))
> (set-value! a 10 'user)
> ```
>
> At some time during evaluation of the `set-value!`, the following expression
> from the connector's local procedure is evaluated:
>
> ```scheme
> (for-each-except setter inform-about-value constraints)
> ```
>
> Draw an environment diagram showing the environment in which the above
> expression is evaluated.

```
         ----------------------------------------------------------------------
         |                                                                    |
         | b: ... (similar to a)                                              |
global-->|                                                                    |
env      | a:--.                                                              |
         |     |                                                              |
         ------|---------------------------------------------------------------
  _____________| ^         ^                      ^
  |              |         | E1 (set-value! ...)  | E4 (for-each-except ...)
  |  -------------------  -------------------  -------------------------------------
  |  | value: 10       |  | connector: [a]  |  | exception:   user                 |
  |  | informant: user |  | new-value: 10   |  | procedure:   [inform-about-value] |
  |  | constraints: () |  | informant: user |  | constraints: ()                   |
  |  -------------------  -------------------  | loop: ...                         |
  |              ^                             -------------------------------------
  |              |                                ^
  |  ------------------------                     | E5 (loop list)
  |  | set-my-value: ...    |                  -------------
  |  | forget-my-value: ... |                  | items: () |
  |  | connect: ...         |                  -------------
  |  | me:----.             |
  |  ---------|--------------
  |           |  ^  ^   ^
  `-----. ,---'  |  |   | E2 (connector ...)
         |       |  |  -----------------------
         v       |  |  | request: set-value! |
         @=@-----'  |  -----------------------
         |          `---.
         v              |
parameters: request     | E3 (set-my-value ...)
body: (cond ...)       -----------------------
                       | newval: 10          |
                       | setter: user        |
                       -----------------------
```
