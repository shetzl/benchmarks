; Top-down merge sort, using division by two on natural numbers
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-funs-rec
  ((par (a) (take ((x Nat) (y (list a))) (list a))))
  ((match x
     (case Z (as nil (list a)))
     (case (S z)
       (match y
         (case nil y)
         (case (cons x2 x3) (cons x2 (take z x3))))))))
(define-funs-rec
  ((lmerge ((x (list Int)) (y (list Int))) (list Int)))
  ((match x
     (case nil y)
     (case (cons z x2)
       (match y
         (case nil x)
         (case (cons x3 x4)
           (ite
             (<= z x3) (cons z (lmerge x2 y)) (cons x3 (lmerge x x4)))))))))
(define-funs-rec
  ((par (t) (length ((x (list t))) Nat)))
  ((match x
     (case nil Z)
     (case (cons y xs) (S (length xs))))))
(define-funs-rec
  ((half ((x Nat)) Nat))
  ((match x
     (case Z x)
     (case (S y)
       (match y
         (case Z y)
         (case (S n) (S (half n))))))))
(define-funs-rec
  ((par (a) (drop ((x Nat) (y (list a))) (list a))))
  ((match x
     (case Z y)
     (case (S z)
       (match y
         (case nil y)
         (case (cons x2 x3) (drop z x3)))))))
(define-funs-rec
  ((nmsorttd ((x (list Int))) (list Int)))
  ((match x
     (case nil x)
     (case (cons y z)
       (match z
         (case nil x)
         (case (cons x2 x3)
           (lmerge (nmsorttd (take (half (length x)) x))
             (nmsorttd (drop (half (length x)) x)))))))))
(define-funs-rec
  ((count ((x Int) (y (list Int))) Nat))
  ((match y
     (case nil Z)
     (case (cons z xs) (ite (= x z) (S (count x xs)) (count x xs))))))
(assert-not
  (forall ((x Int) (y (list Int)))
    (= (count x (nmsorttd y)) (count x y))))
(check-sat)