> Exercise 3.20.  Draw environment diagrams to illustrate the evaluation of the
> sequence of expressions
>
> ```scheme
> (define x (cons 1 2))
> (define z (cons x x))
> (set-car! (cdr z) 17)
> (car x)
> 17
> ```
>
> using the procedural implementation of pairs given above.
> (Compare exercise 3.11.)

> ```scheme
> (define (cons x y)
>   (define (set-x! v) (set! x v))
>   (define (set-y! v) (set! y v))
>   (define (dispatch m)
>     (cond ((eq? m 'car) x)
>           ((eq? m 'cdr) y)
>           ((eq? m 'set-car!) set-x!)
>           ((eq? m 'set-cdr!) set-y!)
>           (else (error "Undefined operation -- CONS" m))))
>   dispatch)
> (define (car z) (z 'car))
> (define (cdr z) (z 'cdr))
> (define (set-car! z new-value)
>   ((z 'set-car!) new-value)
>   z)
> (define (set-cdr! z new-value)
>   ((z 'set-cdr!) new-value)
>   z)
> ```

The following diagram illustrates the environment just before modifying existing data by `set-car!`:

```
         ----------------------------
         |                          |
         | cons, car, ...: ...      |
global-->| x:--------------------------*--------------------------------.
env      | z:--------------------.  |  |                                |
 ,------>|                       |  |<-+-----------.                    |
 |       ------------------------|---  |           |                    |
 |          ^                    |     |           |   _________________|___ This x would be modified
 |          |                    |     |           |  /                 |    by the set-car!.
 |       ---------------         |     |        -----/---------         |
 |       |             |         |     |        |   /         |         |
 |       | x: -------------------+-----*        | x: 1        |         |
 |       | y: -------------------+-----'        | y: 2        |         |
 |       | set-x!: ... |<----.   |              | set-x!: ... |<----.   |
 |  E2-->| set-y!: ... |     |   |         E1-->| set-y!: ... |     |   |
 |       | dispatch:------>@=@<--'              | dispatch:------>@=@<--*--------.
 |       |             |   |                    |             |   |              |
 |       ---------------   v                    ---------------   v              |
 |                     parameters: m               ^          parameters: m      |
 |                     body: (cond ...)            |          body: (cond ...)   |
 |                                                 |                             |
 `-----------------------------.                   |                             |
                               |                   |                             |
                            -----------------      |                             |
                            |               |      |                             |
                       E3-->| z:-------------------|-----------------------------'
       (set-car! (cdr z) 17)| new-value: 17 |      |
                            |               |      |
                            -----------------      |
                                                -----------------
                                           E4-->| v: 17         |
                    ((z 'set-car!) new-value)   -----------------
```
