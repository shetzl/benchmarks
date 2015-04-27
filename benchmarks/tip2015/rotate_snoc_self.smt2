; Rotate expressed using a snoc instead of append
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-funs-rec
  ((par (a) (snoc ((x a) (y (list a))) (list a))))
  ((match y
     (case nil (cons x y))
     (case (cons z ys) (cons z (snoc x ys))))))
(define-funs-rec
  ((par (a) (rotate ((x Nat) (y (list a))) (list a))))
  ((match x
     (case Z y)
     (case (S z)
       (match y
         (case nil y)
         (case (cons x2 x3) (rotate z (snoc x2 x3))))))))
(define-funs-rec
  ((par (a) (append ((x (list a)) (y (list a))) (list a))))
  ((match x
     (case nil y)
     (case (cons z xs) (cons z (append xs y))))))
(assert-not
  (par (a)
    (forall ((n Nat) (xs (list a)))
      (= (rotate n (append xs xs))
        (append (rotate n xs) (rotate n xs))))))
(check-sat)
