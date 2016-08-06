;;; Normal order => 18 times

(if (= b 0)
  a
  (gcd b (remainder a b)))

(gcd 206 40)

(if (= b 0)
  a
  (gcd b (remainder a b)))

(if (= 40 0)
  206
  (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))

(if (= b 0)
  a
  (gcd b (remainder a b)))

; 1
; rem=6
(if (= (remainder 206 40) 0)
  40
  (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))

(if (= b 0)
  a
  (gcd b (remainder a b)))

; 3
; rem=4
(if (= (remainder 40 (remainder 206 40)) 0)
  (remainder 206 40)
  (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

(if (= b 0)
  a
  (gcd b (remainder a b)))

; 7
; rem=2
(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
  (remainder 40 (remainder 206 40))
  (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))

(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

(if (= b 0)
  a
  (gcd b (remainder a b)))

; 14
; rem=0
(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
  (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

; 18
; rem=2
(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))


;;; Applicative order => 4 times

(gcd 206 40)

(if (= b 0)
  a
  (gcd b (remainder a b)))

(if (= 40 0)
  206
  (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))

; 1
(gcd 40 6)

(if (= b 0)
  a
  (gcd b (remainder a b)))

(if (= 6 0)
  40
  (gcd 6 (remainder 40 6)))

; 2
(gcd 6 (remainder 40 6))

(gcd 6 4)

(if (= b 0)
  a
  (gcd b (remainder a b)))

(if (= 4 0)
  6
  (gcd 4 (remainder 6 4)))

; 3
(gcd 4 (remainder 6 4))

(gcd 4 2)

(if (= b 0)
  a
  (gcd b (remainder a b)))

(if (= 2 0)
  4
  (gcd 2 (remainder 4 2)))

; 4
(gcd 2 (remainder 4 2))

(gcd 2 0)

(if (= b 0)
  a
  (gcd b (remainder a b)))

(if (= 0 0)
  2
  (gcd 0 (remainder 2 0)))

2
