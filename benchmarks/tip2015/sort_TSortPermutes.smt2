; Tree sort
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes ()
  ((Tree
     (TNode (proj1-TNode Tree) (proj2-TNode Int) (proj3-TNode Tree))
     (TNil))))
(define-fun-rec
  flatten
    ((x Tree) (y (list Int))) (list Int)
    (match x
      (case (TNode p z q) (flatten p (cons z (flatten q y))))
      (case TNil y)))
(define-fun-rec
  (par (a)
    (elem
       ((x a) (y (list a))) Bool
       (match y
         (case nil false)
         (case (cons z xs) (or (= z x) (elem x xs)))))))
(define-fun-rec
  (par (a)
    (deleteBy
       ((x (=> a (=> a Bool))) (y a) (z (list a))) (list a)
       (match z
         (case nil (_ nil a))
         (case (cons y2 ys)
           (ite (@ (@ x y) y2) ys (cons y2 (deleteBy x y ys))))))))
(define-fun-rec
  (par (a)
    (isPermutation
       ((x (list a)) (y (list a))) Bool
       (match x
         (case nil
           (match y
             (case nil true)
             (case (cons z x2) false)))
         (case (cons x3 xs)
           (and (elem x3 y)
             (isPermutation xs
               (deleteBy (lambda ((x4 a)) (lambda ((x5 a)) (= x4 x5)))
                 x3 y))))))))
(define-fun-rec
  add
    ((x Int) (y Tree)) Tree
    (match y
      (case (TNode p z q)
        (ite (<= x z) (TNode (add x p) z q) (TNode p z (add x q))))
      (case TNil (TNode TNil x TNil))))
(define-fun-rec
  toTree
    ((x (list Int))) Tree
    (match x
      (case nil TNil)
      (case (cons y xs) (add y (toTree xs)))))
(define-fun
  tsort ((x (list Int))) (list Int) (flatten (toTree x) (_ nil Int)))
(prove (forall ((xs (list Int))) (isPermutation (tsort xs) xs)))
