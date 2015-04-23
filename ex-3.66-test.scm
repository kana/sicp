(load "./sec-3.5.scm")

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (f i j)
  (cond ((= i j)
         (- (expt 2 i) 1))
        ((= (+ i 1) j)
         (+ (f i i) (expt 2 (- i 1))))
        ((<= (+ i 2) j)
         (+ (f i (+ i 1)) (* (- j (+ i 1)) (expt 2 i))))
        (else
          (error "Invalid combination:" i j))))

(define (main args)
  (print (f 6 6))
  (print (f 6 10))
  (print (stream-ref (pairs integers integers) (- (f 6 6) 1)))
  (print (stream-ref (pairs integers integers) (- (f 6 10) 1)))
  (print (f 1 100))
  (print (f 99 100))
  (print (f 100 100))
  )
