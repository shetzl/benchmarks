; Property from "Case-Analysis for Rippling and Inductive Proof",
; Moa Johansson, Lucas Dixon and Alan Bundy, ITP 2010
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (proj1-S Nat)))))
(define-fun-rec
  (par (a)
    (take
       ((x Nat) (y (list a))) (list a)
       (match x
         (case Z (_ nil a))
         (case (S z)
           (match y
             (case nil (_ nil a))
             (case (cons x2 x3) (cons x2 (take z x3)))))))))
(prove
  (par (a) (forall ((xs (list a))) (= (take Z xs) (_ nil a)))))
