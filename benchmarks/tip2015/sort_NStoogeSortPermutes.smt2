; Stooge sort defined using reverse and thirds on natural numbers
(declare-datatypes (a b)
  ((pair (pair2 (proj1-pair a) (proj2-pair b)))))
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(define-fun-rec
  third
    ((x Int)) Int
    (ite
      (= x 2) 0 (ite (= x 1) 0 (ite (= x 0) 0 (+ 1 (third (- x 3)))))))
(define-fun-rec
  (par (a)
    (take
       ((x Int) (y (list a))) (list a)
       (ite
         (<= x 0) (_ nil a)
         (match y
           (case nil (_ nil a))
           (case (cons z xs) (cons z (take (- x 1) xs))))))))
(define-fun
  sort2
    ((x Int) (y Int)) (list Int)
    (ite
      (<= x y) (cons x (cons y (_ nil Int)))
      (cons y (cons x (_ nil Int)))))
(define-fun-rec
  (par (a)
    (length
       ((x (list a))) Int
       (match x
         (case nil 0)
         (case (cons y l) (+ 1 (length l)))))))
(define-fun-rec
  (par (a)
    (elem
       ((x a) (y (list a))) Bool
       (match y
         (case nil false)
         (case (cons z xs) (or (= z x) (elem x xs)))))))
(define-fun-rec
  (par (a)
    (drop
       ((x Int) (y (list a))) (list a)
       (ite
         (<= x 0) y
         (match y
           (case nil (_ nil a))
           (case (cons z xs1) (drop (- x 1) xs1)))))))
(define-fun
  (par (a)
    (splitAt
       ((x Int) (y (list a))) (pair (list a) (list a))
       (pair2 (take x y) (drop x y)))))
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
  (par (a)
    (++
       ((x (list a)) (y (list a))) (list a)
       (match x
         (case nil y)
         (case (cons z xs) (cons z (++ xs y)))))))
(define-fun-rec
  (par (a)
    (reverse
       ((x (list a))) (list a)
       (match x
         (case nil (_ nil a))
         (case (cons y xs) (++ (reverse xs) (cons y (_ nil a))))))))
(define-funs-rec
  ((nstooge1sort2 ((x (list Int))) (list Int))
   (nstoogesort ((x (list Int))) (list Int))
   (nstooge1sort1 ((x (list Int))) (list Int)))
  ((match (splitAt (third (length x)) (reverse x))
     (case (pair2 ys1 zs1) (++ (nstoogesort zs1) (reverse ys1))))
   (match x
     (case nil (_ nil Int))
     (case (cons y z)
       (match z
         (case nil (cons y (_ nil Int)))
         (case (cons y2 x2)
           (match x2
             (case nil (sort2 y y2))
             (case (cons x3 x4)
               (nstooge1sort2 (nstooge1sort1 (nstooge1sort2 x)))))))))
   (match (splitAt (third (length x)) x)
     (case (pair2 ys1 zs) (++ ys1 (nstoogesort zs))))))
(prove
  (forall ((xs (list Int))) (isPermutation (nstoogesort xs) xs)))
