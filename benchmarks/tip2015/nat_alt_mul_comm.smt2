; Property about an alternative multiplication function which exhibits an
; interesting recursion structure.
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-funs-rec
  ((plus ((x Nat) (y Nat)) Nat))
  ((match x
     (case Z y)
     (case (S n) (S (plus n y))))))
(define-funs-rec
  ((alt_mul ((x Nat) (y Nat)) Nat))
  ((match x
     (case Z x)
     (case (S z)
       (match y
         (case Z y)
         (case (S x2) (S (plus (plus (alt_mul z x2) z) x2))))))))
(assert-not
  (forall ((x Nat) (y Nat)) (= (alt_mul x y) (alt_mul y x))))
(check-sat)
