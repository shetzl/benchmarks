(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (S (proj1-S Nat)) (Z))))
(define-fun-rec
  (par (a)
    (length
       ((x (list a))) Nat
       (match x
         (case nil Z)
         (case (cons y xs) (S (length xs)))))))
(define-fun-rec
  (par (a)
    (++
       ((x (list a)) (y (list a))) (list a)
       (match x
         (case nil y)
         (case (cons z xs) (cons z (++ xs y)))))))
(define-fun-rec
  (par (a)
    (rotate
       ((x Nat) (y (list a))) (list a)
       (match x
         (case (S z)
           (match y
             (case nil (_ nil a))
             (case (cons x2 x3) (rotate z (++ x3 (cons x2 (_ nil a)))))))
         (case Z y)))))
(prove
  (forall ((xs (list Nat)) (ys (list Nat)))
    (=> (= (length xs) (length ys))
      (=> (= (rotate (length xs) (++ xs ys)) (++ xs ys)) (= xs ys)))))
