> Exercise 3.21.  Ben Bitdiddle decides to test the queue implementation
> described above. He types in the procedures to the Lisp interpreter and
> proceeds to try them out:
>
> ```scheme
> (define q1 (make-queue))
> (insert-queue! q1 'a)
> ((a) a)
> (insert-queue! q1 'b)
> ((a b) b)
> (delete-queue! q1)
> ((b) b)
> (delete-queue! q1)
> (() b)
> ```
>
> “It's all wrong!” he complains. “The interpreter's response shows that the
> last item is inserted into the queue twice. And when I delete both items, the
> second b is still there, so the queue isn't empty, even though it's supposed
> to be.” Eva Lu Ator suggests that Ben has misunderstood what is
> happening.“It's not that the items are going into the queue twice,”she
> explains.“It's just that the standard Lisp printer doesn't know how to make
> sense of the queue representation. If you want to see the queue printed
> correctly, you'll have to define your own print procedure for queues.”


> Explain what Eva Lu is talking about. In particular, show why Ben's examples
> produce the printed results that they do.

Lisp interpreters know how to print basic data such as numbers, symbols, paris
and lists.  Our queues are compound data objects built upon basic data.  Lisp
interpreters don't know what compound data represent.  So that Lisp
interpreters print our queues as pairs of lists.

And there is no external representation to distinct shared data.  For example:

```scheme
(define x (list 'a 'b 'c))
(define y (list 'a 'b 'c))
(define z x)
```

There are two lists.  One is referred by `y`, and the other is referred by `x`
and `z`.  But external representations of these lists are the same.  Lisp
interpreters pinrt the same `(a b c)` for all variables.  We can't distinct
whether two variables refer the same data from their external representations.

Finally, the implementation of `empty-queue?` looks only the front pointer, and
`delete-queue!` changes only the front pointer.  If we delete all items from
a non-empty queue, the last pair will be remained and pointed by the rear
pointer.  So that the final state of `q1` can be drawn as:

    q1-->[o][o]
          |  |
      ,---'  `--.
      |         |
      v         v
      ()       [o][o]
                |  |
                v  v
                b  ()

But there is no problem.  Emptiness of our queues is determined only by front
pointers.

That's why Ben saw the responses.


> Define a procedure `print-queue` that takes a queue as input and prints the
> sequence of items in the queue.

```scheme
(define (print-queue queue)
  (display (front-ptr queue)))
```
