; Weird functions over natural numbers
;
; Property about a 4-adic operation over natural numbers
; op a b c d = a * b + c + d
(declare-datatypes () ((Nat (zero) (succ (p Nat)))))
(define-fun-rec
  plus
    ((x Nat) (y Nat)) Nat
    (match x
      (case zero y)
      (case (succ z) (succ (plus z y)))))
(define-fun-rec
  times
    ((x Nat) (y Nat)) Nat
    (match x
      (case zero zero)
      (case (succ z) (plus y (times z y)))))
(define-fun-rec
  op
    ((x Nat) (y Nat) (z Nat) (x2 Nat)) Nat
    (let
      ((fail
          (match z
            (case zero (match x (case (succ x4) (op x4 y y x2))))
            (case (succ x3) (op x y x3 (succ x2))))))
      (match x
        (case zero
          (match z
            (case zero x2)
            (case (succ x6) fail)))
        (case (succ x5) fail))))
(prove
  (forall ((a Nat) (b Nat) (c Nat) (d Nat))
    (= (op a b c d) (plus (plus (times a b) c) d))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (times x (times y z)) (times (times x y) z))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (plus x (plus y z)) (plus (plus x y) z))))
(assert (forall ((x Nat) (y Nat)) (= (times x y) (times y x))))
(assert (forall ((x Nat) (y Nat)) (= (plus x y) (plus y x))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (times x (plus y z)) (plus (times x y) (times x z)))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (times (plus x y) z) (plus (times x z) (times y z)))))
(assert (forall ((x Nat)) (= (times x (succ zero)) x)))
(assert (forall ((x Nat)) (= (times (succ zero) x) x)))
(assert (forall ((x Nat)) (= (plus x zero) x)))
(assert (forall ((x Nat)) (= (plus zero x) x)))
(assert (forall ((x Nat)) (= (times x zero) zero)))
(assert (forall ((x Nat)) (= (times zero x) zero)))
