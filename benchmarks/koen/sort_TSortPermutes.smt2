; Tree sort
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes (a)
  ((Tree (TNode (TNode_0 (Tree a)) (TNode_1 a) (TNode_2 (Tree a)))
     (TNil))))
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-funs-rec
  ((par (a) (flatten ((x (Tree a)) (y (list a))) (list a))))
  ((match x
     (case (TNode q z q2) (flatten q (cons z (flatten q2 y))))
     (case TNil y))))
(define-funs-rec
  ((par (b c a) (dot ((x (=> b c)) (y (=> a b)) (z a)) c)))
  ((@ x (@ y z))))
(define-funs-rec
  ((count ((x Int) (y (list Int))) Nat))
  ((match y
     (case nil Z)
     (case (cons z xs) (ite (= x z) (S (count x xs)) (count x xs))))))
(define-funs-rec
  ((add ((x Int) (y (Tree Int))) (Tree Int)))
  ((match y
     (case (TNode q z q2)
       (ite (<= x z) (TNode (add x q) z q2) (TNode q z (add x q2))))
     (case TNil (TNode y x y)))))
(define-funs-rec
  ((toTree ((x (list Int))) (Tree Int)))
  ((match x
     (case nil (as TNil (Tree Int)))
     (case (cons y xs) (add y (toTree xs))))))
(define-funs-rec
  ((tsort ((x (list Int))) (list Int)))
  ((dot
   (lambda ((y (=> (list Int) (list Int)))) (@ y (as nil (list Int))))
     (lambda ((z (list Int)))
       (dot
       (lambda ((x2 (Tree Int)))
         (lambda ((x3 (list Int))) (flatten x2 x3)))
         (lambda ((x4 (list Int))) (toTree x4)) z))
     x)))
(assert-not
  (forall ((x Int) (y (list Int)))
    (= (count x (tsort y)) (count x y))))
(check-sat)