; Property from "Case-Analysis for Rippling and Inductive Proof",
; Moa Johansson, Lucas Dixon and Alan Bundy, ITP 2010
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (proj1-S Nat)))))
(define-fun-rec
  (par (a b)
    (map
       ((x (=> a b)) (y (list a))) (list b)
       (match y
         (case nil (_ nil b))
         (case (cons z xs) (cons (@ x z) (map x xs)))))))
(define-fun-rec
  (par (a)
    (drop
       ((x Nat) (y (list a))) (list a)
       (match x
         (case Z y)
         (case (S z)
           (match y
             (case nil (_ nil a))
             (case (cons x2 x3) (drop z x3))))))))
(prove
  (par (a b)
    (forall ((n Nat) (f (=> a b)) (xs (list a)))
      (= (drop n (map f xs)) (map f (drop n xs))))))
