(declare-datatypes (a b)
  ((pair (pair2 (proj1-pair a) (proj2-pair b)))))
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(define-fun-rec
  (par (a)
    (select
       ((x a) (y (list (pair a (list a))))) (list (pair a (list a)))
       (match y
         (case nil (_ nil (pair a (list a))))
         (case (cons z x2)
           (match z
             (case (pair2 y2 ys)
               (cons (pair2 y2 (cons x ys)) (select x x2)))))))))
(define-fun-rec
  (par (a)
    (select2
       ((x (list a))) (list (pair a (list a)))
       (match x
         (case nil (_ nil (pair a (list a))))
         (case (cons y xs) (cons (pair2 y xs) (select y (select2 xs))))))))
(define-fun-rec
  (par (a)
    (formula
       ((x (list (pair a (list a))))) (list (list a))
       (match x
         (case nil (_ nil (list a)))
         (case (cons y z)
           (match y (case (pair2 y2 ys) (cons (cons y2 ys) (formula z)))))))))
(define-fun-rec
  (par (a)
    (count
       ((x a) (y (list a))) Int
       (match y
         (case nil 0)
         (case (cons z ys)
           (ite (= x z) (+ 1 (count x ys)) (count x ys)))))))
(define-fun-rec
  (par (a)
    (all
       ((p (=> a Bool)) (x (list a))) Bool
       (match x
         (case nil true)
         (case (cons y xs) (and (@ p y) (all p xs)))))))
(prove
  (par (a)
    (forall ((xs (list a)) (z a))
      (all (lambda ((x (list a))) (= (count z xs) (count z x)))
        (formula (select2 xs))))))
