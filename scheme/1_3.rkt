#lang racket
(define (square x) (* x x))

(define (sum-of-square x y)(+ (square x) (square y)))
(define (bigger-square x y z)
  (cond
    ((and (< x y) (< x z)) (sum-of-square y z))
    ((and (< y x) (< y z)) (sum-of-square x z))
  (else (sum-of-square x y)))
)

(bigger-square 3 1 1)

