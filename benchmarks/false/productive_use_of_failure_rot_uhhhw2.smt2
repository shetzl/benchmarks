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
(prove
  (forall ((xs (list Nat)) (ys (list Nat)))
    (=> (= (length xs) (length ys)) (= xs ys))))
