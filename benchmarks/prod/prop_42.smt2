; Property from "Productive Use of Failure in Inductive Proof",
; Andrew Ireland and Alan Bundy, JAR 1996
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (proj1-S Nat)))))
(define-fun |\|\|| ((x Bool) (y Bool)) Bool (ite x true y))
(define-fun-rec
  ==
    ((x Nat) (y Nat)) Bool
    (match x
      (case Z
        (match y
          (case Z true)
          (case (S z) false)))
      (case (S x2)
        (match y
          (case Z false)
          (case (S y2) (== x2 y2))))))
(define-fun-rec
  elem
    ((x Nat) (y (list Nat))) Bool
    (match y
      (case nil false)
      (case (cons z xs) (|\|\|| (== x z) (elem x xs)))))
(define-fun-rec
  union
    ((x (list Nat)) (y (list Nat))) (list Nat)
    (match x
      (case nil y)
      (case (cons z xs)
        (ite (elem z y) (union xs y) (cons z (union xs y))))))
(prove
  (forall ((x Nat) (y (list Nat)) (z (list Nat)))
    (=> (elem x y) (elem x (union y z)))))
