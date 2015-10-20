(define the-table (make-hash-table 'equal?))

(define (put op type item)
  (hash-table-put! the-table (cons op type) item))

(define (get op type)
  (hash-table-get the-table (cons op type) #f))
