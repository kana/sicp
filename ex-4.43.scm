;;; Exercise 4.43.  Use the amb evaluator to solve the following puzzle: [49]
;;;
;;;     Mary Ann Moore's father has a yacht and so has each of his four
;;;     friends: Colonel Downing, Mr. Hall, Sir Barnacle Hood, and Dr. Parker.
;;;     Each of the five also has one daughter and each has named his yacht
;;;     after a daughter of one of the others. Sir Barnacle's yacht is the
;;;     Gabrielle, Mr. Moore owns the Lorna; Mr. Hall the Rosalind. The
;;;     Melissa, owned by Colonel Downing, is named after Sir Barnacle's
;;;     daughter. Gabrielle's father owns the yacht that is named after Dr.
;;;     Parker's daughter. Who is Lorna's father?
;;;
;;; Try to write the program so that it runs efficiently (see exercise 4.40).
;;; Also determine how many solutions there are if we are not told that Mary
;;; Ann's last name is Moore.

(load "./sec-4.3.3.scm")

(ambtest '(begin

            (define (distinct? items)
              (cond ((null? items) true)
                    ((null? (cdr items)) true)
                    ((member (car items) (cdr items)) false)
                    (else (distinct? (cdr items)))))

            (define (solve-plain)
              (let ((moore-daughter    (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (moore-yacht       (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (colonel-daughter  (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (colonel-yacht     (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (hall-daughter     (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (hall-yacht        (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (barnacle-daughter (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (barnacle-yacht    (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (parker-daughter   (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa))
                    (parker-yacht      (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                (require (not (eq? moore-daughter moore-yacht)))
                (require (not (eq? colonel-daughter colonel-yacht)))
                (require (not (eq? hall-daughter hall-yacht)))
                (require (not (eq? barnacle-daughter barnacle-yacht)))
                (require (not (eq? parker-daughter parker-yacht)))
                (require (eq? moore-daughter 'mary))
                (require (eq? barnacle-yacht 'gabrielle))
                (require (eq? moore-yacht 'lorna))
                (require (eq? hall-yacht 'rosalind))
                (require (eq? colonel-yacht 'melissa))
                (require (eq? barnacle-daughter 'melissa))
                (let* ((dys (list
                              (cons moore-daughter moore-yacht)
                              (cons colonel-daughter colonel-yacht)
                              (cons hall-daughter hall-yacht)
                              (cons barnacle-daughter barnacle-yacht)
                              (cons parker-daughter parker-yacht)
                              ))
                       (dy (assq 'gabrielle dys)))
                  (require (and dy (eq? (cdr dy) parker-daughter)))  ; Gabrielle's father owns the yacht...
                  )
                (require (distinct? (list moore-daughter colonel-daughter hall-daughter barnacle-daughter parker-daughter)))
                (require (distinct? (list moore-yacht colonel-yacht hall-yacht barnacle-yacht parker-yacht)))
                (list 'moore moore-daughter moore-yacht
                      'colonel colonel-daughter colonel-yacht
                      'hall hall-daughter hall-yacht
                      'barnacle barnacle-daughter barnacle-yacht
                      'parker parker-daughter parker-yacht)
                )
              )

            (define (solve-fast mary-ann-moore)
              (let ((moore-daughter                      (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                (if mary-ann-moore
                  (require (eq? moore-daughter 'mary)))
                (let ((moore-yacht                       (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                  (require (eq? moore-yacht 'lorna))
                  (require (not (eq? moore-daughter moore-yacht)))
                  (let ((colonel-yacht                   (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                    (require (eq? colonel-yacht 'melissa))
                    (let ((colonel-daughter              (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                      (require (not (eq? colonel-daughter colonel-yacht)))
                      (let ((hall-yacht                  (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                        (require (eq? hall-yacht 'rosalind))
                        (let ((hall-daughter             (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                          (require (not (eq? hall-daughter hall-yacht)))
                          (let ((barnacle-daughter       (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                            (require (eq? barnacle-daughter 'melissa))
                            (let ((barnacle-yacht        (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                              (require (eq? barnacle-yacht 'gabrielle))
                              (require (not (eq? barnacle-daughter barnacle-yacht)))
                              (let ((parker-daughter     (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                                (let ((parker-yacht      (amb 'mary 'gabrielle 'lorna 'rosalind 'melissa)))
                                  (require (not (eq? parker-daughter parker-yacht)))
                                  (let* ((dys (list
                                                (cons moore-daughter moore-yacht)
                                                (cons colonel-daughter colonel-yacht)
                                                (cons hall-daughter hall-yacht)
                                                (cons barnacle-daughter barnacle-yacht)
                                                (cons parker-daughter parker-yacht)
                                                ))
                                         (dy (assq 'gabrielle dys)))
                                    (require (and dy (eq? (cdr dy) parker-daughter)))  ; Gabrielle's father owns the yacht...
                                    )
                                  (require (distinct? (list moore-daughter colonel-daughter hall-daughter barnacle-daughter parker-daughter)))
                                  (require (distinct? (list moore-yacht colonel-yacht hall-yacht barnacle-yacht parker-yacht)))
                                  (list 'moore moore-daughter moore-yacht
                                        'colonel colonel-daughter colonel-yacht
                                        'hall hall-daughter hall-yacht
                                        'barnacle barnacle-daughter barnacle-yacht
                                        'parker parker-daughter parker-yacht)
                                  ))))))))))
              )
            ))

(ambtest '(begin

            (print "================")
            (print "Normal solution:")
            (let ((answer (solve-fast true)))
              (print answer))

            ))

(ambtest '(begin

            (print "================")
            (print "If Marry Ann might not be More:")
            (let ((answer (solve-fast false)))
              (print answer))

            ))
