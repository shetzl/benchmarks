; Property about an alternative multiplication function which exhibits an
; interesting recursion structure.
(declare-datatypes () ((Nat (zero) (succ (p Nat)))))
(define-fun-rec
  plus
    ((x Nat) (y Nat)) Nat
    (match x
      (case zero y)
      (case (succ z) (succ (plus z y)))))
(define-fun-rec
  alt_mul
    ((x Nat) (y Nat)) Nat
    (match x
      (case zero zero)
      (case (succ z)
        (match y
          (case zero zero)
          (case (succ x2)
            (plus (plus (plus (succ zero) (alt_mul z x2)) z) x2))))))
(prove (forall ((x Nat) (y Nat)) (= (alt_mul x y) (alt_mul y x))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (plus x (plus y z)) (plus (plus x y) z))))
(assert (forall ((x Nat) (y Nat)) (= (plus x y) (plus y x))))
(assert (forall ((x Nat)) (= (plus x zero) x)))
(assert (forall ((x Nat)) (= (plus zero x) x)))
