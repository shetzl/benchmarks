; List monad laws
;
; Here, weird_concat is a somewhat sensible concatenation function,
; and has a somewhat strange recursion pattern.
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(define-funs-rec
  ((par (a) (weird_concat ((x (list (list a)))) (list a))))
  ((match x
     (case nil (as nil (list a)))
     (case (cons y xss)
       (match y
         (case nil (weird_concat xss))
         (case (cons z xs) (cons z (weird_concat (cons xs xss)))))))))
(define-funs-rec
  ((par (a) (append ((x (list a)) (y (list a))) (list a))))
  ((match x
     (case nil y)
     (case (cons z xs) (cons z (append xs y))))))
(define-funs-rec
  ((par (a) (concat2 ((x (list (list a)))) (list a))))
  ((match x
     (case nil (as nil (list a)))
     (case (cons xs xss) (append xs (concat2 xss))))))
(assert-not
  (par (a)
    (forall ((x (list (list a)))) (= (concat2 x) (weird_concat x)))))
(check-sat)
