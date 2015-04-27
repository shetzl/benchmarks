; Property about accumulative addition function.
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-funs-rec
  ((plus ((x Nat) (y Nat)) Nat))
  ((match x
     (case Z y)
     (case (S n) (S (plus n y))))))
(define-funs-rec
  ((acc_plus ((x Nat) (y Nat)) Nat))
  ((match x
     (case Z y)
     (case (S z) (acc_plus z (S y))))))
(assert-not
  (forall ((x Nat))
    (forall ((y Nat)) (= (plus x y) (acc_plus x y)))))
(check-sat)
