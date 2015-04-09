; List monad laws
(declare-datatypes
  (a) ((list (nil) (cons (head a) (tail (list a))))))
(define-funs-rec
  ((par
     (a2) (return ((x a2)) (list a2) (cons x (as nil (list a2)))))))
(define-funs-rec
  ((par
     (a4)
     (append
        ((x5 (list a4)) (x6 (list a4))) (list a4)
        (match x5
          (case nil x6)
          (case (cons x7 xs2) (cons x7 (as (append xs2 x6) (list a4)))))))))
(define-funs-rec
  ((par
     (a3 b)
     (bind
        ((x2 (list a3)) (x3 (=> a3 (list b)))) (list b)
        (match x2
          (case nil (as nil (list b)))
          (case
            (cons x4 xs) (append (@ x3 x4) (as (bind xs x3) (list b)))))))))
(declare-sort a5 0)
(assert
  (not
    (forall
      ((xs3 (list a5)))
      (= (bind xs3 (lambda ((x8 a5)) (return x8))) xs3))))
(check-sat)