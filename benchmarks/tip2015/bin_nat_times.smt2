; Property about natural numbers with binary presentation
(declare-datatypes () ((Nat (zero) (succ (p Nat)))))
(declare-datatypes ()
  ((Bin (One)
     (ZeroAnd (proj1-ZeroAnd Bin)) (OneAnd (proj1-OneAnd Bin)))))
(define-fun-rec
  s ((x Bin)) Bin
    (match x
      (case One (ZeroAnd One))
      (case (ZeroAnd xs) (OneAnd xs))
      (case (OneAnd ys) (ZeroAnd (s ys)))))
(define-fun-rec
  plus2
    ((x Bin) (y Bin)) Bin
    (match x
      (case One (s y))
      (case (ZeroAnd z)
        (match y
          (case One (s x))
          (case (ZeroAnd ys) (ZeroAnd (plus2 z ys)))
          (case (OneAnd xs) (OneAnd (plus2 z xs)))))
      (case (OneAnd x2)
        (match y
          (case One (s x))
          (case (ZeroAnd zs) (OneAnd (plus2 x2 zs)))
          (case (OneAnd ys2) (ZeroAnd (s (plus2 x2 ys2))))))))
(define-fun-rec
  times
    ((x Bin) (y Bin)) Bin
    (match x
      (case One y)
      (case (ZeroAnd xs1) (ZeroAnd (times xs1 y)))
      (case (OneAnd xs12) (plus2 (ZeroAnd (times xs12 y)) y))))
(define-fun-rec
  plus
    ((x Nat) (y Nat)) Nat
    (match x
      (case zero y)
      (case (succ z) (succ (plus z y)))))
(define-fun-rec
  times2
    ((x Nat) (y Nat)) Nat
    (match x
      (case zero zero)
      (case (succ z) (plus y (times2 z y)))))
(define-fun-rec
  toNat
    ((x Bin)) Nat
    (match x
      (case One (succ zero))
      (case (ZeroAnd xs) (plus (toNat xs) (toNat xs)))
      (case (OneAnd ys)
        (plus (plus (succ zero) (toNat ys)) (toNat ys)))))
(prove
  (forall ((x Bin) (y Bin))
    (= (toNat (times x y)) (times2 (toNat x) (toNat y)))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (times2 x (times2 y z)) (times2 (times2 x y) z))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (plus x (plus y z)) (plus (plus x y) z))))
(assert (forall ((x Nat) (y Nat)) (= (times2 x y) (times2 y x))))
(assert (forall ((x Nat) (y Nat)) (= (plus x y) (plus y x))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (times2 x (plus y z)) (plus (times2 x y) (times2 x z)))))
(assert
  (forall ((x Nat) (y Nat) (z Nat))
    (= (times2 (plus x y) z) (plus (times2 x z) (times2 y z)))))
(assert (forall ((x Nat)) (= (times2 x (succ zero)) x)))
(assert (forall ((x Nat)) (= (times2 (succ zero) x) x)))
(assert (forall ((x Nat)) (= (plus x zero) x)))
(assert (forall ((x Nat)) (= (plus zero x) x)))
(assert (forall ((x Nat)) (= (times2 x zero) zero)))
(assert (forall ((x Nat)) (= (times2 zero x) zero)))
