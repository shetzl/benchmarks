; Property from "Productive Use of Failure in Inductive Proof",
; Andrew Ireland and Alan Bundy, JAR 1996
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-funs-rec
  ((par (a) (length ((x (list a))) Nat)))
  ((match x
     (case nil Z)
     (case (cons y xs) (S (length xs))))))
(define-funs-rec
  ((even ((x Nat)) bool))
  ((match x
     (case Z true)
     (case (S y)
       (match y
         (case Z false)
         (case (S z) (even z)))))))
(define-funs-rec
  ((par (a) (append ((x (list a)) (y (list a))) (list a))))
  ((match x
     (case nil y)
     (case (cons z xs) (cons z (append xs y))))))
(assert-not
  (par (a) (forall ((x (list a))) (even (length (append x x))))))
(check-sat)
