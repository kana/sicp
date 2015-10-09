> Exercise 4.65.  Cy D. Fect, looking forward to the day when he will rise in
> the organization, gives a query to find all the wheels (using the wheel rule
> of section 4.4.1):
>
> ```scheme
> (wheel ?who)
> ```
>
> To his surprise, the system responds
>
> ```scheme
> ;;; Query results:
> (wheel (Warbucks Oliver))
> (wheel (Bitdiddle Ben))
> (wheel (Warbucks Oliver))
> (wheel (Warbucks Oliver))
> (wheel (Warbucks Oliver))
> ```
>
> Why is Oliver Warbucks listed four times?

Because the system responds the wheel for each employees.

                 Warbucks Oliver
                        |
         _______________|______________
         |              |             |
    Aull DeWitt   Bitdiddle Ben  Scrooge Eben
                        |             |_____________________
         _______________|__________________                |
         |              |                 |                |
   Fect Cy D    Hacker Alyssa P    Tweakit Lem E    Cratchet Robert
                        |
                        |
                        |
                 Reasoner Louis

From the above employee tree,

* Aull DeWitt doesn't have a wheel.
* Bitdiddle Ben doesn't have a wheel.
* Scrooge Eben doesn't have a wheel.
* Fect Cy D has a wheel who is Warbucks Oliver.
* Hacker Alyssa P has a wheel who is Warbucks Oliver.
* Tweakit Lem E has a wheel who is Warbucks Oliver.
* Cratchet Robert has a wheel who is Warbucks Oliver.
* Reasoner Louis has a wheel who is Ben Bitdiddle.
