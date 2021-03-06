; The implementation of these integers correspond to those in the
; Agda standard library, which is proved to be a commutative ring
(declare-datatypes () ((Sign (Pos) (Neg))))
(declare-datatypes () ((Nat (zero) (succ (p Nat)))))
(declare-datatypes ()
  ((Integer (P (proj1-P Nat)) (N (proj1-N Nat)))))
(define-fun
  toInteger
    ((x Sign) (y Nat)) Integer
    (match x
      (case Pos (P y))
      (case Neg
        (match y
          (case zero (P zero))
          (case (succ z) (N z))))))
(define-fun
  sign
    ((x Integer)) Sign
    (match x
      (case (P y) Pos)
      (case (N z) Neg)))
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
(define-fun
  opposite
    ((x Sign)) Sign
    (match x
      (case Pos Neg)
      (case Neg Pos)))
(define-fun
  timesSign
    ((x Sign) (y Sign)) Sign
    (match x
      (case Pos y)
      (case Neg (opposite y))))
(define-fun one () Integer (P (succ zero)))
(define-fun
  absVal
    ((x Integer)) Nat
    (match x
      (case (P n) n)
      (case (N m) (plus (succ zero) m))))
(define-fun
  times
    ((x Integer) (y Integer)) Integer
    (toInteger (timesSign (sign x) (sign y))
      (times2 (absVal x) (absVal y))))
(prove (forall ((x Integer)) (= x (times one x))))
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
