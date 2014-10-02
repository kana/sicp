(use srfi-27)

(random-source-randomize! default-random-source)

(define (random range)
  (* (random-real) range))
