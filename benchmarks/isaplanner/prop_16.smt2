; Property from "Case-Analysis for Rippling and Inductive Proof",
; Moa Johansson, Lucas Dixon and Alan Bundy, ITP 2010
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (proj1-S Nat)))))
(define-fun-rec
  last
    ((x (list Nat))) Nat
    (match x
      (case nil Z)
      (case (cons y z)
        (match z
          (case nil y)
          (case (cons x2 x3) (last z))))))
(prove
  (forall ((x Nat) (xs (list Nat)))
    (=> (= xs (_ nil Nat)) (= (last (cons x xs)) x))))
